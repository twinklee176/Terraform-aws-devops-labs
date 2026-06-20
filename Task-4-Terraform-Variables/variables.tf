variable "aws_region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "users" {
  type = list(string)
}

variable "instance_types" {
  type = map(string)
}

variable "server_config" {
  type = object({
    instance_type = string
    user_name     = string
  })
}
