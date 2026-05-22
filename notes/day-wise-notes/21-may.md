# Day 14 (21-05-2026)
# Domain Based Routing with Application Gateway WAF + Private VMs + NAT Gateway

# Domains

```text
app1.maheshrevs.online
app2.maheshrevs.online
```

---

# Architecture

```text
Internet
   │
   ▼
DNS
   │
   ▼
app-gw-waf
(Application Gateway WAF)
   │
   ├── app1.maheshrevs.online → app1-vm
   │
   └── app2.maheshrevs.online → app2-vm
                    │
                    ▼
                 nat-gw
                    │
                    ▼
              Internet Access
```

---

# Resources Used

## Resource Group

```text
Mahesh-RG
```

---

## Virtual Network

```text
VNET
```

---

## Bastion Network

```text
VNET-bastion
```

---

## Network Security Group

```text
domain-nsg
```

---

## NAT Gateway

```text
nat-gw
```

---

## NAT Public IP

```text
nat-pip
```

---

## Application Gateway WAF

```text
app-gw-waf
```

---

## Application Gateway Public IP

```text
appgw-pip
```

---

## WAF Policy

```text
WAF
```

---

## Virtual Machines

```text
app1-vm
app2-vm
```

---

# Step 1 — Create Resource Group

Go to:

```text
Azure Portal
→ Resource Groups
→ Create
```

Fill:

```text
Resource Group Name : Mahesh-RG
Region              : Central India
```

Click:

```text
Review + Create
```

---

# Step 2 — Create Virtual Network

Go to:

```text
Virtual Networks
→ Create
```

Fill:

```text
Name            : VNET
Region          : Central India
Address Space   : 10.0.0.0/16
```

Create two subnets.

---

## Subnet 1 — Application Gateway Subnet

```text
Name : appgw-subnet
CIDR : 10.0.1.0/24
```

---

## Subnet 2 — VM Subnet

```text
Name : vm-subnet
CIDR : 10.0.2.0/24
```

Click:

```text
Review + Create
```

---

# Step 3 — Create Bastion Subnet

Inside VNET create another subnet.

Go to:

```text
VNET
→ Subnets
→ Add
```

Fill:

```text
Subnet Name : AzureBastionSubnet
CIDR        : 10.0.3.0/24
```

Save.

---

# Step 4 — Create Azure Bastion

Go to:

```text
Azure Bastion
→ Create
```

Fill:

```text
Name            : VNET-bastion
Resource Group  : Mahesh-RG
Region          : Central India
Virtual Network : VNET
Subnet          : AzureBastionSubnet
```

Create new Public IP:

```text
bastion-pip
```

Create Bastion.

---

# Step 5 — Create Network Security Group

Go to:

```text
Network Security Groups
→ Create
```

Fill:

```text
Name   : domain-nsg
Region : Central India
```

Create.

---

# Step 6 — Add NSG Rules

Inside NSG:

```text
Inbound Security Rules
→ Add
```

---

## Allow HTTP

```text
Port     : 80
Protocol : TCP
Action   : Allow
Priority : 100
```

---

## Allow HTTPS

```text
Port     : 443
Protocol : TCP
Action   : Allow
Priority : 110
```

---

## Allow SSH

```text
Port     : 22
Protocol : TCP
Action   : Allow
Priority : 120
```

---

# Step 7 — Associate NSG with VM Subnet

Go to:

```text
domain-nsg
→ Subnets
→ Associate
```

Choose:

```text
VNet   : VNET
Subnet : vm-subnet
```

Save.

---

# Step 8 — Create app1-vm

Go to:

```text
Virtual Machines
→ Create
```

Fill:

```text
VM Name             : app1-vm
Region              : Central India
Availability Zone   : Zone 3
Image               : Ubuntu 22.04 Gen2
Size                : Standard_DC1ds_v3
Authentication Type : Password
Username            : Mahesh
Password            : Mahesh@050903
```

Networking:

```text
VNet      : VNET
Subnet    : vm-subnet
Public IP : None
NSG       : domain-nsg
```

Create VM.

---

# Step 9 — Create app2-vm

Repeat same process.

Change only:

```text
VM Name : app2-vm
```

Everything else remains same.

---

# Step 10 — Create NAT Gateway Public IP

Go to:

```text
Public IP Addresses
→ Create
```

Fill:

```text
Name               : nat-pip
Region             : Central India
SKU                : Standard
Assignment         : Static
Availability Zone  : Zone 3
```

Create.

---

# Step 11 — Create NAT Gateway

Go to:

```text
NAT Gateway
→ Create
```

Fill:

```text
Name            : nat-gw
Region          : Central India
Resource Group  : Mahesh-RG
```

Under Outbound IP:

```text
Select nat-pip
```

Create NAT Gateway.

---

# Step 12 — Associate NAT Gateway with VM Subnet

Go to:

```text
nat-gw
→ Subnets
→ Associate
```

Choose:

```text
VNet   : VNET
Subnet : vm-subnet
```

Save.

---

# Step 13 — Verify Outbound Internet

Connect to VM using Bastion.

Run:

```bash
sudo apt update
```

OR

```bash
curl google.com
```

Internet access should work through NAT Gateway.

---

# Step 14 — Install Application in app1-vm

Connect using Bastion.

Run:

```bash
sudo apt update -y
sudo apt install nginx nodejs npm git -y

cd /home/Mahesh

git clone https://github.com/Msocial123/organic-ghee.git

cd organic-ghee

npm install

nohup node src/app.js > app.log 2>&1 &
```

---

# Step 15 — Install Application in app2-vm

Connect using Bastion.

Run:

```bash
sudo apt update -y
sudo apt install nginx -y

echo "<h1>APP2 SERVER</h1>" | sudo tee /var/www/html/index.html
```

---

# Step 16 — Create Public IP for Application Gateway

Go to:

```text
Public IP Addresses
→ Create
```

Fill:

```text
Name               : appgw-pip
Region             : Central India
SKU                : Standard
Assignment         : Static
Availability Zone  : Zone 3
```

Create.

---

# Step 17 — Create WAF Policy

Go to:

```text
WAF Policies
→ Create
```

Fill:

```text
Name  : WAF
Type  : Application Gateway
Mode  : Prevention
```

Create.

---

# Step 18 — Create Application Gateway WAF v2

Go to:

```text
Application Gateways
→ Create
```

---

# Basics

Fill:

```text
Name              : app-gw-waf
Region            : Central India
Tier              : WAF V2
Autoscaling       : Enabled
Minimum Instances : 1
Maximum Instances : 5
```

---

# Frontend

Choose:

```text
Frontend Type : Public
Public IP     : appgw-pip
Frontend Port : 80
```

---

# Backend Pools

## Pool 1

```text
Pool Name : app1-pool
Target    : app1-vm private IP
```

---

## Pool 2

```text
Pool Name : app2-pool
Target    : app2-vm private IP
```

---

# Routing Rules

## Rule 1

```text
Rule Name      : app1-rule
Listener Type  : Multi Site
Hostname       : app1.maheshrevs.online
Backend Pool   : app1-pool
Backend Port   : 80
```

---

## Rule 2

```text
Rule Name      : app2-rule
Listener Type  : Multi Site
Hostname       : app2.maheshrevs.online
Backend Pool   : app2-pool
Backend Port   : 80
```

---

# Attach WAF Policy

Select:

```text
WAF
```

Create Application Gateway.

Deployment time:

```text
10–20 minutes
```

---

# Step 19 — Configure DNS

Go to your domain provider.

Create A records.

---

## Record 1

```text
Type  : A
Host  : app1
Value : appgw-pip public IP
```

---

## Record 2

```text
Type  : A
Host  : app2
Value : appgw-pip public IP
```

Save DNS records.

DNS propagation may take:

```text
5 minutes to 1 hour
```

---

# Step 20 — Verify

Open:

```text
http://app1.maheshrevs.online
```

Should open:

```text
app1-vm application
```

---

Open:

```text
http://app2.maheshrevs.online
```

Should open:

```text
app2-vm application
```

---

# Final Production Architecture

```text
Internet
   │
   ▼
DNS
   │
   ▼
app-gw-waf
(Application Gateway WAF)
   │
   ├── app1-vm
   │
   └── app2-vm
          │
          ▼
        nat-gw
          │
          ▼
   Outbound Internet
```