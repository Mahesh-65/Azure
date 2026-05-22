# Day 14 22-05-2026
## AKS (Azure Kubernetes Service)

 - Azure Kubernetes Service (AKS) is a managed Kubernetes service that you can use to deploy and manage containerized applications. You need minimal container orchestration expertise to use AKS. AKS reduces the complexity and operational overhead of managing Kubernetes by offloading much of that responsibility to Azure. AKS is an ideal platform for deploying and managing containerized applications that require high availability, scalability, and portability, and for deploying applications to multiple regions, using open-source tools, and integrating with existing DevOps tools.

## Problems with on-premises cluster
 - Manual repair
 - Networking
 - High availablity
 - Master Node management
 - Auto scaling - Cluster Auto scaling
 - Data backup
 - Manual cluster upgrading
 - Storage and plugin problems
 - Secret management
 - RBAC monitoring

## Question
 1. When you are creating AKS Cluster, which CIDR block or IP address range will be using pod network?
 2. What is a Service mesh - istio


# Create AKS cluster
## Basics tab
 1. Go to Kubernetes Services
 2. Select resource group
 3. Choose "Cluster preset configuration" based on requirement
 4. Give cluster name
 5. Fleetmanager is None for now
 6. Select the zone
 7. Pricing tier is standard
 8. k8s version 1.35.4
 9. Automatic upgrade : Enables with stable
 10. Automatic upgrade scheduler: Every week on sunday
 11. Node security channel type: Node image
 12. Security channel scheduler: Every week on sunday
 13. Authentication and Authorization: Local accounts with k8s RBAC

## Node pools tab
 1. Enable node auto-provisioning : check
 2. Change the name of agent pool to new, dont create a new node pool and go inside that
 3. mode: system
 4. OS SKU: Ubuntu Linux
 5. Zones: 1,2,3
 6. Node count: 2
 7. Size: D2pds_v5

## Networking tab
 1. Enable private cluster : dont check
 2. Set authorized IP ranges : dont check
 3. Network configuration: Azure CNI Overlay
 4. Bring your own Azure virtual network : don't check for now
 5. DNS name prefix : keep default
 6. Enable Cilium dataplane and network policy engine : don't check for now
 7. Network policy engine : none

## Integrations tab
 1. Container registry : none
 2. Service mesh - Istio : dont enable
 3. Azure Policy : dont enable

## Monitoring dashboard
 1. Enable Container Logs : 
 2. Enable Prometheus metrics : 
 3. Enable Grafana : 
 4. Enable Container Network Observability with ACNS :
 5. Enable recommended alert rules : 

## dont change anything in advanced tab and security tab

## review and create