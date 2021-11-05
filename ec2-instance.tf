resource "aws_instance" "wordpress" {
  ami           = "ami-000cbce3e1b899ebd"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = ["${aws_security_group.mywebsecurity.id}"]
  key_name = "mchung-dell-pem"
  availability_zone = "ap-south-1a"


  tags = {
    Name = "wordpress"
  }
}
resource "aws_instance" "mysql" {
  ami           = "ami-08706cb5f68222d09"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = ["${aws_security_group.mysqlsecurity.id}"]
  key_name = "mchung-dell-pem"
  availability_zone = "ap-south-1b"


 tags = {
    Name = "mysql"
  }
}
