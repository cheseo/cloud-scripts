terraform {   
        required_providers {
                aws = {   
                        source = "hashicorp/aws"
                        # ~> means major same, minor can increase
                        version = "~> 5.92"
                }       
        }                  
        required_version = ">= 1.2"                                       
}

resource "aws_sns_topic" "terra_sns" {
	name = "terra_sns"
}

resource "aws_cloudwatch_metric_alarm" "ec2" {
	alarm_name = "ec2-10%"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = 2
	metric_name = "CPUUtilization"
	namespace = "AWS/EC2"
	period = 120
	statistic = "Average"
	threshold = 10

	alarm_description = "sound alarm & scale if cpu >10% usage"
	alarm_actions = [aws_sns_topic.terra_sns.arn, aws_autoscaling_policy.step_up.arn]
	ok_actions = [aws_sns_topic.terra_sns.arn, aws_autoscaling_policy.step_down.arn]
	dimensions = {
		AutoScalingGroupName = aws_autoscaling_group.fifty.name
	}
}
resource "aws_cloudwatch_metric_alarm" "ecs" {
	alarm_name = "ecs-1%"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = 2
	metric_name = "CpuUtilized"
	namespace = "AWS/EC2"
	period = 120
	statistic = "Average"
	threshold = 1

	alarm_description = "sound alarm if ecs cpu >1% usage"
	alarm_actions = [aws_sns_topic.terra_sns.arn]
	dimensions = {
		ServiceName = "flask-service-2"
		ClusterName = "flask-fe-cluster"
	}
}

resource "aws_sns_topic_subscription" "mymail" {
	topic_arn = aws_sns_topic.terra_sns.arn
	protocol = "email"
	endpoint = "ashwin@ashwink.com.np"
}


resource "aws_launch_template" "autoLaunch" {
	name_prefix = "AutoScaled"
	instance_type = "t2.micro"
	image_id = var.auto_image
	key_name = "ec2-test"
	network_interfaces {
		associate_public_ip_address = true
	}
	tag_specifications {
		resource_type = "instance"
		tags = {
			Name = "AutoScaled"
		}
	}
	user_data = filebase64("cloud-init.sh")
}

resource "aws_autoscaling_group" "fifty" {
	desired_capacity = 1
	max_size = 2
	min_size = 1
	vpc_zone_identifier = [var.launch_subnet]
	target_group_arns = [aws_lb_target_group.sd.arn]
	launch_template {
		id = aws_launch_template.autoLaunch.id
		version = "$Latest"
	}
}

resource "aws_autoscaling_policy" "step_up" {
	name = "step-up-policy"
	scaling_adjustment = 1
	adjustment_type = "ChangeInCapacity"
	cooldown = 300
	autoscaling_group_name = aws_autoscaling_group.fifty.name
}

resource "aws_autoscaling_policy" "step_down" {
	name = "step-down-policy"
	scaling_adjustment = -1
	adjustment_type = "ChangeInCapacity"
	cooldown = 300
	autoscaling_group_name = aws_autoscaling_group.fifty.name
}

variable "auto_image" {
	type = string
	default = "ami-0f918f7e67a3323f0"
}

variable "launch_subnet" {
	type = string
	default = "subnet-0d1ca39b5c39a8fdd"
}
