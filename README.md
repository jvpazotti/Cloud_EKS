# Cloud_EKS

Para implementar essa infraestrutura, você precisará atender a alguns requisitos:

- AWS CLI
- AWS IAM AUTHENTICATOR
- KUBECTL
- TERRAFORM
- KEY PAIR NA AWS
- VISUAL STUDIO CODE

## Instalação e configuração do AWS CLI, Terraform e Kubectl:

1. Instale o Terraform seguindo as instruções em: [Instalar Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

2. Instale e configure o AWS CLI, acessando: [Instalar AWS CLI](https://aws.amazon.com/cli/).

3. Abra o terminal de comando e execute o seguinte comando:

   **aws configure**
   

4. Quando solicitado, insira suas credenciais da AWS, incluindo o Access Key ID e Secret Access Key. Essas informações podem ser encontradas no Console AWS em "Credenciais de segurança" ou obtidas com o administrador da sua conta AWS. Além disso, informe a região, que neste caso é us-east-1. Se preferir, apenas pressione ENTER para usar as configurações padrão.

5. Instale o AWS IAM AUTHENTICATOR, seguindo as instruções em: [Instalar AWS IAM AUTHENTICATOR](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

6. Instale o Kubectl seguindo as instruções em: [Instalar Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

7. Configure o KEY PAIR na AWS para utilizar com o EC2.

8. Por fim, instale o Visual Studio Code: [Instalar Visual Studio Code](https://code.visualstudio.com/download).

No Visual Studio Code, abra o projeto e, no arquivo `eks.tf`, substitua a linha `key_name = "teste"` por `key_name = "nome_do_seu_key_pair"`.

Após esse procedimento, execute os seguintes comandos em sequência:

- `$ terraform init`
- `$ terraform plan`
- `$ terraform apply`

Após executar esses comandos, você precisará fazer a seguinte alteração no arquivo `kubeconfig_my-eks-cluster`:

A linha provavelmente estará assim: `apiVersion: client.authentication.k8s.io/v1alpha1`.

Substitua-a por: `apiVersion: client.authentication.k8s.io/v1beta1`.

Em seguida, execute o seguinte comando no terminal(Linux/MacOS): `export KUBECONFIG=/caminho/da/pasta/kubeconfig_my-eks-cluster`. 

No Windows, o comando será no Powershell `$env:KUBECONFIG = "/caminho/da/pasta/kubeconfig_my-eks-cluster"` , no CMD `set KUBECONFIG=/caminho/da/pasta/kubeconfig_my-eks-cluster`

Agora você pode utilizar os comandos `kubectl` para sua aplicação.

