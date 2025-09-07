# Desafio — Build Restful API

## Objetivo 1

Criar uma API REST no **API Gateway** integrada a uma função **Lambda**.

---

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **API Gateway**.
2. Clique em **Create an API**.
3. Selecione **Build** em **REST API**.
4. Mantenha a opção **New API** selecionada.
5. No campo **API name**, insira um nome para sua API.
6. Clique em **Create API**.
7. Dentro da API criada, clique em **Create resource**.
8. Ative a opção **Proxy resource**.
9. No campo **Resource name**, insira: {proxy+}
10. Clique em **Create resource**.
11. Selecione o método **ANY**.
12. Clique em **Edit integration**.
13. Ative a opção **Lambda proxy integration**.
14. Selecione a **função Lambda** que deve ser integrada ao API Gateway.
15. Clique em **Save**.
16. Clique no botão **Deploy API**.
17. Em **Stage**, selecione **New stage**.
18. Defina um nome para o stage.
19. Clique em **Deploy**.

---

## Objetivo 2

Armazenar as informações dos usuários no **DynamoDB**.  

*(incompleto)*  

