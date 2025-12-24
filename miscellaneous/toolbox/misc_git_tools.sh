#!/usr/bin/env bash
set -euo pipefail

echo "Git Misc Tools"
echo "1) Replace GitHub PAT in origin URL"
echo "2) Show current origin URL"
echo "3) Remove token from origin URL"
echo "4) Test GitHub authentication"
echo "5) Exit"
echo

read -rp "Choose an option [1-5]: " choice

case "$choice" in
  1)
    read -rp "GitHub username: " GITHUB_USERNAME
    read -s -p "New GitHub token: " GITHUB_TOKEN
    echo

    REPO_NAME="$(basename -s .git "$(git config --get remote.origin.url)")"

    git remote set-url origin \
      "https://${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

    echo "Origin URL updated with new token"
    ;;
  2)
    echo "Current origin:"
    git remote get-url origin
    ;;
  3)
    read -rp "GitHub username: " GITHUB_USERNAME
    REPO_NAME="$(basename -s .git "$(git config --get remote.origin.url)")"

    git remote set-url origin \
      "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

    echo "Token removed from origin URL"
    ;;
  4)
    echo "Testing GitHub auth..."
    git ls-remote origin &>/dev/null \
      && echo "Authentication OK" \
      || echo "❌ Authentication failed"
    ;;
  5)
    echo "Bye"
    exit 0
    ;;
  *)
    echo "Invalid option"
    exit 1
    ;;
esac
