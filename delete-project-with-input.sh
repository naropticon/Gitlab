#!/bin/bash

GITLAB_URL="https://gilab.url.hu/api/v4"
PRIVATE_TOKEN="Authorization: Bearer ***********"

read -p "Törlendö project neve: " PROJECT_NAME
PROJECT="${GITLAB_URL}/projects?search=${PROJECT_NAME}"
ID=$(curl -s --insecure --request GET "${PROJECT}" --header "${PRIVATE_TOKEN}" | jq -r '.[] | .id')

FULL_URLS=()
for ids in ${ID[@]}; do
  FULL_URL="${GITLAB_URL}/projects/${ids}"
  echo ${ids[@]}
  echo "Teljes elérési cím: " ${FULL_URL[@]}
  FULL_URLS+=("$FULL_URL")
done

for URL in "${FULL_URLS[@]}"; do
  echo "Törlés folyamatban: $URL"
  DELETE_RESULT=$(curl -s --insecure --request DELETE --header "${PRIVATE_TOKEN}" "${URL}")
  echo $DELETE_RESULT
donet
