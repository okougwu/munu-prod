module "security_group" {
  source       = "../security_group"
  project_name = var.project_name
}

resource "aws_security_group_rule" "my_security_groups" {
  type               = "ingress"
  from_port          = 80
  to_port            = 80
  protocol           = "tcp"
  security_group_id  = module.security_group.security_group_id[1]  # Adjust the index as needed
  source_security_group_id = module.security_group.security_group_id[1]
}

resource "aws_vpc" "munateach" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.munateach.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.munateach.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_az1"
  }
}
# create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.munateach.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public_subnet_az2"
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.munateach.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "public_route_table"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                   = aws_vpc.munateach.id
  cidr_block               = var.private_app_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_app_subnet_az1"
  }
}

# create private app subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                   = aws_vpc.munateach.id
  cidr_block               = var.private_app_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_app_subnet_az2"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.munateach.id
  cidr_block               = var.private_data_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_data_subnet_az1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = aws_vpc.munateach.id
  cidr_block               = var.private_data_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_data_subnet_az2"
  }
}
