module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0" 

  cluster_name    = "cluster-teste-eks"
  cluster_version = "1.24" 
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1

      instance_type = "t3.medium"
      key_name      = "chave_nova" # substitua pelo nome da sua chave

      additional_tags = {
        Environment = "test"
        Name        = "eks-worker-node"
      }
    }
  }
}

