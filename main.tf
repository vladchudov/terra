terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-test"
  }
}

resource "aws_db_instance" "aws-db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "testdb"
  password             = "passsafe"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

resource "aws_s3_bucket" "b" {
  bucket = "aws-bucket"
  acl    = "private"

  tags = {
    Name        = "bucket"
    Environment = "Dev"
  }
}