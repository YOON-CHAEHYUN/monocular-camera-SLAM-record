#!/usr/bin/env bash
set -eu

REPO_DIR="/home/jetson/colcon_ws/research-wiki"

install -m 0755 \
  "$REPO_DIR/scripts/hooks/pre-commit" \
  "$REPO_DIR/.git/hooks/pre-commit"

printf "Installed research-wiki git hooks.\n"
