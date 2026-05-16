#!/usr/bin/env bash
# Run on your LOCAL machine to generate a deploy key
set -e
KEY_PATH="$HOME/.ssh/github_actions_deploy"
ssh-keygen -t ed25519 -C "github-actions-deploy" -f "$KEY_PATH" -N ""
echo ""
echo "STEP 1 — Copy public key to your VPS:"
echo "  ssh-copy-id -i ${KEY_PATH}.pub root@YOUR_SERVER_IP"
echo ""
echo "STEP 2 — Add private key to GitHub Secrets as VPS_SSH_KEY:"
echo ""
cat "$KEY_PATH"
