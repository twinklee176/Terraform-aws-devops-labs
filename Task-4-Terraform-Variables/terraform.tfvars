aws_region   = "ap-south-1"

instance_type = "t3.micro"

instance_name = "terraform-demo-server"

ami_id = "ami-0f58b397bc5c1f2e8"

users = [
  "itw",
  "itw",
  "sm",
  "sm",
  "ingenious"
]

instance_types = {
  dev  = "t3.micro"
  test = "t3.small"
  prod = "t3.medium"
}

server_config = {
  instance_type = "t3.micro"
  user_name     = "itw"
}
