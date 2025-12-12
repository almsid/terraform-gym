# Outputs for the Docker challenge
#
# Create three outputs:
# 1. network_name - The name of the Docker network
# 2. nginx_container_id - The ID of the nginx container
# 3. nginx_url - The URL to access nginx (http://localhost:<port>)
#
# Hint: Reference your resources and variables

# TODO: Define your outputs here
output "network_name" {
  value = docker_network.challenge_net.name
}
output "nginx_container_id" {
  value = docker_container.nginx.id
}
output "nginx_url" {
  value = "http://localhost:${var.nginx_external_port}"
}
