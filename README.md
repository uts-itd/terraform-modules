# Terraform Modules

Modules used in terragrunt repository

## Folder structure
Each module should follow this directory structure
```
.
├── examples                 # Examples on how to deploy the module
│   ├── core
│   │   ├── main.tf
│   │   └── README.md
│   └── minimal
│       ├── main.tf
│       └── README.md
├── README.md                # Terraform docs. Automatically generated during build
├── subnets.tf               # Terraform files. Filename should describe what it deploys 
├── tests                    # Terratest directory, terraform unit tests written in go
│   ├── vpc_core_test.go     # Test for each `deployment style`
│   └── vpc_minimal_test.go
```
