resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.public_ec2.id
}
resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 2
}