# Exercise 01: Basic IAM User

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# TODO: Create IAM user
# - Resource type: aws_iam_user
# - Local name: exercise_user
# - Name: terraform-gym-user-${var.student_name}
# - Add all required tags

resource "aws_iam_user" "exercise_user" {
  name = "terraform-gym-user-${var.student_name}"

  tags = {
    Name         = "Exercise 01 User"
    Environment  = "Learning"
    ManagedBy    = "Terraform"
    Student      = "${var.student_name}"
    AutoTeardown = "true"
  }
}

# TODO: Create access key for the user
# - Resource type: aws_iam_access_key
# - Local name: user_key
# - Reference the user
#
# ⚠️ SECURITY WARNING: Creating access keys is a security anti-pattern!
# This is for LEARNING PURPOSES ONLY. In production, use IAM roles.

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.exercise_user.id
}

# TODO: Attach ReadOnlyAccess managed policy
# - Resource type: aws_iam_user_policy_attachment
# - Local name: readonly_policy
# - Policy ARN: arn:aws:iam::aws:policy/ReadOnlyAccess
# - For full access use: arn:aws:iam::aws:policy/AdministratorAccess

resource "aws_iam_user_policy_attachment" "readonly_policy" {
  user       = aws_iam_user.exercise_user.id
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
