# Terraform Docker Challenge
# 
# Your task: Deploy nginx and redis containers on a shared network
#
# Documentation: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

# TODO: Configure the required provider (kreuzwerker/docker)
terraform {
  required_providers {
    # Your code here
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

# TODO: Configure the Docker provider
provider "docker" {
  host = "unix:///run/user/1000/podman/podman.sock" # for my local server
  # host = "unix:///var/run/docker.sock" #for docker, and not my local server
}

# TODO: Create a Docker network named "challenge-net"
resource "docker_network" "challenge_net" {
  name = "challenge_net"
}

# TODO: Pull the nginx:alpine image
resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

# TODO: Pull the redis:alpine image
resource "docker_image" "redis" {
  name = "redis:alpine"
}

# TODO: Create the nginx container
# - Use the variable for the name
# - Attach to the network
# - Expose the port using the variable
resource "docker_container" "nginx" {
  name  = var.nginx_container_name
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.nginx_external_port
  }
  networks_advanced {
    name = docker_network.challenge_net.name
  }
}

# TODO: Create the redis container
# - Use the variable for the name
# - Attach to the network
resource "docker_container" "redis" {
  name  = var.redis_container_name
  image = docker_image.redis.image_id
  networks_advanced {
    name = docker_network.challenge_net.name
  }
}
