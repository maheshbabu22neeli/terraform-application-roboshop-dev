# terraform-application-roboshop-dev


# Roboshop Dev Architecture
![roboshop-dev.drawio.svg](images/roboshop-dev.drawio.svg)


## 00-VPC

Here is the simple step-by-step flow in 1–2 lines each, explaining the dependencies of resources in your main.tf.
Please refer `https://github.com/maheshbabu22neeli/terraform-platform-aws-vpc`
1. Terraform initializes the AWS provider – Terraform downloads the AWS provider plugin and connects to AWS using the configured region. 
2. Input variables are loaded – Values like project name, environment, VPC CIDR, and subnet CIDRs are read and used to parameterize the infrastructure. 
3. VPC is created – The main network (aws_vpc) is created using the provided CIDR block; all networking resources depend on this VPC. 
4. Internet Gateway is attached to the VPC – The Internet Gateway enables internet connectivity for resources inside the VPC. 
5. Availability Zones are fetched – Terraform retrieves available AZs in the region to distribute subnets for high availability. 
6. Public subnets are created – Public subnets are created inside the VPC across multiple AZs and configured to assign public IPs to instances. 
7. Private subnets are created – Private subnets are created in the same VPC but without direct internet exposure. 
8. Elastic IP for NAT Gateway is allocated – A static public IP is reserved so the NAT Gateway can communicate with the internet. 
9. NAT Gateway is created in a public subnet – The NAT Gateway uses the Elastic IP and allows private subnet resources to access the internet. 
10. Public route table is created – This route table controls internet routing for public subnets. 
11. Route to Internet Gateway is added – A route directing all outbound traffic `(0.0.0.0/0)` from public subnets to the Internet Gateway is configured. 
12. Private route table is created – A separate route table is created to manage traffic from private subnets. 
13. Route to NAT Gateway is added – Private subnets send internet-bound traffic to the NAT Gateway for outbound connectivity. 
14. Public route table is associated with public subnets – This association enables instances in public subnets to access the internet through the Internet Gateway. 
15. Private route table is associated with private subnets – This association allows instances in private subnets to access the internet securely via the NAT Gateway.

    ┌───────────────────────────────────────────────────────────────────────────────────────────────┐  
    │                                                                                               │  
    │                                                                                               │  
    │                                       VPC (10.0.0.0/16)                                       │  
    │                                               │                                               │  
    │           ▲                   ┌───────────────┼───────────────┐                  │            │  
    │           │                   │                               │                  │            │  
    │           │              Public Subnets                  Private Subnets         ▼            │  
    │                               │                               │               Egress Flow     │  
    │      Ingress Flow             │                               │                  │            │  
    │           ▲            Internet Gateway                 NAT Gateway              │            │  
    │           │                   │                               │                  │            │  
    │           │                   └──────────── Internet ─────────┘                  ▼            │  
    │                                                                                               │  
    │                                                                                               │  
    │                                                                                               │  
    │                                                                                               │  
    │                                                                                               │  
    └───────────────────────────────────────────────────────────────────────────────────────────────┘  
                                                                                                       
