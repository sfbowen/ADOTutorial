provider "azurerm" {

    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name     = "tf_rg_blobstore"
        storage_account_name    = "tfstoragesfbowen"
        container_name          = "tfstate"
        key                     = "terraform.tfstate"
    }
}
resource "azurerm_resource_group" "tf_testStu" {
    name = "tfrgmain"
    location = "australiaeast"
  
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_testStu.location
    resource_group_name = azurerm_resource_group.tf_testStu.name

    ip_address_type = "Public"
    dns_name_label = "stubowwapi"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "sfbowen/weatherapi"
        cpu = "1"
        memory = "1"

        ports {
            port = 80
            protocol = "TCP"
        }
    }
}