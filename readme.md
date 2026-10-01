# Azure VMSS behind a Load Balancer (Terraform)

A web tier on Azure: a Virtual Machine Scale Set in a private subnet, served through a public Load Balancer, with outbound access via a NAT Gateway and Terraform state stored in Azure Blob Storage.

```mermaid
%%{init: {"flowchart": {"wrappingWidth": 320}}}%%
flowchart LR
    subgraph OPS[" "]
        direction TB
        admin["👤 Admin / DevOps"] --> tf["Terraform"]
        tf -->|init| state[("State file<br/>Azure Blob")]
    end

    user["👤 User"] --> internet(("Internet"))

    subgraph RG["Resource Group"]
        pip["Public IP"] -->|80| lb["Load Balancer<br/>probe: HTTP 80"]
        subgraph VNET["VNet 10.0.0.0/16"]
            subgraph SUBNET["Subnet A · NSG"]
                subgraph VMSS["VM Scale Set (backend pool)"]
                    vm1["VM 1"]
                    vm2["VM 2"]
                    vm3["VM 3"]
                end
            end
        end
        nat["NAT Gateway"]
    end

    scale["Autoscaling<br/>default 3 · min 1 · max 10<br/>CPU > 80% → scale out (todo)<br/>CPU < 10% → scale in (todo)"]

    tf ==>|plan / apply| RG
    internet --> pip
    lb --> vm1
    lb --> vm2
    lb --> vm3
    VMSS -->|outbound| nat
    nat --> out(("Internet"))
    scale -.-> VMSS
```
