#!/bin/bash

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH_NAME" == "main" ]; then
  cp public/logo-main.svg public/logo.svg
elif [ "$BRANCH_NAME" == "dev" ]; then
  cp public/logo-dev.svg public/logo.svg
else
  echo "Unknown branch, using default logo.svg"
fi