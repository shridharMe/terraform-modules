output "task-arn" {
  value = "${aws_ecs_task_definition.task.arn}"
}

output "task-family " {
  value = "${aws_ecs_task_definition.task.family}"
}

output "task-revision" {
  value = "${aws_ecs_task_definition.task.revision}"
}

output "service-id" {
  value = "${aws_ecs_service.service.id}"
}

output "service-name" {
  value = "${aws_ecs_service.service.name}"
}

output "service-cluster " {
  value = "${aws_ecs_service.service.cluster}"
}

output "service-iam-role " {
  value = "${aws_ecs_service.service.iam_role}"
}

output "service-desired-count" {
  value = "${aws_ecs_service.service.desired_count}"
}
