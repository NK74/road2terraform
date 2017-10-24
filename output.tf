output "vpc_id" {
  value = "${aws_vpc.vpcvalentin.id}"
}

output "subnet_1" {
  value = "${aws_subnet.subnet1.id}"
}

output "subnet_2" {
  value = "${aws_subnet.subnet2.id}"
}

output "subnet_all" {
  value = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]
}
