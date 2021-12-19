resource "aws_vpc" "ter-test" {
    cidr_block = "10.2.3.0/16"
    tags = {
        "Name" = "terraform-test"
    }
}

resource "asw_subnet" "subnet1" {
  vpc_id     = aws_vpc.ter-test.id
  cidr_block = "10.2.3.0/24"
  map_public_ip_on_lunch = true
  availabilty_zone = "us-east-2"

  tags = {
      "Name" = "ter-test-sub-1"
  }
}

resource "asw_subnet" "subnet2" {
  vpc_id     = aws_vpc.ter-test.id
  cidr_block = "10.2.4.0/24"
  map_public_ip_on_lunch = true
  availabilty_zone = "us-east-2"

  tags = {
      "Name" = "terraform-test-sub-2"
  }
}

resource "aws_internet_gateway" "ter-gw" {
  vpc_id = aws_vpc.ter-test.id

  tags = {
    Name = "ter-gw"
  }
}

resource "aws_route_table" "ter-rt" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ter-gw.id
  }

  resource "aws_route_table_association" "ter-sub-pub-1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.ter-rt.id
}

  resource "aws_route_table_association" "ter-sub-pub-2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.ter-rt.id
}