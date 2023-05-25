# Implementação da Infraestrutura EKS na Nuvem

Para realizar a implementação da infraestrutura EKS na nuvem, é necessário cumprir as seguintes premissas:

- Possuir AWS CLI
- Ter AWS IAM Authenticator
- Dispor de Kubectl
- Ter Terraform
- Configurar um Key Pair na AWS
- Instalar Visual Studio Code

## Guia Passo a Passo para Instalação e Configuração do AWS CLI, Terraform e Kubectl:

1. Comece o processo instalando o Terraform. As instruções passo a passo para esta ação estão disponíveis no link: [Instalar Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

2. Após a instalação do Terraform, prossiga com a instalação e configuração do AWS CLI. Você pode encontrar as instruções detalhadas neste link: [Instalar AWS CLI](https://aws.amazon.com/cli/).

3. Com o AWS CLI instalado, abra o terminal e digite o seguinte comando: **aws configure**

4. Ao ser solicitado, insira suas credenciais da AWS, incluindo o ID de Chave de Acesso e a Chave de Acesso Secreta. Estes detalhes estão disponíveis na seção "Credenciais de Segurança" do seu Console AWS ou você pode solicitar ao administrador da sua conta AWS. Lembre-se também de informar a região desejada, neste caso, a "us-east-1". Caso prefira, pressione ENTER para utilizar as configurações padrão.

5. Prossiga com a instalação do AWS IAM Authenticator. Você pode seguir as orientações neste link: [Instalar AWS IAM AUTHENTICATOR](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

6. Instale o Kubectl seguindo as instruções detalhadas encontradas aqui: [Instalar Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

7. Por último, instale o Visual Studio Code a partir do seguinte link: [Instalar Visual Studio Code](https://code.visualstudio.com/download).

Após a instalação das ferramentas necessárias, você deverá criar seu key pair no EC2 por meio do comando abaixo:

`aws ec2 create-key-pair --key-name nome_do_seu_key_pair`

No Visual Studio Code, abra o projeto e faça as substituições necessárias no arquivo `eks.tf`:

- Substitua `key_name = "teste"` por `key_name = "nome_do_seu_key_pair"`
- Substitua `cluster_name    = "cluster-teste-eks"` por `cluster_name    = "nome_do_seu_cluster_eks"`

Ainda no Visual Studio Code, substitua `bucket = "bucket-teste-cloud"` por `bucket        = "nome-do-seu-bucket"` no arquivo `cloudtrail.tf`. Lembre-se que o nome do seu bucket deve ser único na AWS.

Feitas as alterações, execute os seguintes comandos em sequência:

- `$ terraform init`
- `$ terraform plan`
- `$ terraform apply`

Depois, execute o comando apropriado para o seu sistema operacional para configurar o Kubeconfig:

- No Linux/MacOS: `export KUBECONFIG=/caminho/da/pasta/kubeconfig_nome_do_meu_cluster`
- No Windows (CMD): `set KUBECONFIG=/caminho/da/pasta/kubeconfig_nome_do_meu_cluster`
- No Windows (Powershell): `$env:KUBECONFIG = "/caminho/da/pasta/kubeconfig_nome_do_meu_cluster"`

Realize a seguinte operação:

`aws eks --region us-east-1 update-kubeconfig --name nome_do_meu_cluster`

Agora, você está pronto para usar os comandos `kubectl` em seu aplicativo.

Para lançar a aplicação de teste (neste caso, o NGINX), utilize este comando:

`kubectl apply -f deployment.yaml`

Após a execução, a aplicação será hospedada na AWS. Para confirmar, acesse o site da AWS ou utilize o AWS CLI com o comando `kubectl get pods`.

Se tudo estiver correto, o retorno será algo como:

NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-xxxxx   1/1     Running   0          66s

Para disponibilizar e usar o seu serviço, aplique o seguinte comando:

`kubectl apply -f service.yaml`

Em seguida, verifique se o serviço do seu aplicativo está ativo com o seguinte comando:

`kubectl get services`

A saída será algo parecido com isso:

NAME            TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
kubernetes      ClusterIP      xxx.xx.x.x      <none>           xxx/TCP        39m
nginx-service   LoadBalancer   xxx.xx.xx.xxx   link_pro_seu_servico  xx:xxxxx/TCP   5s

Para visualizar o aplicativo, utilize o link da AWS fornecido no campo *EXTERNAL-IP* do comando anterior.

Parabéns! Seu aplicativo NGINX está agora rodando em seu cluster EKS.

Você também pode usar o CloudTrail para monitorar seu cluster EKS através do bucket e verificar os 5 eventos:

- Para verificar se tudo está funcionando:

`aws cloudtrail describe-trails`

- Para visualizar os logs do CloudTrail:

`aws s3 ls s3://nome_do_seu_bucket/AWSLogs/account_id/CloudTrail/region/YYYY/MM/DD/`

- Escolha um dos logs no formato json.gz:

`aws s3 cp s3://nome_do_seu_bucket/AWSLogs/account_id/CloudTrail/region/YYYY/MM/DD/logfile.json .`

Substitua "logfile.json" pelo nome do arquivo JSON que desejar. O arquivo será baixado para o diretório atual do seu terminal.

Descompacte o arquivo na sua máquina e visualize o log do CloudTrail. Nele, estará registrado 1 dos 5 eventos gerados pelo Terraform.

Ao terminar de usar a infraestrutura, utilize o comando abaixo para eliminar o serviço:

`kubectl delete service nome_do_servico`

Por fim, execute o seguinte comando para destruir a infraestrutura criada:

`terraform destroy`

Para finalizar, delete seu key pair:

`aws ec2 delete-key-pair --key-name nome_da_chave`
