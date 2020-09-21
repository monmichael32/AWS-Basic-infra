resource "aws_instance" "mongodb_one" {
    
    tags = {
        Name = "pd-mongodb-one"
    }
    subnet_id="subnet-0a995e300bffcc391"
    ami = "ami-326a5325"
    
    instance_type = "t2.micro"
    
    root_block_device {
        volume_type = "gp2"
        volume_size = "100"
    }
}

resource "aws_s3_bucket" "cts-web-resources" {
    bucket = "cts-web-resources"
    acl    = "public-read"
    #policy = file("policy.json") 
    
    website {
       index_document = "index.html"
       error_document = "error.html"
}
}

resource "aws_lb_target_group_attachment" "mongodb_one" {
  target_group_arn = aws_lb_target_group.pennypinchers.arn
  target_id = aws_instance.mongodb_one.private_ip
  port = 27017
}

