#!/usr/bin/env bash
set -u

REPO_DIR="/home/jetson/colcon_ws/research-wiki"
LOG_FILE="$REPO_DIR/.auto-sync.log"

cd "$REPO_DIR" || exit 1

timestamp() {
  date "+%Y-%m-%d %H:%M:%S %z"
}

log() {
  printf "[%s] %s\n" "$(timestamp)" "$*" >> "$LOG_FILE"
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  log "not a git repository"
  exit 1
fi

if [ -z "$(git status --porcelain)" ]; then
  log "no changes"
  exit 0
fi

git add AGENTS.md research .gitignore scripts/auto_sync.sh >> "$LOG_FILE" 2>&1

if git diff --cached --quiet; then
  log "no staged changes after add"
  exit 0
fi

commit_msg="Auto-update research vault $(date +%Y-%m-%d_%H-%M-%S)"

if git commit -m "$commit_msg" >> "$LOG_FILE" 2>&1; then
  log "committed: $commit_msg"
else
  log "commit failed"
  exit 1
fi

if git remote get-url origin >/dev/null 2>&1; then
  current_branch="$(git branch --show-current)"
  if git rev-parse --abbrev-ref --symbolic-full-name "@{u}" >/dev/null 2>&1; then
    push_command=(git push)
  else
    push_command=(git push -u origin "$current_branch")
  fi

  if "${push_command[@]}" >> "$LOG_FILE" 2>&1; then
    log "push succeeded"
  else
    log "push failed; local commit preserved"
  fi
else
  log "no origin remote; local commit preserved"
fi
