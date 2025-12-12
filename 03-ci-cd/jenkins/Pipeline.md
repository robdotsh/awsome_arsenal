# Jenkins CI/CD Pipeline

This repository contains a simple Jenkins declarative pipeline and helper scripts that demonstrate a basic Build → Test → Deploy workflow for a production-style setup.

## Repository structure

- `Jenkinsfile` – Main Jenkins pipeline definition
- `scripts/build.sh` – Build step script
- `scripts/test.sh` – Test step script
- `scripts/deploy.sh` – Deploy step script

## What the pipeline does

- **Build**: Runs `scripts/build.sh` to compile or package the application.
- **Test**: Runs `scripts/test.sh` to execute automated tests.
- **Deploy**: Runs `scripts/deploy.sh prod` to deploy when the branch is `main` or `master`.

Replace the placeholder commands inside each script with actual build, test, and deployment commands.

## How to use with Jenkins

1. Push this repository to Git server (GitHub, GitLab, etc.).
2. In Jenkins, create a new Pipeline or Multibranch Pipeline job.
3. Configure the job to use Git repository as the source.
4. Set the pipeline “Script Path” to `Jenkinsfile` (default).
5. Run the job to execute the pipeline.

## Requirements

- Jenkins with a suitable agent that can run shell scripts (`sh`).
- Required tools for build/test/deploy commands installed on the agent (i.e., Maven, Node.js, Docker, kubectl).
- Network and credentials configured so Jenkins can access Git repository (and, if applicable, Kubernetes cluster or deployment target).
