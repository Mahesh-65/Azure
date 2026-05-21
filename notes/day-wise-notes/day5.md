# day 5 11-5-2026

## AWS Networking Concepts

internet - igw - vpc - routetable - subnet - VM

- **Internet Assigned Numbers Authority (IANA)**
  - primary authority responsible for assigning and maintaining official protocol port numbers.
- **Internet Service Provider (ISP)**
  - a company that provides individuals and organizations access to the internet and related services.
- **DHCP (Dynamic Host Configuration Protocol)**
  - a network management protocol used to automate the process of configuring devices on IP networks, allowing them to use network services such as DNS, NTP, and any communication protocol based on UDP or TCP.
- **CIDR (Classless Inter-Domain Routing)**
  - a method for allocating IP addresses and routing Internet Protocol packets.
- **NAT (Network Address Translation)**
  - a method of remapping one IP address space into another by modifying network address information in the IP header of packets while they are in transit across a traffic routing device.
- **NAT Gateway**
  - a service that enables instances in a private subnet to connect to the internet or other AWS services, but prevents the internet from initiating connections with those instances.

## Azure Networking Concepts

Internet - public ip - vnet - routetable - subnet - VM (me)

Internet - public ip - Azure SDN - private ip - NIC - VM (sir)

User Browser -> DNS Resolution -> Azure Public IP -> Azure Load Balancer / Application Gateway / Firewall -> NSG Rules -> VNet Routing -> VM NIC -> OS Firewall -> Application (gpt)

- **Resource Group**
  - a container that holds related resources for an Azure solution.
  - logical separation of the resources.
- **Virtual Network (VNet)**
  - a representation of your own network in the cloud.
  - where you manage your network resources, such as subnets, route tables, and network security groups.
- **Subnet**
  - a range of IP addresses in your VNet.
  - used to divide the VNet into smaller, manageable sections.
- **Network Security Group (NSG)**
  - a security rule that controls inbound and outbound traffic to network interfaces, VMs, and subnets.
- **Public IP Address**
  - an IP address that can be accessed from the internet.
- **NAT Gateway**
  - a service that enables instances in a private subnet to connect to the internet or other Azure services, but prevents the internet from initiating connections with those instances.
- **Network Interface**
  - a virtual network interface card (NIC) that connects a VM to a VNet.
- **UDR (User Defined Route)**
  - a custom route that you can create to control the routing of traffic in your VNet.
  
## Todo

- [ ] Create a Resource Group
- [ ] Create a VNet with 10.0.0.0/16 and 2 subnets with 10.0.1.0/24 (public) and 10.0.2.0/24 (private)
- [ ] Create 1 VM in each subnet and assign a public IP to the VM in the public subnet
- [ ] Create a NAT Gateway and associate it with the private subnet

---

1. Create a Resource Group
2. Create a VNet with 2 subnets
3. Create 1 VM in each subnet and assign a public IP to the VM in the public subnet
4. Create a NAT Gateway and associate it with the private subnet, with a public IP address
5. Create a NSG and associate it with the private subnet, allowing only outbound traffic to the internet (80)
6. Create a NSG and associate it with the public subnet, allowing inbound traffic from the internet (80) and outbound traffic to the internet (80)
7. Create a load balancer and associate it with the private vm, with a public IP address
8. Create a NSG and associate it with the load balancer, allowing inbound traffic from the internet (80)
9. Create a NSG and associate it with the private vm, allowing inbound traffic from the load balancer (80)
10. Expose the private vm to the internet through the load balancer and test the connectivity.


Then created terraform files for the above resources and applied them to create the infrastructure.
*Extended to day 6
