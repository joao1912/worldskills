# Desafio — Lambda PI

## Objetivo 1

Ajustar o retorno da função Lambda utilizada pelo **API Gateway**.

---

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **Lambda**.
2. Selecione a **função utilizada pelo API Gateway**.
3. Na seção **Code**, ajuste o formato do retorno da função para um formato válido, por exemplo:

   ```python
   return {
       'statusCode': 200,
       'headers': {
           'Content-Type': 'application/json'
       },
       'body': json.dumps({
           'secret': secret_content
       }),
       'isBase64Encoded': False
   }

4. Garanta que a biblioteca json esteja sendo importada no início do código