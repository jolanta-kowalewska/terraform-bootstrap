# Terraform Bootstrap

Creates the foundational AWS infrastructure for Terraform Remote State management.

## What it creates

| Resource | Name | Purpose |
|---|---|---|
| S3 Bucket | `phoenix-jola-terraform-state-{env}` | Stores `terraform.tfstate` |
| S3 Public Access Block | — | Ensures bucket stays private |
| DynamoDB Table | `StateLockTerraform` | State locking (prevents concurrent applies) |

## Usage

```bash
git clone https://github.com/jolanta-kowalewska/terraform-bootstrap.git
cd terraform-bootstrap

terraform init
terraform apply
```

> ⚠️ This project uses **local state** by design — it bootstraps the remote state backend for other projects.

## Author

**Jola Kowalewska** — Cloud Engineer  
AWS Certified Solutions Architect – Associate (SAA-C03)  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jolanta-kowalewska-b1281799/)