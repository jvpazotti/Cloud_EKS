# Implementação da Infraestrutura Cloud_EKS

Para efetivamente implementar a infraestrutura Cloud_EKS, é necessário satisfazer os seguintes requisitos:

- AWS CLI
- AWS IAM Authenticator
- Kubectl
- Terraform
- Key Pair na AWS
- Visual Studio Code

## Passo a passo para instalação e configuração do AWS CLI, Terraform e Kubectl:

1. Comece instalando o Terraform. As instruções detalhadas para esta etapa estão disponíveis aqui: [Instalar Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

2. Em seguida, instale e configure o AWS CLI. Os passos para esta tarefa podem ser encontrados em: [Instalar AWS CLI](https://aws.amazon.com/cli/).

3. Agora, abra o terminal de comando e execute o seguinte comando: **aws configure**

4. Quando o sistema pedir, informe suas credenciais da AWS. Isso inclui o Access Key ID e o Secret Access Key. Estas informações podem ser obtidas no Console AWS, na seção "Credenciais de segurança", ou com o administrador da sua conta AWS. Também será necessário informar a região, neste caso "us-east-1". Se preferir, simplesmente pressione ENTER para usar as configurações padrão.

5. Prossiga com a instalação do AWS IAM AUTHENTICATOR. As orientações podem ser encontradas aqui: [Instalar AWS IAM AUTHENTICATOR](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

6. Instale o Kubectl, seguindo os passos detalhados em: [Instalar Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

7. Configure o Key Pair na AWS para ser utilizado com o EC2.

8. Por último, instale o Visual Studio Code a partir do link: [Instalar Visual Studio Code](https://code.visualstudio.com/download).

No Visual Studio Code, abra o projeto e substitua a linha `key_name = "teste"` por `key_name = "nome_do_seu_key_pair"` no arquivo `eks.tf`.

Ao finalizar estas etapas, execute os comandos abaixo em ordem:

- `$ terraform init`
- `$ terraform plan`
- `$ terraform apply`

Logo após a execução destes comandos, é necessário modificar o arquivo `kubeconfig_my-eks-cluster`:

O conteúdo original da linha será: `apiVersion: client.authentication.k8s.io/v1alpha1`.

Substitua por: `apiVersion: client.authentication.k8s.io/v1beta1`.

Para finalizar, execute o seguinte comando no terminal (para Linux/MacOS): `export KUBECONFIG=/caminho/da/pasta/kubeconfig_my-eks-cluster`.

No Windows, o comando será no Powershell: `$env:KUBECONFIG = "/caminho/da/pasta/kubeconfig_my-eks-cluster"` 

Ou no CMD: `set KUBECONFIG=/caminho/da/pasta/kubeconfig_my-eks-cluster`

Agora, você está habilitado a utilizar os comandos `kubectl` para a sua aplicação.

Para lançar a aplicação de teste, use o seguinte comando:

`kubectl apply -f deployment.yaml`

Após a execução desse comando, sua aplicação será efetivamente hospedada na AWS. Para verificar, você pode acessar o site da AWS ou usar o AWS CLI com o comando:

`kubectl get pods`
