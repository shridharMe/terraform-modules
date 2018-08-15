module "vpc" {
  source          = "../vpc"
  name            = "${var.environment}-${var.name}-vpc"
  cidr            = "${var.cidr}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  azs             = "${var.azs}"
  owner           = "${var.owner}"
  environment     = "${var.environment}"
  terraform       = "${var.terraform}"
}

module "workstation-external" {
  source = "../eks/workstation"
}

module "eks-cluster" {
  source                    = "../eks/eks-cluster"
  vpc_id                    = "${module.vpc.vpc_id}"
  public_subnets            = "${module.vpc.public_subnets}"
  private_subnets_cidr      = "${module.vpc.private_subnets_cidr}"
  cluster-name              = "${var.environment}-${var.name}-cluster"
  workstation-external-cidr = "${module.workstation-external.workstation-external-cidr}"
}

module "eks-worker-node" {
  source                   = "../eks/eks-worker-node"
  vpc_id                   = "${module.vpc.vpc_id}"
  cluster-name             = "${module.eks-cluster.cluster-name}"
  cluster-endpoint         = "${module.eks-cluster.cluster-endpoint}"
  cluster-certificate-data = "${module.eks-cluster.cluster-certificate-data}"
  node-instance-type       = "${var.node-instance-type}"
  desired-capacity         = "${var.desired-capacity}"
  max-size                 = "${var.max-size}"
  min-size                 = "${var.min-size}"
  public_subnet_cidr       = "${module.vpc.public_subnets_cidr}"
  private_subnet           = "${module.vpc.private_subnets}"
}

module "kube-config" {
  source                            = "../eks/eks-kube-config"
  role_node_arn                     = "${module.eks-worker-node.node-role-arn}"
  cluster_eks_endpoint              = "${module.eks-cluster.cluster-endpoint}"
  cluster_eks_certificate_authority = "${module.eks-cluster.cluster-certificate-data}"
}
