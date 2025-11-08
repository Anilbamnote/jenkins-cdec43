variable "image_id" {
    default= "ami-0cfde0ea8edd312d4"
}

variable "instance_type" {
    default= "t3.micro"
}

variable "key-pair" {
    default= "ohio-soheb-key"
}

variable "cidr_block" {
    default= "10.0.0.0/24"
}




provider "aws" {
    region = "us-east-2"
}

provider "aws" {
    region = "us-east-2"
  
}

module "ec2-instance_basic" {
    source = "./modules/ec2-instance" #vpc
  
  

}