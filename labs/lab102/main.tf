provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

resource "aws_security_group" "sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI in us-east-1
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "Yonatan-vm"
  }
}

# Add a time delay to ensure the public IP is allocated
resource "time_sleep" "wait_for_ip" {
  create_duration = "10s" # Wait for 10 seconds
}

# Add depends_on to ensure the delay happens after the instance creation
output "vm_public_ip" {
  value       = aws_instance.vm.public_ip
  description = "Public IP address of the VM"
  depends_on  = [time_sleep.wait_for_ip] # Ensure delay occurs before fetching the IP
}
