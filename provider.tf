#Configuring AWS Provider
provider aws {
    region = "ap-south-1"
    access_key = "AKIAU63LPM2AS57L4OPO"
    secret_key = "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" 
    }

# Creating a VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = "172.31.10.0/24"
  tags = {
    "Name" = "New VPC"
  }
}

#Creating a subnet

resource "aws_subnet" "tf_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = var.subnet_variable

  tags = {
    Name = "New Subnet"
  }
}
 variable "subnet_variable" {
    description = "this is a variable for subnet cidr block"
   
 }

#"172.31.10.128/26"