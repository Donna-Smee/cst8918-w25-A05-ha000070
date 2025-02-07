# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.3"
    }
  }
}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
}

provider "cloudinit" {
  # Configuration options
}

# Define labelPrefix variable
variable “labelPrefix” {
	type = string
	description = “Your college username. This will form the beginning of various resource names.”
}

# Define region variable
variable “region” {
	default = “westus3”
}

# Define the admin_username variable
variable “admin_username” {
	type = string
	default = “azureadmin”
	description = “The username for the local user account on the VM.”
}

# define the resource group
resource “azurerm_resource_group” “rg” {
	name = "${var.labelPrefix}-A05-RG"
	location = var.region
}

# define the public ip
resource "azurerm_public_ip" "webserver" {
  name                = “${var.labelPrefix}A05PublicIP”
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}
