# Desafio — A-B-C, Setting up services is easy as 1-2-3

## Objetivo 1

Criar uma instância EC2.

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **EC2**.
2. Clique em **Lançar Instância** (Launch Instance).
3. Configure os detalhes da instância:

   * **Nome da instância**: Defina um nome descritivo.
   * **Chave SSH**: Selecione a opção **Proceder sem um par de chaves** (sem SSH key pair).
   * **Rede**: Selecione **qualquer VPC** e **qualquer sub-rede** disponível na região.


## Objetivo 2

Criar um bucket no S3.

---

## Passo a passo

1. Acesse o **Console AWS** e abra o serviço **S3**.
2. Clique em **Criar bucket**.
3. Insira um **nome único** para o bucket.


## Objetivo 3

Criar uma função Lambda utilizando uma role IAM já existente.

---

## Passo a passo

1. Acesse o **Console AWS** e vá até o serviço **Lambda**.
2. Na criação da função, mantenha a opção **Criar do zero (Author from scratch)** selecionada.
3. Insira um **nome para a função**.
4. Selecione a **linguagem** desejada no campo de runtime.
5. Expanda a opção **Alterar execução de role padrão (Change default execution role)**:

   * Selecione **Use an existing role** (Usar uma role existente).
   * Escolha a **role especificada** para essa Lambda.
6. Clique no botão **Criar função (Create function)**.

---