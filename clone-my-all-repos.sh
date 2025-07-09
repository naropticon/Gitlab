#!/bin/bash

GITLAB_TOKEN="SAJÁT_TOKENED_IDE"
GITLAB_API_URL="https://gitlab.com/api/v4/projects?membership=true&per_page=100"
CLONE_DIR="./gitlab-repos"

mkdir -p "$CLONE_DIR"

curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -s "$GITLAB_API_URL" |
  jq -r '.[].ssh_url_to_repo' |
  while read -r repo_url; do
    echo "Klónozás: $repo_url"
    git clone "$repo_url" "$CLONE_DIR/$(basename -s .git "$repo_url")"
  done
