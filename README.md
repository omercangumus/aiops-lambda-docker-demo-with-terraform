<p align="center">
  <img src="https://img.shields.io/badge/AWS-Lambda-FF9900?style=for-the-badge&logo=awslambda&logoColor=white" alt="AWS Lambda"/>
  <img src="https://img.shields.io/badge/Amazon-ECR-FF9900?style=for-the-badge&logo=amazon&logoColor=white" alt="Amazon ECR"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform"/>
  <img src="https://img.shields.io/badge/Python-3.9-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>
</p>

<h1 align="center">🚀 AIOps Lambda Docker Demo with Terraform</h1>

<p align="center">
  <strong>Container Image → ECR → Lambda Deployment with Infrastructure as Code</strong><br/>
  <em>A hands-on journey into Cloud, Serverless & AIOps</em>
</p>

<p align="center">
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-terraform-deployment">Terraform</a> •
  <a href="#-roadmap">Roadmap</a>
</p>

---

## 📖 Overview

This repository demonstrates a production-ready example of running an **AWS Lambda function** from a **Docker container image** stored in **Amazon ECR**, fully provisioned with **Terraform**.

### What You'll Learn

| Concept | Description |
|---------|-------------|
| 🐳 **Containerization** | Package a Python Lambda function into a Docker image |
| 📦 **ECR Registry** | Push and manage container images in Amazon ECR |
| ⚡ **Serverless Deployment** | Deploy Lambda functions using container images |
| 🏗️ **Infrastructure as Code** | Provision all resources with Terraform |
| 🔄 **CI/CD Ready** | Structure ready for GitHub Actions / GitLab CI pipelines |

---

## 🏗️ Architecture

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│                  │     │                  │     │                  │
│   Dockerfile     │────▶│   Amazon ECR     │────▶│   AWS Lambda     │
│   + app.py       │     │   Repository     │     │   Function       │
│                  │     │                  │     │                  │
└──────────────────┘     └──────────────────┘     └──────────────────┘
        BUILD                  PUSH                   DEPLOY
                    ▲                       ▲
                    └───────────────────────┘
                         Terraform IaC
```

---

## 📂 Project Structure

```
aiops-lambda-docker-demo-with-terraform/
│
├── 🐳 Dockerfile                    # Lambda container image definition
├── 🐍 app.py                        # Python Lambda handler function
├── 📄 requirements.txt              # Python dependencies
├── 📖 README.md                     # Project documentation
├── 🚫 .gitignore                    # Git ignore rules
│
└── 📁 terraform/
    ├── main.tf                      # Main Terraform configuration
    ├── variables.tf                 # Input variables
    ├── outputs.tf                   # Output values
    └── terraform.tfvars.example     # Example variables (copy to terraform.tfvars)
```

---

## 🧠 Lambda Function

The heart of this demo is a simple Python handler:

```python
def handler(event, context):
    return "Docker içindeki bu kodu LAMBDA çalıştırdı!"
```

> 💡 This function is packaged into a Docker image → pushed to ECR → deployed to AWS Lambda as a container image.

---

## ✅ Prerequisites

Before you begin, ensure you have:

- [ ] **AWS Account** with appropriate permissions
- [ ] **AWS CLI** installed and configured (`aws configure`)
- [ ] **Docker** installed and running
- [ ] **Terraform** >= 1.5.0 installed
- [ ] **IAM Permissions**:
  - ECR: `CreateRepository`, `PutImage`, `GetAuthorizationToken`
  - Lambda: `CreateFunction`, `UpdateFunctionCode`
  - IAM: `CreateRole`, `AttachRolePolicy`

---

## 🚀 Quick Start

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/omercangumus/aiops-lambda-docker-demo-with-terraform.git
cd aiops-lambda-docker-demo-with-terraform
```

### 2️⃣ Configure Terraform Variables

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your AWS account ID
```

### 3️⃣ Initialize and Create ECR Repository

```bash
terraform init
terraform apply -target=aws_ecr_repository.lambda_repo
```

### 4️⃣ Build and Push Docker Image

```bash
cd ..

# Build with correct platform for Lambda
docker buildx build --platform linux/amd64 --provenance=false -t lambda-docker-demo:latest --load .

# Login to ECR (replace <ACCOUNT_ID> with your AWS account ID)
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.eu-west-1.amazonaws.com

# Tag and push
docker tag lambda-docker-demo:latest <ACCOUNT_ID>.dkr.ecr.eu-west-1.amazonaws.com/lambda-docker-demo:latest
docker push <ACCOUNT_ID>.dkr.ecr.eu-west-1.amazonaws.com/lambda-docker-demo:latest
```

> ⚠️ **Important**: Use `--provenance=false` flag to ensure Lambda-compatible image manifest!

### 5️⃣ Deploy Lambda with Terraform

```bash
cd terraform
terraform apply
```

> ✅ Your Lambda function is now running the containerized code!

---

## 🏗️ Terraform Resources

The Terraform configuration creates:

| Resource | Description |
|----------|-------------|
| `aws_ecr_repository` | ECR repository for Docker images |
| `aws_ecr_lifecycle_policy` | Keeps only last 10 images |
| `aws_iam_role` | IAM role for Lambda execution |
| `aws_iam_role_policy_attachment` | Basic execution policy |
| `aws_lambda_function` | Lambda function using container image |

---

## 🧪 Testing

### Invoke Lambda via CLI

```bash
aws lambda invoke \
  --function-name lambda-docker-demo \
  --payload '{}' \
  --region eu-west-1 \
  response.json

cat response.json
```

### Expected Response

```json
"Docker içindeki bu kodu LAMBDA çalıştırdı!"
```

---

## 📚 Resources

| Resource | Link |
|----------|------|
| AWS Lambda Container Images | [Documentation](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html) |
| Amazon ECR User Guide | [Documentation](https://docs.aws.amazon.com/AmazonECR/latest/userguide/) |
| Terraform AWS Provider | [Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) |
| Docker Best Practices | [Documentation](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) |

---

## 👤 Author

<p align="center">
  <strong>Ömer Can Gümüş</strong><br/>
  <em>AIOps • Cloud • DevOps • Serverless</em>
</p>

<p align="center">
  <a href="https://github.com/omercangumus">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
  <a href="https://linkedin.com/in/omercangumus">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
</p>

---

<p align="center">
  <sub>Built with ❤️ for learning Cloud & AIOps</sub>
</p>
