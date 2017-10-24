# DECLARATION S3
terraform {
  backend "s3" {
    bucket = "backend.terraform"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}

# DECLARATION PROVIDER AWS
provider "aws" {
  region = "eu-west-1"
}

# CREATION VPC
resource "aws_vpc" "vpcvalentin" {
  cidr_block = "172.23.0.0/16"

  tags {
    Name = "VPC-Valentin"
  }
}

# CREATION IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpcvalentin.id}"
}

# CREATION DES SUBNETS
resource "aws_subnet" "subnet1" {
  vpc_id            = "${aws_vpc.vpcvalentin.id}"
  cidr_block        = "172.23.0.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "Subnet gauche"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = "${aws_vpc.vpcvalentin.id}"
  cidr_block        = "172.23.1.0/24"
  availability_zone = "eu-west-1b"

  tags {
    Name = "Subnet droit"
  }
}

# CREATION ROUTE TABLE
resource "aws_route_table" "Routetable" {
  vpc_id = "${aws_vpc.vpcvalentin.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "Route to IGW"
  }
}

resource "aws_main_route_table_association" "RouteAssociation" {
  vpc_id         = "${aws_vpc.vpcvalentin.id}"
  route_table_id = "${aws_route_table.Routetable.id}"
}
