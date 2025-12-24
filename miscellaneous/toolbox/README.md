## How to Reauthenticate Using GitHub Personal Access Token (PAT)

If your GitHub Personal Access Token (PAT) has expired, follow these steps to update it and continue working with your repositories.

Common errors such as 

remote: Invalid username or token. Password authentication is not supported for Git operations.
fatal: Authentication failed for 'https://github.com/robdotsh/awsome_arsenal.git/'

### Generate a New Token

1. Go to [GitHub Personal Access Tokens](https://github.com/settings/tokens).
2. Click **Generate new token** → Clasic or **Fine-grained token** is recommended.
3. Select scopes  required per project.
4. Copy the new token — you **won’t be able to see it again**.


### Update Git Remote URL (Manual)
Replace the token in your repository's remote URL:

```bash
git remote set-url origin https://<NEW_TOKEN>@github.com/<USERNAME>/<REPOSITORY>.git
```

### Update Git Remote URL (Using Helper Script)
The helper script, automate token replacement:

```bash
./misc-git-tools.sh
```

### Common Errors
* Error: remote: Invalid username or token. Password authentication is not supported for Git operations.
  - Cause: Using old PAT or your Git credentials cached as a password.
   * Solution: Generate a new token and update your remote URL or use gh auth login.

* Error: fatal: Authentication failed for 'https://github.com/...
  - Cause: Invalid token, expired PAT, or incorrect remote URL.
   * Solution: Verify your token, ensure it has the required scopes, and update your repository remote.
