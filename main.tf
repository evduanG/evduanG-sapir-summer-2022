terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "EviatarDuany-dev-vpc" {
  cidr_block = "192.168.1.0/27"
  tags = {
    Name = "EviatarDuany-dev-vpc"
  }
}

resource "aws_subnet" "EviatarDuany-k8s-subnet" {
  vpc_id     = aws_vpc.EviatarDuany-dev-vpc.id
  cidr_block = "192.168.1.0/27"

  tags = {
    Name = "EviatarDuany-k8s-subnet"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.EviatarDuany-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.EviatarDuany-dev-vpc.id

  tags = {
    Name = "gateway"
  }
}
