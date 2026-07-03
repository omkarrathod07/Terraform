# Terraform Configuration Repository

This repository contains all Terraform configuration files used for building, managing, and versioning infrastructure safely and efficiently.

## About Terraform

Terraform is an infrastructure as code (IaC) tool that enables automated provisioning and management of cloud resources. It supports various service providers, including popular cloud platforms and custom in-house solutions. 

Terraform configuration files define the necessary components to deploy a single application or an entire datacenter. Using these configurations, Terraform:
- Generates an execution plan to achieve the desired state.
- Applies changes to build the described infrastructure.
- Detects modifications and creates incremental execution plans for updates.

## Terraform Commands

Below are the essential Terraform commands used for initialization, validation, and deployment:

1. `terraform init` – Initializes the working directory.
2. `terraform validate` – Validates the configuration files.
3. `terraform plan` – Generates an execution plan.
4. `terraform apply` – Applies the configuration and provisions resources.
5. `terraform destroy` – Deletes the managed infrastructure.

## Terraform Module

A Terraform module is a collection of resources that are grouped together to be managed as a single unit. Modules help in organizing and reusing infrastructure configurations, making it easier to standardize and scale infrastructure provisioning.
### Workflow:
1. Module must be created using 'module' keyword.
2. Can be reusable
3. Can change variable values (change values be providing variable name.) for reusability

## File Structure
```markdown
- **AWS** → Infrastructure components for Amazon Web Services  
- **Azure** → Microsoft Azure resources and services  
- **Terraform_Module** → Reusable IaC modules for AWS & Azure  
- **Tools** → CI/CD, automation, and development utilities  

---