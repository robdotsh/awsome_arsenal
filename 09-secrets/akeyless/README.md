# 09-secrets/akeyless/README.md

# 🔐 Akeyless Secrets Management Integration

This section of the repository integrates **Akeyless** for secure secrets management. Akeyless Vault helps you store, manage, and access sensitive information (like API keys, database credentials, etc.) securely in a centralized location.

### Why Akeyless?
- **Centralized Secret Management**: Store all secrets (API keys, credentials, etc.) securely in one place.
- **Dynamic Secrets**: Generate temporary credentials with a TTL (Time To Live), improving security.
- **Access Control**: Define policies on who and what can access each secret.
- **Audit**: Akeyless provides audit logs to track who accessed which secrets and when.

### How Akeyless is Integrated

This repo uses Akeyless to manage secrets for:
- **Terraform**: Access secrets for infrastructure provisioning (e.g., AWS credentials).
- **Kubernetes**: Inject secrets into containers at runtime.
- **CI/CD Pipelines**: Fetch secrets dynamically during the build and deployment process.

---

## 🛠️ Setting Up Akeyless

### 1. **Create an Akeyless Account**
   - Visit [Akeyless.io](https://www.akeyless.io/) to sign up and create account.
   - Once signed up, you'll have access to the Akeyless Vault, where you can store and manage secrets.

### 2. **Create Secrets in Akeyless Vault**
   - After logging in, create the secrets needed for project.
   - Example:
     - `secrets/aws/access_key`
     - `secrets/aws/secret_key`
   
   These secrets can be created through the Akeyless UI or via the CLI.

   **Note:** Akeyless allows for both **static** and **dynamic secrets**. For example, you can generate temporary AWS credentials or other credentials that expire after a certain time.

### 3. **Obtain Akeyless API Key**
   - Go to Akeyless dashboard and generate an API key that will allow programmatic access to the Vault.
   - Store this API key securely. You will use it in the repo’s Terraform files and CI/CD pipelines.

---

## 🔑 Using Akeyless in Terraform

In this repo, Terraform uses the **Akeyless Terraform Provider** to access secrets from Akeyless.

### Example Terraform Configuration:

```hcl
provider "akeyless" {
  api_url = "https://your-akeyless-instance.com/v1"
  api_key = var.akeyless_api_key 
}

resource "akeyless_secret" "aws_access_key" {
  name = "secrets/aws/access_key"
}

resource "akeyless_secret" "aws_secret_key" {
  name = "secrets/aws/secret_key"
}

output "aws_access_key" {
  value = akeyless_secret.aws_access_key.value
}

output "aws_secret_key" {
  value = akeyless_secret.aws_secret_key.value
}
