#INSTANCIA
resource "aws_instance" "ec2_server" {
  ami                    = "ami-03ea746da1a2e36e7"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [aws_security_group.lab-sg-guinho.id]
  iam_instance_profile   = aws_iam_instance_profile.ecr_ec2_profile.name
  user_data = file ("user_data.sh")


  tags = {
    Name        = "lab-server"
    Provisioned = "Terraform"
    Cliente     = "Lab_Guinho"
  }
}


#KEY-PAIR
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lab_key" {
  key_name   = "lab-key-guinho"
  public_key = tls_private_key.ssh_key.public_key_openssh
}



#SECURITY GROUP EC2 


resource "aws_security_group" "lab-sg-guinho" {
  name   = "labguinho-ec2"
  vpc_id = "vpc-03d37e66686541ef3"

  tags = {
    Name        = "lab-guinhoec2"
    Provisioned = "Terraform"
    Cliente     = "lab-guinho"
  }
}

#REGRAS SECURITY GROUP EC2
#INGRESS#
#HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.lab-sg-guinho.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

#SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.lab-sg-guinho.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

#HTTPS
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.lab-sg-guinho.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

#SAIDA EC2

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.lab-sg-guinho.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

#IAM ROLE

resource "aws_iam_instance_profile" "ecr_ec2_profile" {
  name = "ecr-ec2-profile"
  role = aws_iam_role.ecr_ec2.name
}
