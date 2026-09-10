# AWS CodePipeline and CodeDeploy demo

A minimal static-site delivery pipeline demonstrating how a GitHub change reaches Apache on an EC2 instance.

## Delivery flow

1. AWS CodePipeline detects a commit in this repository.
2. CodeBuild validates `index.html` and creates the deployment artifact.
3. CodeDeploy copies only `index.html` to `/var/www/html/`.
4. The `AfterInstall` hook restarts Apache.
5. The `ValidateService` hook requests the local site and fails the deployment if Apache does not return a successful response.

## AWS prerequisites

- A CodePipeline source connection to this repository
- A CodeBuild project using `buildspec.yml`
- A CodeDeploy application and deployment group
- An Amazon Linux EC2 instance with Apache, curl, and the CodeDeploy agent installed
- An EC2 instance profile and CodePipeline/CodeBuild/CodeDeploy service roles with least-privilege access
- An EC2 tag or Auto Scaling group matching the deployment group

## Instance preparation

```bash
sudo dnf install -y httpd curl
sudo systemctl enable --now httpd
```

Install and register the CodeDeploy agent using the current AWS documentation for the instance region.

## Files

- `index.html` — deployed website
- `buildspec.yml` — validation and artifact manifest
- `appspec.yml` — CodeDeploy file mapping and lifecycle hooks
- `restart_httpd.sh` — restarts Apache and confirms it is active
- `validate_service.sh` — performs the post-deployment HTTP health check
