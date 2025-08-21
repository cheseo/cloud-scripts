resource "aws_cloudwatch_dashboard" "main" {
	dashboard_name = "my-dashboard"

	dashboard_body = jsonencode({
		widgets = [
			{
				type = "metric"
				x = 0
				y = 0
				width = 12
				height = 6
				properties = {
					metrics = [
						["AWS/EC2",
						"CPUUtilization",
						"AutoScalingGroupName", "scalefifty"]
					]
					period = 300
					start = "Average"
					region = "ap-south-1"
					title = "EC2 instance cpu"
				}
			},
		]
	})
}
