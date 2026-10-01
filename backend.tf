terraform {

  backend "azurerm" {
    resource_group_name  = "cloud-with-nand"
    storage_account_name = "testbucketfornand"
    container_name       = "statefiles"
    key                  = "metaarguments.terraform.tfstate"
  }
}