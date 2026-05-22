# Day 12 19-5-2026

## Terraform for VMSS setup

1. Create a VMSS.
2. Deploy organic ghee app with bootsrap script.
3. Configure load balancer for the VMSS.
4. Configure auto-scaling for the VMSS based on CPU usage.
5. Monitor the VMSS instances and load balancer performance using Azure Monitor.
6. setup azure bus service. when traffic increases, recive notification to mail.

root/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules/
    ├── vmss/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
    ├── vnet/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
    ├── lb/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf

## Assignments to cfreate agents

1. Design devops agents for self healing of the pipelines and debug the errors when pipeline runs 24/7.
2. Design agents which can analyze the k8s logs once you deploy the app in k8s, which will read, analyze, identify errors, send alerts from logs.
3. Design agent that will write the pipeline based on the nlp.
4. Design agent which understand monitoring dashbords and threshold, the agent has to create alert and send it to slack, it should create alert based on the prompts.

## Explore

1. How WAF is differ from nsg, firewall and asg
2. What is layer 7 and layer 4
3. What are the security concerns we have, how are we routing the traffic.
4. when we need to implement WAF.
5. OWASP, what are the owasp vulnerabilities
6. what is sql injection
7. how to inject the malitias code
