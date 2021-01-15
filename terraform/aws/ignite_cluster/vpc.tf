# data "aws_vpc" "eks" {
#   default = false
#   id = "vpc-015797c7c1fd32b4c"
# #   filter {
# #     name   = "Name"
# #     values = [ "eks-vpc-VPC" ]
# #   }
# }

# data "aws_subnet_ids" "all" {
#   vpc_id = data.aws_vpc.eks.id
#   tags = {
#       Name =	"eks-vpc-VPC"
#   }
# }

# data "aws_subnet" "all" {
#   count = "${length(data.aws_subnet_ids.all.ids)}"
#   id    = "${data.aws_subnet_ids.all.ids[count.index]}"
# }

resource "aws_vpc" "ignite_test_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "ignite_test_vpc"
  }
}
resource "aws_internet_gateway" "ignite_igw" {
  vpc_id = aws_vpc.ignite_test_vpc.id

  tags = {
    Name = "ignite-igw"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.ignite_test_vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "ignite-public-${count.index + 1}-subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ignite_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ignite_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "ignite-sg" {
  name        = "ignite-sg"
  description = "sg for ignite cluster"
  vpc_id      = aws_vpc.ignite_test_vpc.id

  ingress  {
    description = "ignite port"
    from_port   = 10800
    to_port     = 10800
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress  {
    description = "ignite port"
    from_port   = 47600
    to_port     = 47600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress  {
    description = "ignite port"
    from_port   = 47500
    to_port     = 47500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress  {
    description = "ignite port"
    from_port   = 47200
    to_port     = 47200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress  {
    description = "ignite port"
    from_port   = 47100
    to_port     = 47100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ingress  {
    description = "ignite ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["1.23.194.65/32"]
    }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ignite_sg"
  }
}