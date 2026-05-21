# Cloud

## services from cloud providers

- compute services
- networking
- storage
- ai/ml
- devops
- security
- disaster recovery

Azure vs AWS

- architecture
  - vpc vs vnet
  - availability zones
  - security models
  - Managed services
  - Storage resiliency and data replication
  - Private Connectivity to Cloud Services
- echosystem
- ...

- Network architecture: AWS offers granular control over network segmentation, but Azure simplifies it with integrated managed services, reducing manual configuration.
- Availability Zones: Azure’s managed services come with built-in zone redundancy, while AWS often requires more manual intervention to achieve multi-AZ redundancy.
- Public internet access: AWS uses an Internet Gateway for public internet access, whereas Azure simplifies this by directly assigning public IPs to resources.
- Private subnet outbound traffic: Both platforms use NAT Gateways for outbound traffic, but Azure abstracts the configuration more, making it easier to manage.
- Security models: Azure streamlines security with NSGs and ASGs, offering simpler and more flexible traffic control than AWS’s combination of Security Groups and NACLs.
- Managed services: Azure automates critical tasks like redundancy and scaling, while AWS often requires manual configuration for high availability.
- Storage resiliency: Azure provides more granular replication options, while AWS relies on predefined storage tiers.
Private endpoints: Azure’s Private Link and Endpoints offer a more seamless and integrated approach to private connectivity compared to AWS’s VPC Endpoints, which require more manual setup.

## ARM64 vs x64

- Arm is a RISC (reduced instruction set computing) architecture
- RISC prioritizes simplicity and efficiency
- Arm licenses its architecture to chipmakers
- Arm focuses on power efficiency which makes it ideal for mobile devices.
- 32-bit instruction set for Arm.

- x64 is a CISC (complex instruction set computing) architecture
- CISC offers more complex instructions
- x64 is owned by Intel and AMD.
- x64 focuses on maximum performance which is better suited for PCs and servers.
- x64 has a longer 64-bit instruction set

## Familiarize with Azure portal

```text
resource group
VM
Vnet (automatic)
subnet (automatic)
NSG (automatic)
ip (automatic)
Network interface (automatic)
port rules

```

## Azure CLI

```sh
# from company portal
or
winget install --exact --id Microsoft.AzureCLI

az login
az account list
```

## Terraform CLI

```sh
# from company portal
or
download from https://developer.hashicorp.com/terraform/downloads
```

ansible
opentofu

### pros of terraform

- multicloud support
- state management
- reusability
- modularity

## Terraform

```sh
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
# dryrun
```
