

Criar uma aplicação chamada colors em nodejs, que recebe  uma variável de ambiente chamada BG_COLOR, que pode assumir o valor BLUE e RED, que quando acessada pela rota / ela abre uma página vazia com a cor de fundo especificada pela variável.

Containerize essa aplicação;

Colocar essas imagens no Dockerhub;

Utilizando o Minikube faça:

Crie dois deployments no kubernetes, um chamado blue-deployment e outro chamado red-deployment, todos eles usaram a mesma imagem de container que foi recentemente criada, so que elas irão receber a variável BG_COLOR a partir de uma Secret do Kubernetes, com os respectivo valores de cor.

Criar um nginx configurado por meio de um configmap que sirva de proxy reverso, sermpre que o container do nginx for acessado com /blue ele direciona para o deployment BLUE e sempre que o container do nginx for acessado na rota /red vá para o deployment vermelho.

