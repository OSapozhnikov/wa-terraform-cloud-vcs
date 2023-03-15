###
provider "aws" {
  region = var.aws_region
  #profile = var.aws_profile
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = "dev-0"
    Type        = var.type
    Demo        = "true"
  }
}

data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

### AWS instance resource
resource "aws_instance" "wa_demo_instance" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t3.medium"

  associate_public_ip_address = true

  key_name = var.aws_key_name

  tags = merge(local.common_tags,
    {
      Name = "wa-${var.type}-ec2-instance"
    },
  )

  lifecycle {
    # Create new instance before destroy present
    create_before_destroy = true

    # The instance tag "Terraform" must be "true"
    postcondition {
      condition     = self.tags["Terraform"] == "true"
      error_message = "tags[\"Terraform\"] must be \"true\"."
    }
  }
}
