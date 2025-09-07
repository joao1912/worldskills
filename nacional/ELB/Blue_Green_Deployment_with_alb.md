# Desafio — Blue/Green Deployments with ALB

## Objetivo 1

Acessar o ALB e visualizar as regras do listener.

---

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **EC2**.
2. Vá até a seção **Load Balancers**.
3. Selecione o **Application Load Balancer (ALB)** desejado.
4. Clique em **Listener**.
5. Selecione a **regra** configurada.
6. Clique no botão **Actions** e em seguida **Edit rule**.
7. Na página de edição, em **Ação padrão**, verifique as porcentagens de redirecionamento de tráfego.

---

## Objetivo 2

Redirecionar todo o tráfego para o **Green Deployment**.

---

## Passo a passo

1. Na página da regra do **Listener**, localize as porcentagens de redirecionamento de tráfego.
2. Configure:
   * **Target Group Green**: `100`
   * **Target Group Blue**: `0`
3. Clique em **Save changes**.

---

## Objetivo 3

Atualizar a função **Lambda** utilizada pelo ALB.

---

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **Lambda**.
2. Selecione a função Lambda utilizada como destino do ALB.
3. Na seção **Code**, altere o trecho que exibe a mensagem na tela (por exemplo, de `'Hello Jam'` para outro valor).
4. Clique no botão **Deploy**.
5. Vá até a seção **Versions**.
6. Clique em **Publish new version**.
7. Confirme clicando em **Publish**.

---

## Objetivo 4

Reverter o tráfego para o **Blue Deployment** e atualizar o alias da Lambda.

---

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **EC2**.
2. Vá até a seção **Load Balancers**.
3. Selecione o **Application Load Balancer (ALB)**.
4. Clique em **Listener**.
5. Selecione a **regra** configurada.
6. Clique no botão **Actions** e em seguida **Edit rule**.
7. Altere as porcentagens de redirecionamento para:
   * **Target Group Green**: `0`
   * **Target Group Blue**: `100`
8. Clique em **Save changes**.
9. Acesse novamente o **Console AWS** e abra o serviço **Lambda**.
10. Selecione a função Lambda utilizada como destino do ALB.
11. Vá até a seção **Aliases**.
12. Clique no alias **blue**.
13. Clique em **Edit**.
14. Altere a versão para **3**.
15. Clique em **Save**.
