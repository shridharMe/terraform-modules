
output "cluster-endpoint" {
  value = "${aws_eks_cluster.eks.endpoint}"
}
output "cluster-security-id" {
  value = "${aws_security_group.cluster.id}"
}