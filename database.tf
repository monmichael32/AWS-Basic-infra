resource "aws_instance" "mongodb_one" {
    #availability_zone = "us-east-1"
    
    #tags {
        #Name = "${var.ENVIRONMENT}-mongodb-one"
    #}
    
    ami = "ami-326a5325"
    
    instance_type = "t2.micro"
    
    root_block_device {
        volume_type = "gp2"
        volume_size = "100"
    }
    
    #security_groups = [
        #"aws_security_group.mongodb.name"
    #]
    
    associate_public_ip_address = true
    
    key_name = "deployer-key"
}

resource "aws_security_group" "mongodb" {
  name        = "mongodb"
  description = "Security group for mongodb"
 
  vpc_id=aws_vpc.vpc.id

  tags = {
    Name = "mongodb-prod"
  }
}

resource "aws_security_group_rule" "mongodb_allow_all" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = aws_security_group.mongodb.id
}

resource "aws_security_group_rule" "mongodb_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = aws_security_group.mongodb.id
}

resource "aws_security_group_rule" "mongodb_mongodb" {
  type            = "ingress"
  from_port       = 27017
  to_port         = 27017
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = aws_security_group.mongodb.id
}

resource "aws_security_group_rule" "mongodb_mongodb_replication" {
  type            = "ingress"
  from_port       = 27019
  to_port         = 27019
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = aws_security_group.mongodb.id
}

