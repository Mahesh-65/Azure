# Day 11 18-5-2026

## IKEv2 ( Internet Key Exchange version 2)

- IKEv2 is a protocol used to establish a secure and authenticated communication channel between two parties, typically in the context of virtual private networks (VPNs) or secure communication over the internet.

## VPN Gateway

- A VPN gateway is a network device that serves as a secure entry point for remote users or sites to connect to a private network over the internet. It acts as a bridge between the public internet and the private network, allowing authorized users to access resources within the private network securely.
- VPN gateways typically use encryption and authentication protocols to ensure the confidentiality and integrity of data transmitted between the remote users or sites and the private network. They can be implemented as hardware appliances, software solutions, or cloud-based services, depending on the specific requirements of the organization.
- VPN gateways will do:
  - Encryption
  - Decryption
  - Authentication
  - Routing
  - Tunneling
  - Key management

## Route when pinging from on-premise to azure VM 192.168.1.50 to 10.1.0.4

1. The on-premises device (192.168.1.50) sends a ping request to the Azure VM (10.1.0.4).
2. The request is routed through the on-premises network and reaches the VPN gateway.
3. The VPN gateway encrypts the packet and forwards it to the Azure virtual network.
4. The packet is decrypted by the Azure VPN gateway and delivered to the target VM (10.1.0.4).

## 1. IKE SA (Security Association) Establishment

### IKE Negotiation

- The VPN gateway initiates the IKEv2 negotiation process to establish a secure connection with the remote device. This involves exchanging messages to authenticate each other and agree on encryption algorithms and keys. it will send:
  - Encryption algorithms: AES-256, AES-128, 3DES
  - Authentication methods: Pre-shared keys (PSK), digital certificates, or EAP
  - Key exchange methods: Diffie-Hellman groups (e.g., Group 14, Group 24)
  - Hash algorithms: SHA-256, SHA-1
  
### Diffie-Hellman Ephemeral (DHE)

1. Alice and Bob agree on a large prime number (p) and a base (g) that are publicly known.
2. Alice chooses a private key (a) and calculates her public key (A = g^a mod p) and sends it to Bob.
3. Bob chooses a private key (b) and calculates his public key (B = g^b mod p) and sends it to Alice.
4. Alice calculates the shared secret key (s = B^a mod p) using Bob's public key and her private key.
5. Bob calculates the shared secret key (s = A^b mod p) using Alice's public key and his private key.
6. Both Alice and Bob now have the same shared secret key (s) that can be used for secure communication.

- An eavesdropper who intercepts the public keys (A and B) cannot easily derive the shared secret key (s) without knowing the private keys (a and b), making the communication secure.

## 2. IPsec SA Establishment

- After the IKE SA is established, the VPN gateway and the remote device negotiate the IPsec Security Association (SA) to define the parameters for encrypting and authenticating the actual data traffic. This includes agreeing on encryption algorithms, authentication methods, and key lifetimes for the IPsec connection.
  - Encryption algorithms: AES-256, AES-128, 3DES
  - Authentication methods: HMAC-SHA-256, HMAC-SHA-1
  - Key lifetimes: The duration for which the keys are valid before they need to be renegotiated (e.g., 3600 seconds).

1. The VPN gateway and the remote device exchange messages to negotiate the IPsec SA parameters, such as encryption algorithms (e.g., AES-256), authentication methods (e.g., HMAC-SHA-256), and key lifetimes.
2. Once the IPsec SA is established, the VPN gateway and the remote device can securely transmit data using the agreed-upon parameters for encryption and authentication.
3. The VPN gateway will encrypt the data packets using the negotiated encryption algorithm and authenticate them using the agreed-upon authentication method before sending them over the internet to the remote device. The remote device will then decrypt and verify the authenticity of the received packets before processing them.
4. The IPsec SA will be periodically renegotiated to ensure the security of the connection, and the VPN gateway and the remote device will exchange messages to refresh the keys and update the SA parameters as needed.

---

## VM Scale Set (VMSS)

### Load Balancer

- Distributes incoming network traffic across multiple virtual machines (VMs).
- Health monitoring of VMs to ensure traffic is only sent to healthy instances.
- Provides high availability and scalability for applications by balancing the load across multiple VMs.
