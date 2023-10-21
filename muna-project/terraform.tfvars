region                          =   "eu-west-2"
project_name                    =   "Munateach_Edinburgh"
vpc_cidr                        =   "10.0.0.0/16"   
public_subnet_az1_cidr          =   "10.0.0.0/24"
public_subnet_az2_cidr          =   "10.0.1.0/24"
private_app_subnet_az1_cidr     =   "10.0.2.0/24"
private_app_subnet_az2_cidr     =   "10.0.3.0/24"
private_data_subnet_az1_cidr    =   "10.0.4.0/24"
private_data_subnet_az2_cidr    =   "10.0.5.0/24"

security_group_rules = {
  ssh = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  http = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  https = {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  mysql = {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  postgres = {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
