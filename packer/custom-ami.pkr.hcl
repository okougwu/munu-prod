packer {
    required_plugins {
        amazon = {
            source  = "github.com/hashicorp/amazon"
            version = "1.2.7"
        }
    }
}


#Define source ami

source "amazon-ebs" "ubuntu" {
    ami_name            = "ikenna_lab"
    source_ami          = "ami-075a97e468dc8d68b"
    region              = "eu-west-2"
    instance_type       = "t2.micro"
    ssh_username        = "ubuntu"
}

#build the custom ami
build {
    name            = "munateach-ami"
    sources         = ["source.amazon-ebs.ubuntu"]


    # add provisioner

    provisioner "shell" {
        script      = "install_nginx.sh"
    }
}
