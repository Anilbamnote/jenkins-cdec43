resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block

  map_public_ip_on_launch = true

  tags = {
    Name = "main"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-main"
  }
}


resource "aws_default_route_table" "main-rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

 

  tags = {
    Name = "example"
  }
}



resource "aws_instance" "web" {
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key-pair
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    subnet_id = aws_subnet.main.id

    tags = {
        Name: "my_custome_instance"
    }
  
}


resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}