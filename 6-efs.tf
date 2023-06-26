resource "aws_efs_file_system" "efs" {
  creation_token = "efs-token"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"

  tags = {
    Name = "EFS"
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count          = 3
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.private[count.index].id
}
