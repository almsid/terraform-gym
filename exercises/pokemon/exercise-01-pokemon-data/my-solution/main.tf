# Exercise 01: Pokemon Data Fetching
# 
# Your mission: Fetch Pokemon data from the PokeAPI and extract useful information
#
# Documentation:
# - HTTP Provider: https://registry.terraform.io/providers/hashicorp/http/latest/docs
# - PokeAPI: https://pokeapi.co/docs/v2
#
# TIP: Test the API first!
# curl -s https://pokeapi.co/api/v2/pokemon/pikachu | jq '.'

# ============================================================================
# STEP 1: Configure the required provider
# ============================================================================

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    # TODO: Add the hashicorp/http provider, version ~> 3.0
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

# ============================================================================
# STEP 2: Fetch Pokemon data from the API
# ============================================================================

# TODO: Create an http data source named "pokemon"
# - Use var.pokemon_name in the URL
# - The URL format is: https://pokeapi.co/api/v2/pokemon/{name_or_id}
# - Add a request header: Accept = "application/json"

data "http" "pokemon" {
  url = "https://pokeapi.co/api/v2/pokemon/${var.pokemon_name}"

  request_headers = {
    Accept = "application/json"
  }
}


# ============================================================================
# STEP 3: Parse the JSON response
# ============================================================================

locals {
  # TODO: Parse the JSON response body into an HCL object
  # Hint: Use jsondecode() on data.http.pokemon.response_body
  pokemon = jsondecode(data.http.pokemon.response_body)

  # TODO: Extract the Pokemon's types as a simple list of strings
  # The raw data looks like: [{slot: 1, type: {name: "electric", url: "..."}}]
  # We want: ["electric"]
  # Hint: Use a for expression to transform the list
  # create a list of pokemon.types[*]{slot: 1, type: {name: "electric",} and get the name of each type 
  pokemon_types = [for type in local.pokemon.types[*] : type.type.name]
  # TODO: Extract the HP base stat
  # Stats looks like: [{base_stat: 35, stat: {name: "hp"}}, {base_stat: 55, stat: {name: "attack"}}, ...]
  # Hint: Use a for expression with a condition to filter for hp
  pokemon_hp = one([for stat in local.pokemon.stats[*] : stat.base_stat if stat.stat.name == "hp"])
}

# ============================================================================
# STEP 4: Create outputs (already done - just uncomment when ready!)
# ============================================================================

# Uncomment these outputs once your locals are working:

output "pokemon_id" {
  description = "The Pokemon's Pokedex number"
  value       = local.pokemon.id
}

output "pokemon_name" {
  description = "The Pokemon's name"
  value       = local.pokemon.name
}

output "pokemon_height" {
  description = "The Pokemon's height in decimeters"
  value       = local.pokemon.height
}

output "pokemon_weight" {
  description = "The Pokemon's weight in hectograms"
  value       = local.pokemon.weight
}

output "pokemon_types" {
  description = "List of the Pokemon's types"
  value       = local.pokemon_types
}

output "pokemon_hp" {
  description = "The Pokemon's base HP stat"
  value       = local.pokemon_hp
}

# STRETCH: Create a formatted Pokedex entry
output "pokedex_entry" {
  description = "Formatted Pokedex entry"
  value       = "${upper(local.pokemon.name)} (#${local.pokemon.id}) - Type: ${upper(join("/", local.pokemon_types))} - HP: ${local.pokemon_hp} - Height: ${local.pokemon.height / 10}m - Weight: ${local.pokemon.weight / 10}kg"
}
