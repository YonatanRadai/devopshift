provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

# filter using name 
# data "aws_instance" "example" {
  # filter {
    #name   = "tag:Name"
    #values = ["yaniv-vm"]
  #}
#}


# filter using id 
data "aws_instance" "example" {
  instance_id = "i-09df7e0ed385f871b"
}

# Output the public IP of the instance
output "public_ip_address" {
  value = data.aws_instance.example.public_ip
}
