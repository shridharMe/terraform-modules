output "cluster-endpoint" {
  value = "${module.eks-cluster.cluster-endpoint}"
}

output "cluster-security-id" {
  value = "${module.eks-cluster.cluster-security-id}"
}

output "cluster-name" {
  value = "${module.eks-cluster.cluster-name}"
}

output "cluster-certificate-data" {
  value = "${module.eks-cluster.cluster-certificate-data}"
}

output "cluster-arn" {
  value = "${module.eks-cluster.cluster-arn}"
}

output "workstation-external-cidr" {
  value = "${module.workstation-external.workstation-external-cidr}"
}

output "node-security-id" {
  value = "${module.eks-worker-node.node-security-id}"
}

output "node-role-arn" {
  value = "${module.eks-worker-node.node-role-arn}"
}

output "config-map-aws-auth" {
  value = "${module.kube-config.config-map-aws-auth}"
}

output "kubeconfig" {
  value = "${module.kube-config.kubeconfig}"
}
