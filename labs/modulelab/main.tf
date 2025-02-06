module "create_ec2" {
  source = "./modules"
  ami = "ami-0c02fb55956c7d316"
  machine_type = "t2.micro"
  ingress_ports = [22, 443, 80]
}

output "output_from_module" {
  value = module.create_ec2
}
