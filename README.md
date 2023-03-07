# EKS Terraform Repository with Vault and Prometheus Helm Charts 
This repository includes terraform configurations to provision an EKS cluster from scratch. It installs Vault, AWS LB Controller and Prometheus Helm charts using Helm Terraform provider. I used EKS addons to simplify the EKS initial setup. Additionaly AWS IAM Role for Service Accounts approach is used to enforce least privilege security principle on the level of Kubernetes pods. 

### How to Start?  
Use following commands to provision EKS cluster and all related components. Make sure you have required access to AWS to create resources. 
`cd demo`
`terraform init`
`terraform plan`
`terraform apply`

### Folder Structure  
Repository has demo and modules folders to organize the terraform configs. I grouped some of the reusable resources and put them under modules. Demo is the place where I call internal and external Terraform modules. 
├── README.md
├── demo
│   ├── aws-lb-controller.tf
│   ├── config.tf
│   ├── data.tf
│   ├── eks.tf
│   ├── helm-values
│   │   └── kube-prometheus-stack.yaml
│   ├── kube-prometheus-stack.tf
│   ├── locals.tf
│   ├── vault.tf
│   ├── versions.tf
│   └── vpc.tf
└── modules
    ├── aws-lb-controller
    │   ├── iam-policy.json
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── eks
        ├── irsa.tf
        ├── main.tf
        ├── outputs.tf
        └── variables.tf

5 directories, 19 files


### Demo Requirements 
- [x] EKS Setup
- [x] Install Ingress Controller using Terraform Helm Provider
- [x] Install Vault using Terraform Helm Provider
- [x] Install Prometheus using Terraform Helm Provider
- [ ] Alertmanager - Pod Memory Alert 
- [ ] Prometheus and AlertManager Basic Authentication using Vault

