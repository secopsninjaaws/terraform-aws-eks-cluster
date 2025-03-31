# 🚀 Módulo Terraform para Amazon EKS

Este módulo provisiona um cluster **Amazon EKS (Elastic Kubernetes Service)**, incluindo:

- Cluster EKS
- Node Group (grupo de nós gerenciados)
- Papéis IAM (cluster e nós)
- Provedor OIDC para autenticação com serviços AWS

---

## 📦 Recursos Provisionados

- ✅ Cluster EKS
- ✅ Grupo de nós gerenciados (Node Group)
- ✅ IAM Role para o cluster EKS
- ✅ IAM Role para os nós
- ✅ Provedor de identidade OIDC

---

## 🔧 Variáveis

| Nome              | Descrição                                                        | Tipo          | Valor Padrão        |
|-------------------|------------------------------------------------------------------|---------------|---------------------|
| `eks_role_name`   | Nome do papel IAM para o cluster EKS                             | `string`      | `"eks-role"`        |
| `project_name`    | Nome do projeto                                                  | `string`      | `"Lucas-EKS-Module"`|
| `private_subnets` | Lista de subnets privadas onde o cluster será implantado         | `list(string)`| **Obrigatório**     |
| `desired_size`    | Número desejado de nós no grupo                                  | `number`      | `2`                 |
| `max_size`        | Número máximo de nós no grupo                                    | `number`      | `3`                 |
| `min_size`        | Número mínimo de nós no grupo                                    | `number`      | `2`                 |
| `instance_types`  | Tipos de instância para os nós                                   | `list(string)`| `["t3.medium"]`     |
| `capacity_type`   | Tipo de capacidade (`SPOT` ou `ON_DEMAND`)                       | `string`      | `"SPOT"`            |
| `disk_size`       | Tamanho do disco (em GB) dos nós                                 | `number`      | `50`                |
| `region`          | Região AWS onde o cluster será criado                            | `string`      | `"us-east-1"`       |
| `public_endpoint` | Habilitar endpoint público no cluster                            | `bool`        | `false`             |

---

## 📤 Outputs

| Nome               | Descrição                                |
|--------------------|-------------------------------------------|
| `eks_cluster_name` | Nome/ID do cluster EKS criado             |

---

## 🔐 Configurações de IAM

### 🛡 IAM Role do Cluster

O módulo cria uma role IAM com a política:

- `AmazonEKSClusterPolicy`

### 🛠 IAM Role dos Nós

O Node Group utiliza uma role IAM com as seguintes políticas:

- `AmazonEKSWorkerNodePolicy`
- `AmazonEKS_CNI_Policy`
- `AmazonEC2ContainerRegistryReadOnly`

### 🔗 Provedor OIDC

Um **OIDC Provider** é configurado automaticamente para permitir que o cluster interaja com serviços AWS (como IRSA, ServiceAccounts, etc.) com segurança.

---

## 💻 Exemplo de Uso

```hcl
locals {
  eks_variables = {
    cluster_name   = "Lucas-EKS-Module"
    desired_size   = 1
    max_size       = 2
    min_size       = 1
    instance_types = ["t3.medium"]
    capacity_type  = "SPOT"
    disk_size      = 50
  }
}

module "eks" {
  source  = "app.terraform.io/secopsninjaaws/eks-cluster/aws"
  private_subnets = 
  desired_size    = local.eks_variables.desired_size
  max_size        = local.eks_variables.max_size
  min_size        = local.eks_variables.min_size
  instance_types  = local.eks_variables.instance_types
  capacity_type   = local.eks_variables.capacity_type
  disk_size       = local.eks_variables.disk_size
}
```