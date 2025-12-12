# Variables for the Docker challenge
#
# Define three variables:
# 1. nginx_container_name (string)
# 2. redis_container_name (string)  
# 3. nginx_external_port (number)
#
# Hint: Give them sensible defaults

# TODO: Define your variables here
variable "nginx_container_name" {
  type    = string
  default = "nginx"
}
variable "redis_container_name" {
  type    = string
  default = "redis"
}
variable "nginx_external_port" {
  type    = number
  default = 8080
}
