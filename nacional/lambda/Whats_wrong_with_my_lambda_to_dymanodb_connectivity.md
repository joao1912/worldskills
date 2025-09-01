# Desafio — Whats wrong with my lambda to dymanodb connectivity?

## Objetivo

Ajustar as permissões da função (IAM Role) associada à Lambda para permitir que a função acesse corretamente a tabela no DynamoDB.



## Passo a passo

1. Acesse o **Console AWS** e vá até o serviço **IAM**.
2. Localize e abra a **Role** associada à função Lambda que realiza a consulta à tabela do DynamoDB.
3. Edite a **Policy** anexada à Role.
4. Verifique se o bloco de permissões contém o recurso (`Resource`) corretamente configurado para a tabela do DynamoDB.
5. Ajuste a linha do `Resource` para referenciar a tabela correta.

Exemplo de configuração:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "dynamodb:*",
      "Resource": "arn:aws:dynamodb:us-east-1:123456789012:table/MinhaTabela"
    },
    {
      "Effect": "Allow",
      "Action": "logs:*",
      "Resource": "*"
    }
  ]
}
```
