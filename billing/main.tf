terraform {
  cloud {
    organization = "pitt412"

    workspaces {
      name = "billing-sns"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
module "billing_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = "pitt412"
  monthly_billing_threshold = 10
  currency = "USD"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
    topic_arn = module.billing_alert.sns_topic_arns[0]
    protocol = "email"
    endpoint = "ibrokhimx@gmail.com"
}