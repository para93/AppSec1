resource "aws_instance" "wordpress" {
  ami           = "ami-09504fb0a86d17274"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = ["${aws_security_group.mywebsecurity.id}"]
  key_name = "mchung-dell-pem"
  availability_zone = "us-east-2a"


  tags = {
    Name = "wordpress"
  }
}
resource "aws_instance" "mysql" {
  ami           = "ami-09504fb0a86d17274"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = ["${aws_security_group.mysqlsecurity.id}"]
  key_name = "mchung-dell-pem"
  availability_zone = "us-east-2"


 tags = {
    Name = "mysql"
  }
}
