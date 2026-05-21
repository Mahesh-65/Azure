# day 8 14-5-2026

## vnet peering is non transitive

- If virtual network A is peered with virtual network B, and virtual network B is peered with virtual network C, virtual network A is not automatically peered with virtual network C. You must explicitly peer virtual network A with virtual network C to enable communication between them.
- This non-transitive nature of virtual network peering allows for greater control over network traffic and security, as you can choose which virtual networks can communicate with each other. It also helps to prevent unintended communication between virtual networks that may not be directly peered, reducing the risk of security breaches or data leaks.
