provider "azurerm" {
   features {}
  }

resource "azurerm_mssql_server" "mysqlserverhb" {
  name                         = "mysqlserverhb"
  resource_group_name          = "cis_test"
  location                     = "westeurope"
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"

  tags = {
    environment = "Demo"
  }
}

# # Enable Flow Logs for the VPC
# resource "aws_flow_log" "example_flow_log" {
#   depends_on = [aws_vpc.example_vpc]

#   iam_role_arn = aws_iam_role.flow_log_role.arn
#   log_destination = "arn:aws:logs:us-east-1:YOUR_ACCOUNT_ID:log-group:example-flow-logs"
#   traffic_type = "ALL"
#   vpc_id = aws_vpc.example_vpc.id
# }

# # Define IAM role for Flow Logs
# resource "aws_iam_role" "flow_log_role" {
#   name = "example-flow-log-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "vpc-flow-logs.amazonaws.com"
#       }
#     }
#   ]
# }
# EOF
# }

# # Attach an IAM policy to the IAM role
# resource "aws_iam_policy_attachment" "flow_log_role_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess" # Adjust policy as needed
#   role = aws_iam_role.flow_log_role.name
# }
