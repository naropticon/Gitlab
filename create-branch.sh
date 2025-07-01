#!/bin/bash

branch_prefix="minden branch neve előtt szerepelni fog ami itt van"
branches=("branch1" "branch2" "branch3")

for branch_name in "${branches[@]}"; do
  full_branch_name="${branch_prefix}${branch_name}"

  # csekkolja létezik-e már olyan nevű branch
  if git rev-parse --verify "$full_branch_name" >/dev/null 2>&1; then
  echo "A(z) $full_branch_name már létezik."

  else
    git checkout -b "$full_branch_name"
    git log
    git push -u origin "$full_branch_name"
    echo "A(z) $full_branch_name létrehozva a távoli repoban.
  fi
done
