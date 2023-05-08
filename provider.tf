# #Configuring AWS Provider
# provider aws {
#     region = "ap-south-1"
#     access_key = "AKIAU63LPM2AS57L4OPO"
#     secret_key = "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" 
# }

# #Variable for Environment
# variable "env" {
#     description = "You want these resources in which environment?"
# }

# #Variable for Availability zone
# variable "az" {}


# #Variable for CIDR Blocks
# variable "vpc_cidr" {}
# variable "subnet_cidr" {}

# # Creating a VPC
# resource "aws_vpc" "tf_vpc" {
#   cidr_block       = var.vpc_cidr
#   tags = {
#     Name = "${var.env}-VPC"
#   }
# }

# #Creating a subnet

# resource "aws_subnet" "tf_subnet" {
#   vpc_id     = aws_vpc.tf_vpc.id
#   cidr_block = var.subnet_cidr
#   availability_zone = var.az
#   tags = {
#     Name = "${var.env}-Subnet"
#   }
# }

# #------------------------------------------------------------------------------------------------------
# # Creating an internet gateway so that VPC can have internet communication
# resource "aws_internet_gateway" "tf_igw" {
#   vpc_id = aws_vpc.tf_vpc.id

#   tags = {
#     Name = "${var.env}-IGW"
#   }
# }

# #Creating new route table to register internet gateway and default vpc route

# # resource "aws_route_table" "tf_rtb" {
# #   vpc_id = aws_vpc.tf_vpc.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_internet_gateway.tf_igw.id
# #   }

# #   tags = {
# #     Name = "${var.env}-RTB"
# #   }
# # }

# #----------------------------------------------------------

# #Explicitly defining the association between subnet and route table

# resource "aws_route_table_association" "tf_asso_rtb" {
#   subnet_id      = aws_subnet.tf_subnet.id
#   route_table_id = aws_default_route_table.tf_default_rtb.id
# }

# #-----------------------------------------------------------------

# # using "Main" or default route table available for our custom vpc for regidtering internet gateway record

# resource "aws_default_route_table" "tf_default_rtb" {
#   default_route_table_id = aws_vpc.tf_vpc.default_route_table_id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.tf_igw.id
#   }

#   tags = {
#     Name = "${var.env}-RTB"
#   }
# }

# #----------------------------------------------------------------
# # Editing default sg cretaed by our custom vpc to have inbound and outbound rules

# resource "aws_default_security_group" "tf_default_sg" {
#   vpc_id = aws_vpc.tf_vpc.id

#   tags = {
#     Name = "${var.env}-SG"
#   }

#   ingress {
#     protocol  = "tcp"
#     from_port = 22
#     to_port   = 22
#     cidr_blocks = ["43.243.82.169/32"]
#   }

#     ingress {
#     protocol  = "tcp"
#     from_port = 8080
#     to_port   = 8080
#     cidr_blocks = ["10.0.10.0/24"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }