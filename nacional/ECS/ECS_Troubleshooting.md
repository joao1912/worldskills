# Desafio — ECS Troubleshooting

## Objetivo

Criar um novo serviço ECS em uma nova VPC, configurar uma ECS Task, e baixar os binários de um bucket para executar a aplicação containerizada.

## Passo a passo

### Criar a VPC

1. Acesse o **Console AWS** → **VPC**.
2. Clique em **Criar VPC**.
3. Selecione **VPC and more**.
4. Insira um nome, por exemplo: `VPC A`.
5. Na definição de NAT Gateway, selecione **in 1 AZ**.
6. Clique em **Criar VPC**.

### Criar Grupos de Segurança

1. Vá até **Security Groups** dentro da VPC criada.
2. Crie os seguintes grupos:

   * **SG-ALB**: libere a porta HTTP exposta pelo binário.
   * **SG-App**: libere a porta de execução da aplicação para o SG-ALB e habilite SSH para **My IP**.
   * **SG-EFS**: libere acesso NFS para o **SG-App**.

### Criar uma instância EC2

1. Vá ao **Console AWS** → **EC2**.
2. Clique em **Criar instância**.
3. Configure:

   * Nome da instância
   * Chave SSH: selecione uma existente ou crie uma nova.
   * Rede: selecione a VPC criada anteriormente.
   * Sub-rede: selecione uma sub-rede pública.
   * IP público: habilite a associação automática.
   * Grupo de segurança: selecione o **SG-App**.
4. Crie a instância.

### Configurar o Load Balancer

1. Vá em **Load Balancers** → **Criar Load Balancer** → tipo **ALB**.
2. Insira um nome.
3. Selecione a VPC criada e associe sub-redes públicas.
4. Associe o **SG-ALB**.
5. Vá em **Listeners** → **Criar Target Group** → tipo **IP Address**.
6. Nomeie o grupo, defina a porta da aplicação, e clique em **Criar**.
7. Volte à configuração do ALB e associe o grupo de destino.
8. Crie o Load Balancer.

### Criar Repositório no ECR

1. Vá em **ECR** → **Criar Repositório**.
2. Nomeie o repositório.
3. Acesse-o e copie os **push commands** para subir a imagem.

### Preparar a instância EC2

1. Conecte-se via SSH.
2. Baixe os binários:

   ```bash
   wget https://link-para-binario
   unzip binario.zip
   ```
3. Crie o arquivo de configuração exigido pelo binário:

   ```bash
   vim config.json
   ```

   Exemplo:

   ```json
   {
     "efs_path": "/server/",
     "server_port": 8082
   }
   ```
4. Teste o binário:

   ```bash
   ./binario
   ```
5. Instale e inicie o Docker:

   ```bash
   sudo yum install -y docker
   sudo systemctl start docker
   ```
6. Crie um Dockerfile, containerize o binário e suba a imagem para o repositório ECR.

### Configurar o EFS

1. Vá em **EFS** → **Criar Sistema de Arquivos**.
2. Insira um nome e crie.
3. Na configuração de rede:

   * Selecione a VPC criada.
   * Associe sub-redes e o **SG-EFS**.
4. Crie um ponto de acesso:

   * Defina diretório root igual ao usado pela aplicação.
   * Configure permissões POSIX conforme solicitado (Ex):

     * **POSIX User**: UID=1, GID=1, SecGID=0777
     * **Root Directory**: UID=2, GID=2, Permissões=0777

### Criar Cluster ECS

1. Vá em **ECS** → **Clusters** → **Criar Cluster**.
2. Nomeie o cluster.
3. Selecione tipo **Fargate**.
4. Expanda monitoramento e ative **Container Insights**.

### Criar Task Definition

1. Vá em **Task Definitions** → **Criar nova**.
2. Nomeie a task.
3. Selecione **Fargate**, configure CPU e memória.
4. Defina a role necessária.
5. Em **Containers**:

   * Nome do container.
   * **Image URI**: insira a URI do ECR.
   * **Port mapping**: configure a porta correta.
6. Em **Volumes**, adicione volume com tipo **EFS** e associe ao sistema de arquivos criado.
7. Ative criptografia em trânsito.

### Criar o Serviço ECS

1. Vá até **Clusters** e selecione o cluster criado.
2. Em **Services**, clique em **Criar**.
3. Configure:

   * Task Definition criada.
   * Nome do serviço.
   * Tipo de lançamento.
4. Em rede:

   * Selecione a VPC.
   * Sub-redes correspondentes ao EFS.
   * Grupo de segurança **SG-App**.
   * Desabilite IP público.
5. Expanda Load Balancer:

   * Selecione o ALB existente.
   * Listener e Target Group criados anteriormente.
6. Clique em **Criar**.

7. Copie o DNS do ALB e abra em outra aba do navegador.

## Objetivo

Criar uma **nova VPC** com um **bloco CIDR diferente** da já existente, para evitar conflitos, e provisionar um **novo sistema de arquivos EFS** associado a essa nova VPC.

### Criar a nova VPC
1. No **Console AWS**, abra o serviço **VPC** → **Your VPCs**.  
2. Clique em **Create VPC**.  
3. Selecione **VPC and more**.  
4. Preencha:
   - **Name tag**: `VPC-B` (exemplo).  
   - **IPv4 CIDR block**: escolha um bloco diferente da VPC existente (ex.: `10.2.0.0/16`).  
5. Configure NAT Gateway conforme necessário — por exemplo, **in 1 AZ** se for o mesmo padrão que você usou antes.  
6. Clique em **Create VPC**.

---

### Criar Security Group para o EFS
1. Em **VPC → Security Groups**, crie um SG que permita tráfego NFS (porta **2049**) a partir dos SGs de aplicação que irão montar o EFS.  
   - Nome exemplo: `sg-efs-b`  
   - Regra de entrada: Source = SG da aplicação (ou CIDR conforme sua topologia), Porta = 2049 (NFS).

---

### Criar o Sistema de Arquivos EFS
1. No **Console AWS**, abra **EFS → File systems**.  
2. Clique em **Create file system**.  
3. Preencha:
   - **Name**: `efs-b` (exemplo).  
4. Na configuração de rede (network):
   - **VPC**: selecione a **nova VPC** (`VPC-B`).  
   - **Subnets**: selecione as sub-redes de cada AZ.
   - **Security Group**: em cada AZ, associe o **SG do EFS** (`sg-efs-b`) que você criou.  
5. Clique em **Next** e então **Create** para criar o sistema de arquivos.

---

### Criar Access Point (Access Point)
1. Selecione o **File system** criado (`efs-b`) na lista do EFS.  
2. Vá até a aba **Access points**.  
3. Clique em **Create access point**.  
4. Preencha:
   - **Name**: `ap-efs-b` (exemplo).  
   - **Root directory**: defina o diretório root que a aplicação usará (deve ser o mesmo caminho usado pela aplicação), ex.: `/server/`.  
5. Em **POSIX User** preencha:
   - **User ID**: `1`  
   - **Group ID**: `1`  
   - **Secondary Group ID**: `0777`  
6. Em **Root Directory Creation Permissions** (ou similar) preencha:
   - **Owner User ID**: `2`  
   - **Group ID**: `2`  
   - **Access Point Permission**: `0777`  
7. Clique em **Create** para finalizar o access point.
