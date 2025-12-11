# 🎲 Terraform API Explorer Challenge

Learn data sources, JSON parsing, and managed randomness - no Docker required!

## Overview

This exercise teaches:
- HTTP data sources for querying external APIs
- JSON parsing with `jsondecode()`
- The difference between data sources and resources
- How random resources persist in state
- String interpolation for outputs

## Why This Exercise?

This is a **zero-infrastructure** alternative to Docker-based exercises. It only needs:
- Terraform
- Internet access (to reach a public API)

Perfect for devcontainers without Docker-in-Docker configured.

## Files

- `LAB.md` - Student instructions
- `RUBRIC.md` - Grading criteria
- `starter/` - Scaffolded files for students
- `solution/` - Complete working solution

## Quick Start (Instructor Testing)

```bash
cd solution
terraform init
terraform apply -auto-approve
terraform output

# Verify behavior
terraform apply -auto-approve  # Quote may change, codename stays same
```

## Requirements

- Internet access (hits https://api.kanye.rest)
- Terraform 1.0+

## Key Teaching Points

1. **Data source vs Resource**: `data "http"` reads data, `resource "random_pet"` creates managed state
2. **State persistence**: Random values persist until destroyed
3. **JSON parsing**: API returns string, must use `jsondecode()`
