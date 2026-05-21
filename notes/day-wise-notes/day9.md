# day 9 15-5-2026

## Site-to-Site VPN connection between AWS & Azure

1. Create a resource group "VPN" in Azure.
2. Create a virtual network "Azure-VNet" with 172.10.0.0/16 and Subnet 172.10.1.0/24.
3. Create a subnet "GatewaySubnet" with 172.10.5.0/27.
4. Create a Virtual Network Gateway "VNG" with VPN type "Route-based" with "VNG-Public-IP".

Configure the AWS side:

1. Create a Virtual Private Cloud (AWS-VPC) with CIDR block 192.16.0.0/16.
2. Create a subnet with CIDR block 192.16.1.0/24.
3. Go to route tables and associate the subnet.
4. Create a Customer Gateway with the public IP of the Azure Virtual Network Gateway.
5. Create AWS Virtual Private Gateway (VPN) and attach it to the AWS-VPC.
6. Create a Site-to-Site VPN connection between the AWS Virtual Private Gateway and the Customer Gateway. Select Routing Option is Static and add Azure VPC CIDR range (172.10.0.0/16).
7. tunnel psk # Muhammed.2003
8. Add routes in AWS-VPC route table with target as the AWS Virtual Private Gateway for the Azure VPC CIDR range (172.10.0.0/16).
9. Download the VPN configuration file for Azure Virtual Network Gateway from the Azure portal and use it to configure the AWS side of the VPN connection. (with Generic option).

Configure the Azure side:

1. Create a Local Network Gateway in Azure with the AWS VPC CIDR block 192.16.0.0/16 and the public IP of the AWS Virtual Private Gateway.
2. Create a VPN connection in Azure between the Virtual Network Gateway and the Local Network Gateway. Use the same pre-shared key (PSK) as configured on the AWS side (Muhammed.2003).
3. Create Route Table in Azure and associate it with the subnet in Azure-VNet. Add a route with destination 192.16.0.0/16 and pointing to the Virtual Network Gateway.

to access the AWS EC2 instance from Azure VM, you need to add an inbound rule in the AWS security group associated with the EC2 instance to allow traffic from the Azure VNet CIDR block (172.10.0.0/16).

to access the Azure VM from AWS EC2 instance, you need to add an inbound rule in the Azure Network Security Group (NSG) associated with the Azure VM to allow traffic from the AWS VPC CIDR block (192.16.0.0/16).

to access the AWS EC2 instance from private subnet, create a IGW and attach it to the AWS-VPC.
