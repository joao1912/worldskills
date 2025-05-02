# Define variáveis
BUCKET_NAME="refund-bucket"
PREFIX=""  # caso seus arquivos estejam em uma "pasta", senão deixe vazio
TMP_DIR="/tmp/refunds"

mkdir -p "$TMP_DIR"

# Lista os arquivos no S3 e armazena os nomes dos arquivos em FILES
FILES=$(aws s3 ls "s3://${BUCKET_NAME}/${PREFIX}" | awk '{print $4}')

# Verifica se o bucket está vazio
if [ -z "$FILES" ]; then
  echo "Nenhum arquivo encontrado no bucket. Encerrando script."
  exit 0
fi

# Baixa os arquivos do S3
echo "$FILES" | while read FILE; do
  aws s3 cp "s3://${BUCKET_NAME}/${PREFIX}${FILE}" "$TMP_DIR/$FILE"
done

# Itera sobre os arquivos baixados
for file in "$TMP_DIR"/*; do
  echo "Processando $file"

  ORDER_ID=$(cat "$file" | tr -d '\n' | tr -d '\r')  # remove quebras de linha

  # Define valores fixos
  GAME_ID="FIXED_GAME_ID"
  TEAM_ID="FIXED_TEAM_ID"

  echo $ORDER_ID

  # Faz a requisição
  curl -i -H "Accept: application/json" \
       -H "Content-Type: application/json" \
       -X POST \
       -d "{\"game\": \"$GAME_ID\", \"team\": \"$TEAM_ID\", \"order\": \"$ORDER_ID\"}" \
       https://p3e1zk2wr1.execute-api.us-east-1.amazonaws.com/prod/post

  # Apaga o arquivo do S3
  aws s3 rm "s3://${BUCKET_NAME}/${PREFIX}$(basename "$file")"

  # Apaga o arquivo local
  rm -f "$file"
done