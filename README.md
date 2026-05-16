# CI/CD Pipeline — GitHub Actions + Docker + Nginx

![CI/CD](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/deploy.yml/badge.svg)

Production-grade CI/CD pipeline for portfolio and interviews.
Lints, tests, builds a Docker image, and deploys to a VPS on every push to `main`.

## Stack
| Layer     | Technology                     |
|-----------|-------------------------------|
| CI/CD     | GitHub Actions                |
| Container | Docker (multi-stage build)    |
| Registry  | Docker Hub                    |
| Proxy     | Nginx + SSL (Let's Encrypt)   |
| App       | Node.js 20 / Express          |
| Tests     | Jest + Supertest              |

## Quick Start

```bash
npm install && npm test          # run locally
docker build -t my-app:local .   # build image
docker run -p 3000:3000 my-app:local
```

## Setup Checklist

- [ ] Push repo to GitHub
- [ ] Run `scripts/vps-setup.sh` on your VPS
- [ ] Run `scripts/gen-ssh-key.sh` on your local machine
- [ ] Add GitHub Secrets: DOCKERHUB_USERNAME, DOCKERHUB_TOKEN, VPS_HOST, VPS_USER, VPS_SSH_KEY
- [ ] Update `nginx/default.conf` with your domain
- [ ] Push to main — pipeline fires automatically

## GitHub Secrets Reference

| Secret               | Where to get it                        |
|----------------------|----------------------------------------|
| DOCKERHUB_USERNAME   | Your Docker Hub username               |
| DOCKERHUB_TOKEN      | Docker Hub → Account Settings → Token |
| VPS_HOST             | Your server IP                         |
| VPS_USER             | root or ubuntu                         |
| VPS_SSH_KEY          | Output of gen-ssh-key.sh               |
| SLACK_WEBHOOK_URL    | Slack App → Incoming Webhooks (optional)|

## Interview Answer

> "I built a three-stage GitHub Actions pipeline. On push to main it runs ESLint and Jest.
> If tests pass, a multi-stage Docker build runs — the builder stage tests inside the container
> so the production image is guaranteed clean — then pushes to Docker Hub tagged by commit SHA.
> The deploy job SSHes into my VPS, pulls the image, does a zero-downtime container swap, and
> prunes old images. Nginx handles SSL termination via Let's Encrypt. Total push-to-live: ~90s."

## Project Structure

```
.
├── src/index.js                    Express app
├── test/app.test.js                Jest tests
├── Dockerfile                      Multi-stage build
├── nginx/default.conf              Reverse proxy config
├── scripts/
│   ├── vps-setup.sh                One-time VPS provisioning
│   └── gen-ssh-key.sh              Generate GitHub Actions deploy key
└── .github/workflows/deploy.yml   Full CI/CD pipeline
```
# cicd-pipeline-project
# cicd-pipeline-project
