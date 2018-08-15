resource "aws_launch_configuration" "ecs_lc" {
  count                = "${var.required}"
  name_prefix          = "${var.launch_conf_name}"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_role}"
  key_name             = "${var.key_name}"

  user_data                   = "${var.user_data}"
  associate_public_ip_address = false

  lifecycle {
    prevent_destroy       = "${var.prevent_destroy}"
    create_before_destroy = true
  }

  security_groups = ["${var.security_group}"]
}

resource "aws_autoscaling_group" "main_asg" {
  count = "${var.required}"

  # We want this to explicitly depend on the launch config above
  depends_on = ["aws_launch_configuration.ecs_lc"]

  name = "${var.asg_name}"

  force_delete = true

  # The chosen availability zones *must* match the AZs the VPC subnets are tied to.
  # availability_zones  = ["${var.availability_zones}"]
  vpc_zone_identifier = ["${var.vpc_zone_subnets}"]

  # Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.ecs_lc.id}"

  max_size         = "${var.asg_maximum_number_of_instances}"
  min_size         = "${var.asg_minimum_number_of_instances}"
  desired_capacity = "${var.asg_desired_capacity}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  tag {
    key                 = "Name"
    value               = "${var.asg_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Product"
    value               = "${lookup(var.tags, "ProductTag", "default")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ResourceType"
    value               = "${lookup(var.tags, "ResourceType", "default")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${lookup(var.tags, "Environment", "dev")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Service"
    value               = "${lookup(var.tags, "Service", "default")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ServiceComponent"
    value               = "${lookup(var.tags, "ServiceComponent", "default")}"
    propagate_at_launch = true
  }

  tag {
    key                 = "NetworkTier"
    value               = "${lookup(var.tags, "NetworkTier", "default")}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_att" {
  autoscaling_group_name = "${aws_autoscaling_group.main_asg.id}"
  elb                    = "${var.load_balancer_names}"
}

resource "aws_autoscaling_policy" "scale_out" {
  depends_on                = ["aws_launch_configuration.asg_name"]
  name                      = "${var.asg_name}-asg-scaleout"
  autoscaling_group_name    = "${aws_autoscaling_group.main_asg.name}"
  policy_type               = "StepScaling"
  adjustment_type           = "ChangeInCapacity"
  metric_aggregation_type   = "Average"
  estimated_instance_warmup = 900

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0.0
  }
}

resource "aws_autoscaling_policy" "scale_in" {
  depends_on             = ["aws_launch_configuration.asg_name"]
  name                   = "${var.asg_name}-asg-scalein"
  autoscaling_group_name = "${aws_autoscaling_group.asg_name.name}"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_upper_bound = 0.0
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  depends_on          = ["aws_launch_configuration.asg_name"]
  alarm_name          = "${var.asg_name}-asg-highcpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "40"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg.name}"
  }

  alarm_description = "This metric monitor ec2 high cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scale_out.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_alarm" {
  depends_on          = ["aws_launch_configuration.asg_name"]
  alarm_name          = "${var.asg_name}-lowcpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "20"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg.name}"
  }

  alarm_description = "This metric monitor ec2 low cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scale_in.arn}"]
}
