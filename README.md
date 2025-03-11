# Módulo Terraform para Cluster AWS EKS

Este módulo Terraform implanta um cluster Amazon Elastic Kubernetes Service (EKS) pronto para produção na AWS com funções IAM adequadas, configuração OIDC e configurações de grupo de segurança.

## Funcionalidades

- Cria um cluster EKS em sua VPC
- Configura as funções IAM necessárias com permissões apropriadas
- Configura acesso de endpoint tanto privado quanto público
- Estabelece provedor OIDC para autenticação de contas de serviço do Kubernetes
- Configura regras de grupo de segurança para acesso seguro ao cluster
- Suporte para implantação multi-AZ nas zonas de disponibilidade 1a, 1b e 1c

## Pré-requisitos

- Terraform v0.13+ instalado
- AWS CLI configurado com credenciais apropriadas
- VPC existente com subnets públicas e privadas em 3 zonas de disponibilidade

## Uso

```hcl
module "eks" {
  source = "github.com/username/terraform_eks_cluster_module"

  project_name = "my-eks-project"
  eks_role_name = "my-eks-role"
  
  subnet_ids_1a_public  = "subnet-xxxxxxxxxxxxxxxxx"
  subnet_ids_1b_public  = "subnet-xxxxxxxxxxxxxxxxx"
  subnet_ids_1c_public  = "subnet-xxxxxxxxxxxxxxxxx"
  subnet_ids_1a_private = "subnet-xxxxxxxxxxxxxxxxx"
  subnet_ids_1b_private = "subnet-xxxxxxxxxxxxxxxxx"
  subnet_ids_1c_private = "subnet-xxxxxxxxxxxxxxxxx"
}
```

## Variáveis Obrigatórias

| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|--------|:--------:|
| subnet_ids_1a_public | ID da subnet pública na zona de disponibilidade 1a | `string` | n/a | sim |
| subnet_ids_1b_public | ID da subnet pública na zona de disponibilidade 1b | `string` | n/a | sim |
| subnet_ids_1c_public | ID da subnet pública na zona de disponibilidade 1c | `string` | n/a | sim |
| subnet_ids_1a_private | ID da subnet privada na zona de disponibilidade 1a | `string` | n/a | sim |
| subnet_ids_1b_private | ID da subnet privada na zona de disponibilidade 1b | `string` | n/a | sim |
| subnet_ids_1c_private | ID da subnet privada na zona de disponibilidade 1c | `string` | n/a | sim |

## Variáveis Opcionais

| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|--------|:--------:|
| project_name | Nome do projeto | `string` | `"Lucas-EKS-Module"` | não |
| eks_role_name | Nome da função IAM do EKS | `string` | `"eks-role"` | não |

## Saídas

| Nome | Descrição |
|------|-----------|
| thumbprint | A impressão digital do certificado do provedor OIDC |

## Segurança

O módulo configura as seguintes funcionalidades de segurança:
- Função IAM com princípios de privilégio mínimo
- Grupos de segurança para controlar o acesso ao plano de controle do EKS
- Tráfego HTTPS habilitado para o endpoint do cluster

## Exemplo Avançado

```hcl
module "eks" {
  source = "github.com/username/terraform_eks_cluster_module"

  project_name  = "production-eks"
  eks_role_name = "production-eks-admin"
  
  subnet_ids_1a_public  = module.vpc.public_subnets[0]
  subnet_ids_1b_public  = module.vpc.public_subnets[1]
  subnet_ids_1c_public  = module.vpc.public_subnets[2]
  subnet_ids_1a_private = module.vpc.private_subnets[0]
  subnet_ids_1b_private = module.vpc.private_subnets[1]
  subnet_ids_1c_private = module.vpc.private_subnets[2]
}

# Use o cluster com kubectl
resource "local_file" "kubeconfig" {
  content  = module.eks.kubeconfig
  filename = "~/.kube/config"
}

# Implante uma aplicação de exemplo
resource "kubernetes_deployment" "example" {
  depends_on = [module.eks]
  
  # Configuração de implantação
  # ...
}
```

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para enviar um Pull Request.

## Licença

Este módulo está licenciado sob a Licença MIT - veja o arquivo LICENSE para detalhes.
