# Day 1 Notes (06-05-2026)

## Introduction

- ip address classification
- cidr
- how to create subnets, what is the range
- NAT gateway
- l4 l7 protocols
- ip address segmentation

### Azure IP address classification

- Public IPs
  - SKU (Standard or Basic)
  - allocation method (Static or Dynamic)
    - Static reserved
    - Dynamic changes upon stopping
  - zone resilience (Zonal/Zone-redundant)
    - Zone-redundant - multiple zones
    - Zonal - specific zone
- Private IPs
  - managed within Azure Virtual Networks (VNet)
  - five addresses reserved per subnet (Azure reserves the first four and last address in each subnet)
  - Assignment: Static or Dynamic
- Public IPs are used for communication with the internet, while Private IPs are used for communication within Azure Virtual Networks.

#### IPv4 Classful Addressing Structure

- Class A: Range 1.0.0.0 – 127.255.255.255. Used for large organizations, providing up to \(16,777,214\) hosts per network.
- Class B: Range 128.0.0.0 – 191.255.255.255. Used for medium-sized networks, allowing \(65,534\) hosts per network.
- Class C: Range 192.0.0.0 – 223.255.255.255. Used for small local area networks (LANs), allowing 254 hosts per network.
- Class D: Range 224.0.0.0 – 239.255.255.255. Reserved for Multicast—a single packet sent to multiple destinations.
- Class E: Range 240.0.0.0 – 255.255.255.255. Reserved for Experimental and future use.


#### Range of Special IP Addresses

- 169.254.0.0 – 169.254.255.255: Used as link-local addresses when a device cannot obtain an IP address from a DHCP server.
- 127.0.0.0 – 127.255.255.255: Reserved for loopback addresses, used to test network functionality on the local machine.
- 0.0.0.0 – 0.255.255.255 (0.0.0.0/8): Represents the current network and is used during initialization before a device is assigned a valid IP address.

#### Service Tags

Represent IP address ranges for specific Azure services (e.g., Azure Storage, Azure SQL), used for simplifying Network Security Group (NSG) rules.

#### IP Groups

Allow grouping multiple IP addresses, IP ranges, or CIDR notation for Azure Firewall rules.

#### IPv4 vs IPv6

Azure supports both public and private IP addresses in IPv4, with IPv6 supported for public IP addresses.

- Public IPs are generally a paid service
- IP Ranges are updated weekly by Microsoft
- Special Platform Addresses include 168.63.129.16 (public) and FE80::1234:5678:9ABC/128 (private).

### CIDR (Classless Inter-Domain Routing)

CIDR is an IP addressing method that improves efficiency in allocating and routing Internet Protocol (IP) addresses compared to the older classful system.

- CIDR address includes an IP address, a slash (/), and a number representing the network prefix.
- The number after the slash indicates how many bits are used for the network ID, while the remaining bits designate hosts.
- Unlike classful, subnet masks can vary, allowing for smaller or larger networks (e.g., a /24 gives \(2^8=256\) addresses, whereas a /23 gives \(2^9=512\)).

Classful addressing wastes IP addresses:

Class | IPs Available | Hosts | Example Wastage
--- | --- | --- | ---
A | 2²⁴ | 2²⁴ - 2 | Too large for small orgs
B | 2¹⁶ | 2¹⁶ - 2 | Wastes 49,150 hosts for 214 needed
C | 2⁸ | 2⁸ - 2 | Small networks only

```sh

seetup azure account

```
