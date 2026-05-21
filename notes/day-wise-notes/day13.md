# Day 13 20-5-2026

## AGW with WAF

1. Create `RG-1`, `VNET-1(10.0.0.0/16)`, `SNET-1(10.0.0.0/24)` delegated to Microsoft.Network/applicationGateways, `SNET-2(10.0.1.0/24)` for VMs.
2. Create `VM-1` and `VM-2` in SNET-2, and make `NSG(80 from 10.0.0.0/24)` and `NAT` and attach to SNET-2.
3. Setup VMs with different webapps to differenciate -

    ```sh

    sudo apt update
    sudo apt install apache2 -y

    echo "<h1>WELCOME FROM VM-1</h1>" | sudo tee /var/www/html/index.html

    ```

4. Test locally `curl http://<private-ip-of-vm>`
5. Create Application gateway `AGW-1` with `WAF_v2` and add it to `SNET-1`.
6. Set new public ip `AGW-IP`, name firewall `WAF-1`
7. Configure Backend HTTP Settings and `override route to /`.
8. Configure 2 Backend pools for different VMs.
9. Create listener from 80, and Create a Path based Routing Rule, give one pool as default(root) and give `/vm1/*` and `/vm2/*` for each pool.
10. Test loadbalancing with `http://<Application-Gateway-Public-IP>`.
11. Test path based routing with `http://<Public-IP>/vm1/` and `http://<Public-IP>/vm2/`.
