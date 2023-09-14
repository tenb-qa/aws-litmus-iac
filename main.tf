# Define the AWS provider
provider "aws" {
  region = "ca-central-1" # Change this to your desired region
}

# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16" # Adjust the CIDR block as needed
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create two subnets in different Availability Zones
resource "aws_subnet" "subnet_a" {
  count = 2
  vpc_id = aws_vpc.example_vpc.id
  cidr_block = "10.0.${100 + count.index}.0/24" # Adjust the CIDR block as needed
  availability_zone = "us-east-1a" # Change AZ as needed
}

# Enable Flow Logs for the VPC
resource "aws_flow_log" "example_flow_log" {
  depends_on = [aws_vpc.example_vpc]

  iam_role_arn = aws_iam_role.flow_log_role.arn
  log_destination = "arn:aws:logs:us-east-1:YOUR_ACCOUNT_ID:log-group:example-flow-logs"
  traffic_type = "ALL"
  vpc_id = aws_vpc.example_vpc.id
}

# Define IAM role for Flow Logs
resource "aws_iam_role" "flow_log_role" {
  name = "example-flow-log-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      }
    }
  ]
}
EOF
}

# Attach an IAM policy to the IAM role
resource "aws_iam_policy_attachment" "flow_log_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess" # Adjust policy as needed
  role = aws_iam_role.flow_log_role.name
}
