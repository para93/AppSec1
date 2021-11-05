#Security Group allow http-ssh to Wordpress
resource "aws_security_group" "mywebsecurity" {
  name        = "my_web_security"
  description = "Allow http,ssh,icmp"
  vpc_id      = aws_vpc.ownvpc.id


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  ingress {
    description = "ALL ICMP - IPv4"
    from_port   = -1    
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
    
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "myweb_sg"
  }
}
resource "aws_security_group" "mysqlsecurity" {
  name        = "my_sql_server_security"
  description = "Allow mysql"
  vpc_id      = aws_vpc.ownvpc.id


  ingress {
    description = "MYSQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${aws_security_group.mywebsecurity.id}"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  
  tags = {
   Name = "mysqlserver_sg"  
 }
}
