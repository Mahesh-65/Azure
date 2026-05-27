## 25-05-2026

# Creating global virtual network peering infrastructure for review

## Azure Portal Deployment Steps

Resource Group:
```text
rg-multiregion-architecture
```

Regions:
- East US
- Central India

Architecture Includes:
- Multi-region VNets
- VNet Peering
- Bastion
- Application Gateway + WAF
- VMSS
- Internal Load Balancer
- Cosmos DB
- Private Endpoint

---

# Final Architecture Flow

```text
Internet User
      ↓
Application Gateway + WAF (East US)
      ↓
VNet Peering
      ↓
Internal Load Balancer (Central India)
      ↓
VMSS Instances (Private Subnet)
      ↓
Cosmos DB Private Endpoint
```

---

# Step 1 — Create Resource Group

## Azure Portal Navigation

```text
Azure Portal
→ Resource Groups
→ Create
```

---

## Configuration

| Field | Value |
|---|---|
| Resource Group Name | rg-multiregion-architecture |
| Region | East US |

Click:
```text
Review + Create
→ Create
```

---

# Step 2 — Create East US VNet

## Navigation

```text
Azure Portal
→ Virtual Networks
→ Create
```

---

# Basics

| Field | Value |
|---|---|
| Resource Group | rg-multiregion-architecture |
| Name | vnet-eastus |
| Region | East US |

---

# IP Addresses

## Address Space

```text
10.0.0.0/16
```

---

# Add Subnets

| Subnet Name | Address Range |
|---|---|
| AzureBastionSubnet | 10.0.1.0/24 |
| appgw-subnet | 10.0.2.0/24 |

Create VNet.

---

# Step 3 — Create Central India App VNet

## Create VNet

| Field | Value |
|---|---|
| Name | vnet-centralindia-app |
| Region | Central India |
| Address Space | 10.1.0.0/16 |

---

# Add App Subnet

| Subnet | Address |
|---|---|
| app-private-subnet | 10.1.1.0/24 |

Create VNet.

---

# Step 4 — Create Central India DB VNet

## Create VNet

| Field | Value |
|---|---|
| Name | vnet-centralindia-db |
| Region | Central India |
| Address Space | 10.2.0.0/16 |

---

# Add DB Subnet

| Subnet | Address |
|---|---|
| db-private-subnet | 10.2.1.0/24 |

Create VNet.

---

# Step 5 — Configure VNet Peering

---

# East US → Central India App

## Navigation

```text
vnet-eastus
→ Peerings
→ + Add
```

---

# Configuration

| Field | Value |
|---|---|
| Peering Link Name | eastus-to-app |
| Remote Virtual Network | vnet-centralindia-app |
| Allow Virtual Network Access | Enabled |

Create Peering.

---

# Central India App → East US

## Navigation

```text
vnet-centralindia-app
→ Peerings
→ + Add
```

---

# Configuration

| Field | Value |
|---|---|
| Peering Link Name | app-to-eastus |
| Remote Virtual Network | vnet-eastus |
| Allow Virtual Network Access | Enabled |

Create Peering.

---

# App VNet ↔ DB VNet Peering

Create bidirectional peering between:
- vnet-centralindia-app
- vnet-centralindia-db

Enable:
```text
Allow Virtual Network Access
```

---

# Step 6 — Create Bastion Public IP

## Navigation

```text
Azure Portal
→ Public IP Addresses
→ Create
```

---

# Configuration

| Field | Value |
|---|---|
| Name | bastion-pip |
| SKU | Standard |
| Region | East US |

Create.

---

# Step 7 — Create Azure Bastion

## Navigation

```text
Azure Portal
→ Bastions
→ Create
```

---

# Configuration

| Field | Value |
|---|---|
| Name | bastion-host |
| Region | East US |
| VNet | vnet-eastus |
| Subnet | AzureBastionSubnet |
| Public IP | bastion-pip |

Create Bastion.

---

# Step 8 — Create Public IP for Application Gateway

## Navigation

```text
Azure Portal
→ Public IP Addresses
→ Create
```

---

# Configuration

| Field | Value |
|---|---|
| Name | appgw-pip |
| SKU | Standard |
| Region | East US |

Create.

---

# Step 9 — Create Internal Load Balancer

## Navigation

```text
Azure Portal
→ Load Balancers
→ Create
```

---

# Basics

| Field | Value |
|---|---|
| Name | internal-lb |
| Region | Central India |
| Type | Internal |
| SKU | Standard |

---

# Frontend IP Configuration

| Field | Value |
|---|---|
| VNet | vnet-centralindia-app |
| Subnet | app-private-subnet |
| Private IP | 10.1.1.10 |

Create Load Balancer.

---

# Step 10 — Create VM Scale Set

## Navigation

```text
Azure Portal
→ Virtual Machine Scale Sets
→ Create
```

---

# Basics

| Field | Value |
|---|---|
| Resource Group | rg-multiregion-architecture |
| Name | vmss-app |
| Region | Central India |
| Image | Ubuntu Server 22.04 |
| Size | Standard_B2s |
| Orchestration Mode | Uniform |

---

# Administrator Account

Choose:
```text
SSH Public Key
```

or

```text
Password
```

---

# Networking

| Field | Value |
|---|---|
| VNet | vnet-centralindia-app |
| Subnet | app-private-subnet |
| Load Balancing | Azure Load Balancer |
| Load Balancer | internal-lb |

---

# Scaling

Enable:
```text
Autoscaling
```

---

# Autoscaling Settings

| Setting | Value |
|---|---|
| Minimum Instances | 2 |
| Maximum Instances | 5 |
| Scale Out Rule | CPU > 70% |
| Scale In Rule | CPU < 30% |

Create VMSS.

---

# Step 11 — Install NGINX in VMSS

## Navigation

```text
VMSS
→ Extensions + Applications
→ Add
```

Choose:
```text
Custom Script Extension
```

---

# Command

```text
apt update
apt install nginx -y
systemctl enable nginx
systemctl start nginx
```

Save Extension.

---

# Step 12 — Create WAF Policy

## Navigation

```text
Azure Portal
→ WAF Policies
→ Create
```

---

# Configuration

| Field | Value |
|---|---|
| Name | waf-policy |
| Resource Type | Application Gateway |

---

# WAF Mode

Choose:
```text
Prevention
```

Create Policy.

---

# Step 13 — Create Application Gateway

## Navigation

```text
Azure Portal
→ Application Gateways
→ Create
```

---

# Basics

| Field | Value |
|---|---|
| Name | app-gateway |
| Region | East US |
| Tier | WAF_v2 |

---

# Frontend

| Field | Value |
|---|---|
| Public IP | appgw-pip |

---

# Backend Pool

Add backend target:

```text
10.1.1.10
```

(Internal Load Balancer IP)

---

# Listener

Configure:
- HTTPS
- Port 443
- Frontend IP

---

# Routing Rule

Create:
```text
Basic Rule
```

Map:
- Listener
- Backend Pool

---

# WAF

Attach:
```text
waf-policy
```

Create Application Gateway.

---

# Step 14 — Create Cosmos DB

## Navigation

```text
Azure Portal
→ Azure Cosmos DB
→ Create
```

---

# Configuration

| Field | Value |
|---|---|
| API | NoSQL |
| Name | mahesh-cosmos-db |
| Region | Central India |

Enable:
```text
Automatic Failover
```

Create Database.

---

# Step 15 — Configure Cosmos DB Networking

## Navigation

```text
Cosmos DB
→ Networking
```

---

# Settings

Disable:
```text
Public Network Access
```

Enable:
```text
Private Endpoint
```

---

# Create Private Endpoint

| Field | Value |
|---|---|
| Name | cosmos-private-endpoint |
| VNet | vnet-centralindia-db |
| Subnet | db-private-subnet |

Create Endpoint.

---

# Step 16 — Create NSGs

## Navigation

```text
Azure Portal
→ Network Security Groups
→ Create
```

Create:
- nsg-app-subnet
- nsg-db-subnet

---

# App NSG Rules

Allow:
- Application Gateway subnet
- Bastion subnet
- Internal VNet traffic

Deny:
- Direct internet inbound

Associate with:
```text
app-private-subnet
```

---

# DB NSG Rules

Allow:
- App subnet only

Deny:
- Public access

Associate with:
```text
db-private-subnet
```

---

# Step 17 — Verify Application

---

# Check Application Gateway

Open browser:

```text
http://<ApplicationGatewayPublicIP>
```

Expected:
```text
NGINX Welcome Page
```

---

# Verify VMSS

## Navigation

```text
VMSS
→ Instances
```

Ensure:
- 2 instances running
- Healthy state

---

# Verify Private Endpoint

## Navigation

```text
Cosmos DB
→ Networking
```

Verify:
```text
Private Endpoint Connected
Public Access Disabled
```

---

# Step 18 — Enable Monitoring (Recommended)

Enable:
- Azure Monitor
- Log Analytics
- Diagnostic Logs
- Alerts

---

# Architecture Security Features

| Component | Security Benefit |
|---|---|
| WAF | Protects against OWASP attacks |
| Bastion | Secure VM access |
| Private Subnets | No public exposure |
| Private Endpoint | Secure DB connectivity |
| NSGs | Traffic filtering |
| VNet Peering | Private regional communication |

---

# High Availability Features

| Feature | Purpose |
|---|---|
| VMSS | Auto-healing + autoscaling |
| Internal Load Balancer | Traffic distribution |
| Multi-region VNets | Regional resiliency |
| WAF_v2 | Redundant gateway |
| Cosmos DB | Geo-redundancy |

---

# Final Architecture Summary

| Component | Purpose |
|---|---|
| Bastion | Secure administrative access |
| Application Gateway | SSL termination + routing |
| WAF | Application-layer security |
| VMSS | Scalable application compute |
| Internal Load Balancer | Internal HA traffic distribution |
| Cosmos DB | Distributed database |
| Private Endpoint | Secure DB communication |
| VNet Peering | Cross-region private connectivity |