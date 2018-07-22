#
# Outputs
#


output "cluster-endpoint" {
  value = "${aws_eks_cluster.eks.endpoint}"
}
output "cluster-security-id" {
  value = "${aws_security_group.cluster.id}"
}

output "cluster-name" {
  value = "${aws_eks_cluster.eks.name}"
}

output "cluster-certificate-data" {
  value = "${aws_eks_cluster.eks.certificate_authority.0.data}"
}

output "cluster-arn" {
  value = "${aws_eks_cluster.eks.arn}"
}

