# Enterprise CI/CD for MuleSoft CloudHub 2.0 using GitHub Actions & Anypoint CLI

This repository is a template project to showcase enterprise-grade CI/CD workflows using GitHub Actions and Anypoint CLI for MuleSoft CloudHub 2.0 deployments.

## GitHub Actions Setup

This template relies on GitHub Actions secrets and repository variables.

### GitHub Actions environment secrets

For each environment, SANDBOX and PRODUCTION, configure corresponding secrets in GitHub Actions:

- `CONNECTED_APP_ID`
- `CONNECTED_APP_SECRET`
- `ENV_ID`
- `ENV_SECRET`
- `SECURE_KEY`

The `ENV_ID` and `ENV_SECRET` are for API Manager Autodiscovery. The `SECURE_KEY` is just a dummy value in this Demo project, it is here to show how a Mulesoft Encryption Key will be passed.

### GitHub Actions repository variables

Set the following repository variables in GitHub Actions:

- `CH_JAVA_VERSION`: 17
- `CH_MULE_VERSION`: 4.12.0
- `CH_RELEASE_CHANNEL`: EDGE
- `CH_REPLICAS`: 1
- `CH_TARGET`: cloudhub-us-east-2
- `CH_VCORES`: 0.1

## Workflows

This repository includes three GitHub Actions workflow files in `.github/workflows`:

- `sandbox.yml`
- `release.yml`
- `security-scan.yml`

### sandbox.yml

The sandbox workflow deploys the application to the SANDBOX environment only. It uses sandbox-specific environment credentials and keeps production isolated.

### release.yml

> **Note:** This project assumes the main branch is named `main`, not `master`. Ensure you change this workflow .yml file accordingly.

The release workflow deploys the application to the PRODUCTION environment only. It uses production-specific credentials and is separated from sandbox deployment to ensure controlled release handling.

### security-scan.yml

The security scan workflow scans the repository to detect whether any secrets were accidentally pushed. This is more for personal use than for anyone else copying the project.

## Environment & Branch Rules

Branch protection is enabled on the `main` branch. A pull request with at least one reviewer is required before code can be merged.

To prevent unauthorized production deployments, a deployment protection rule is configured to require reviewer approval before the release workflow can be started.

## MuleSoft Platform Configuration

On the MuleSoft platform, create two environments named exactly:

- `SANDBOX`
- `PRODUCTION`

Create two connected apps (Client Credentials type), one for SANDBOX and one for PRODUCTION. Each connected app must have **full permissions** for:

- API Manager
- Exchange
- Runtime Manager

Permissions should be scoped to the corresponding environment.

Ofcourse, once you understand this template, it becomes quite easy to tailor it according to multiple environments and different branching strategies. You just need to be creative and let AI take care of the mundane stuff 😉