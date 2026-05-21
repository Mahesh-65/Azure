# Questions and Answers

## 1. Why azure doesn't support internet gateway?

- In Microsoft Azure, there is no separate service called an “Internet Gateway” like in AWS.
- Azure handles internet connectivity differently because internet access is built directly into the Azure Virtual Network architecture.

### In AWS
- You create a VPC.
- Then attach an Internet Gateway manually.
- Without it, resources cannot access the internet.

### In Azure
Azure automatically provides internet routing for resources that have:
- Public IPs
- Load Balancers
- NAT Gateway
- Azure Firewall

### So Azure uses:
- System routes
- Public IP association
- Default outbound access

instead of a dedicated Internet Gateway component.

That is why Azure doesn’t expose a separate “Internet Gateway” resource.

---

## 2. How the routing will happen inside Azure?

- Routing inside Azure happens using Route Tables and System Routes.
- When a Virtual Network (VNet) is created, Azure automatically creates default routes.

### Default Azure Routing Flow

#### Inside same subnet
- VMs communicate directly using private IPs.

#### Between subnets in same VNet
- Azure automatically routes traffic internally.

### Example
```text
Subnet A → Subnet B
Azure backbone network handles routing.
```

### Between VNets
Routing can happen using:
- VNet Peering
- VPN Gateway
- ExpressRoute

### Internet traffic
Traffic goes through:
- Public IP
- NAT Gateway
- Azure Firewall
- Load Balancer

depending on architecture.

### Azure Route Types

#### 1. System Routes
Automatically created by Azure.

### Examples
- Local VNet routes
- Internet routes
- Default routes

#### 2. User Defined Routes (UDR)
Custom routes created by users.

### Used for
- Firewall routing
- Custom appliances
- Forced tunneling

#### 3. BGP Routes
Learned dynamically from:
- VPN Gateway
- ExpressRoute

### Example Routing Flow

### Suppose
- VM1 → Subnet A
- VM2 → Subnet B

### Flow
1. VM1 sends packet.
2. Azure checks route table.
3. Finds destination subnet.
4. Routes traffic internally over Azure backbone.
5. VM2 receives traffic.

No physical router configuration is required from the user side.

---

## 3. What are the in-built capabilities of Azure for networking?

Azure provides many built-in networking services to manage communication, security, routing, connectivity, and traffic distribution inside the cloud environment.

### 1. Virtual Network (VNet)
- Acts like a private network in Azure.
- Enables secure communication between Azure resources.
- Similar to a traditional on-premises network.

### Example
```text
10.0.0.0/16
```

### 2. Subnets
- Used to divide a VNet into smaller network segments.
- Helps in isolation and better traffic management.

### Example
- Web Subnet
- App Subnet
- DB Subnet

### 3. Network Security Group (NSG)
- Works like a firewall.
- Controls inbound and outbound traffic using rules.
- Can allow or deny traffic based on:
  - Port
  - Protocol
  - Source/Destination IP

### Example
- Allow HTTP (80)
- Deny SSH (22)

### 4. Route Tables / User Defined Routes (UDR)
- Controls how traffic moves between networks.
- Used for custom routing paths.

### Example
- Send all internet traffic through Azure Firewall.

### 5. Azure Load Balancer
- Distributes traffic across multiple servers/VMs.
- Improves availability and scalability.
- Works at Layer 4 (TCP/UDP).

### 6. Application Gateway
- Layer 7 load balancer.
- Used for HTTP/HTTPS traffic.

### Supports
- SSL termination
- URL-based routing
- Web Application Firewall (WAF)

### 7. NAT Gateway
- Provides outbound internet connectivity for private resources.
- Helps avoid exposing VMs directly to the internet.

### 8. Azure Firewall
- Managed firewall service.
- Provides centralized security and monitoring.
- Filters traffic between:
  - VNets
  - Internet
  - On-premises networks

### 9. VPN Gateway
- Connects:
  - Azure ↔ On-premises
  - Azure ↔ Azure
- Uses encrypted VPN tunnels.

### 10. ExpressRoute
- Private dedicated connection to Azure.
- Does not use the public internet.

### Provides
- Higher security
- Lower latency
- Better reliability

### 11. VNet Peering
- Connects two VNets privately.
- Traffic flows through Azure backbone network.
- No internet involvement.

### 12. Azure DNS
- Provides domain name resolution.
- Converts domain names into IP addresses.

### 13. Azure Bastion
- Securely connects to VMs using browser-based RDP/SSH.
- No need to expose public IPs.

### 14. Traffic Manager
- Distributes user traffic globally.

### Improves
- Performance
- Availability
- Disaster recovery

### 15. Private Link
- Access Azure services privately without public internet exposure.
- Improves security.

---

# Subnets

## 1. How are we creating the segments?

Subnetting means dividing a VNet into smaller logical networks.
This is done using CIDR ranges.

### Example

### Suppose VNet
```text
10.0.0.0/16
```

You can divide it into:
```text
10.0.1.0/24  → Web subnet
10.0.2.0/24  → App subnet
10.0.3.0/24  → DB subnet
```

Each subnet becomes a separate segment.

### Why do we create subnet segments?

#### Security
- Separate web, app, and DB layers.

#### Traffic control
- Apply different NSGs and routes.

#### Better management
- Organize workloads properly.

#### Isolation
- Prevent unnecessary communication.

### Example Architecture

```text
VNet: 10.0.0.0/16
├── Web Subnet     → 10.0.1.0/24
├── App Subnet     → 10.0.2.0/24
└── DB Subnet      → 10.0.3.0/24
```

### Traffic control
- Web can access App
- App can access DB
- Internet cannot directly access DB

using NSGs and routing rules.