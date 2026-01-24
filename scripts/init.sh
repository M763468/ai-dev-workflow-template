#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

info() {
  printf "[INFO] %s\n" "$*"
}

warn() {
  printf "[WARN] %s\n" "$*"
}

run_or_warn() {
  if ! "$@"; then
    warn "Command failed: $*"
  fi
}

info "Repository root: ${ROOT_DIR}"

if command -v gh >/dev/null 2>&1; then
  info "gh CLI detected"
  if gh auth status >/dev/null 2>&1; then
    info "gh auth status: OK"
    run_or_warn gh repo view >/dev/null
  else
    warn "gh is installed but not authenticated. Run: gh auth login"
  fi
else
  warn "gh CLI is not installed. See: https://cli.github.com/"
fi

info "Checking required template files"
run_or_warn "${ROOT_DIR}/scripts/check-templates.sh"
info "Tip: run ./scripts/check-templates.sh --help for details"

info "Init complete"
