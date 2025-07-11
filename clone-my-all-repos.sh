#!/bin/bash

GITLAB_TOKEN="Authorization: Bearer {TOKEN}"
GITLAB_API_URL="https://gitlab.com/api/v4/projects?membership=true&per_page=100"
CLONE_DIR="./gitlab-repos"

mkdir -p "$CLONE_DIR"

curl -s --insecure --location --request GET "$GITLAB_TOKEN" --header "$GITLAB_API_URL" |
  jq -r '.[].ssh_url_to_repo' |
  while read -r repo_url; do
    echo "Klónozás: $repo_url"
    git clone "$repo_url" "$CLONE_DIR/$(basename -s .git "$repo_url")"
  done
