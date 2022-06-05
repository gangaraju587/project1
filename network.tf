data "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block
  //enable_dns_hostnames = true

  // tags = "${merge(
  // local.common_tags,
  // tomap({"Name" = "${var.vpc-tag-name}"}),
  //{
  //   "Name" = "${var.vpc-tag-name}"  
  // }
  //)}"
}

//data "aws_internet_gateway" "ig" {
//  vpc_id = "${data.aws_vpc.vpc.id}"

//  tags = "${merge(
//    local.common_tags,
//    tomap({"Name" = "${var.ig-tag-name}"}),
//    {
//     "Name" = "${var.ig-tag-name}"  
//   }     

//  )}"
//}

data "aws_internet_gateway" "ig" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = var.subnet-1-cidr-block
  availability_zone       = "${var.aws-region}a"
  map_public_ip_on_launch = false

  tags = (merge(
    local.common_tags,
    tomap({ "Name" = "${var.subnet-tag-name}" }),
    {
      "Name" = "${var.subnet-tag-name}"
    }
  ))
}

resource "aws_subnet" "subnet-2" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = var.subnet-2-cidr-block
  availability_zone       = "${var.aws-region}b"
  map_public_ip_on_launch = false

  tags = (merge(
    local.common_tags,
    tomap({ "Name" = "${var.subnet-tag-name}" }),
    {
      "Name" = "${var.subnet-tag-name}"
    }
  ))
}

resource "aws_route_table" "rt" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.ig.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta_2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.rt.id
}




