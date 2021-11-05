#Public Subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.ownvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-2a"
}

#Private Subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.ownvpc.id
    cidr_block = "192.168.0.0/24"
    availability_zone = "ap-south-1b"
}

#Internet Gateway
resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.ownvpc.id
}

resource "aws_route_table" "my_route_table1" {
  vpc_id = aws_vpc.ownvpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }
}
#Routing Table
resource "aws_route_table_association" "route_table_association1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.my_route_table1.id
}

#NAT GW as Target
resource "aws_route_table" "my_route_table2" {
  vpc_id = aws_vpc.ownvpc.id
  depends_on = [aws_nat_gateway.mynatgw]


  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mynatgw.id
  }
}

#EIP with NAT GW
resource "aws_eip" "nat" {
  vpc      = true
  depends_on = [aws_internet_gateway.mygw,]

}
#NAT GW with EIP Address
resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  depends_on = [aws_internet_gateway.mygw,]

}


