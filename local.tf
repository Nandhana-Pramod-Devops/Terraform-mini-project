locals {
  nsg_rules = {
    "allow-http" = {
      priority               = 100
      destination_port_range = "80"
      description            = "Allow Http"
    },
    "allow-https" = {
      priority               = 110
      destination_port_range = "443"
      description            = "Allow Https"
    },
    allow-ssh = {
      priority               = 120
      direction              = "Inbound"
      destination_port_range = "22"
      description            = "Allow Ssh"
    }
  }
}
