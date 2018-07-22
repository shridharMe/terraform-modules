
output "cluster-endpoint" {
  value = "${aws_eks_cluster.eks.endpoint}"
}
output "cluster-security-id" {
  value = "${aws_security_group.cluster.id}"
}

output "cluster-name" {
  value = "${aws_security_group.cluster.name"
}
