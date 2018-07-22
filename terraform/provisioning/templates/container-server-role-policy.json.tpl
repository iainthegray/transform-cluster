{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Effect":"Allow",
            "Action":[
                "ec2:DescribeInstances",
                "ec2:DescribeTags",
                "cloudwatch:PutMetricData",
                "cloudwatch:PutMetricAlarm",
                "sns:Publish",
                "ec2messages:GetMessages",
                "autoscaling:DescribeAutoScalingGroups"
            ],
            "Resource":"*"
        }
    ]
}