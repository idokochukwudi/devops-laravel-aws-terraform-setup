# --- IAM Role: Allows EC2 instances to assume this role ---
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# --- Instance Profile: Binds the IAM role to an EC2 instance ---
resource "aws_iam_instance_profile" "this" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# --- Policy Attachment: Grants the IAM role full access to S3 ---
resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
