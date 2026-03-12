#!/usr/bin/env bash
# Documentation Consistency Check Script
# This script verifies that the documentation is consistent with the repository structure.
#
# IMPORTANT: Project maintainers should customize this script to include
# project-specific checks (e.g., verifying that all package.json files have a license field).

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

errors=0

info() {
  printf "[INFO] %s\n" "$*"
}

error() {
  printf "[ERROR] %s\n" "$*" >&2
  errors=$((errors + 1))
}

check_readme_exists() {
  info "Checking if README.md exists..."
  if [[ ! -f "README.md" ]]; then
    error "README.md is missing"
    return 1
  fi
  info "  [OK] README.md"
  return 0
}

check_readme_links() {
  info "Checking README.md table for existing files/directories..."
  # Only extract paths from the first column of the "各ドキュメントの役割" table
  # We look for lines starting with | followed by backticked text in the first column
  while read -r path; do
    if [[ -z "${path}" ]]; then continue; fi
    # Skip paths that look like templates or examples (e.g. feature/<topic-name>)
    if [[ "${path}" == *"<"* ]]; then continue; fi
    # Handle optional/suggested paths that might not exist yet but are documented as "to be created"
    if [[ "${path}" == ".agents/skills" ]]; then 
      info "  [SKIP] .agents/skills is a suggested operational directory"
      continue
    fi
    
    if [[ ! -e "${path}" ]]; then
      # Special case for docs/ai-workflow/ which is documented as the target for import.sh
      if [[ "${path}" == "docs/ai-workflow"* ]]; then
        # In this template, it resides in docs/ but import.sh copies it to docs/ai-workflow/
        # So we should check if the base path (e.g. docs/WORKFLOW.md) exists.
        real_path=$(echo "${path}" | sed 's|docs/ai-workflow/|docs/|')
        if [[ ! -e "${real_path}" ]]; then
          error "Path mentioned in README.md does not exist: ${path} (real path: ${real_path})"
        else
          info "  [OK] ${path} (exists as ${real_path})"
        fi
      else
        error "Path mentioned in README.md does not exist: ${path}"
      fi
    else
      info "  [OK] ${path}"
    fi
  done < <(sed -n '/## 各ドキュメントの役割/,/##/p' README.md | grep '^| `[^`]*`' | cut -d '|' -f 2 | grep -o '`[^`]*`' | tr -d '`')
}

check_skills_structure() {
  info "Checking skills/ directory structure..."
  # NOTE: If your project stores skills in a different location (e.g., .agents/skills),
  # update the path below.
  local skills_base="skills"
  if [[ -d "${skills_base}" ]]; then
    for skill_dir in "${skills_base}"/*/; do
      if [[ -d "${skill_dir}" ]]; then
        skill_name=$(basename "${skill_dir}")
        if [[ ! -f "${skill_dir}/SKILL.md" ]]; then
          error "Skill '${skill_name}' is missing SKILL.md"
        else
          # Check for YAML frontmatter in SKILL.md
          if ! head -n 1 "${skill_dir}/SKILL.md" | grep -q "^---$"; then
            error "Skill '${skill_name}' SKILL.md is missing YAML frontmatter (---)"
          else
            info "  [OK] skill: ${skill_name}"
          fi
        fi
      fi
    done
  else
    info "  [SKIP] ${skills_base}/ directory not found"
  fi
}

check_mandatory_files() {
  info "Checking mandatory files..."
  mandatory_files=(
    "AGENTS.md"
    ".github/pull_request_template.md"
    ".github/ISSUE_TEMPLATE/feature.yml"
    ".github/ISSUE_TEMPLATE/bug.yml"
    ".github/ISSUE_TEMPLATE/task.yml"
    "docs/WORKFLOW.md"
  )
  for file in "${mandatory_files[@]}"; do
    if [[ ! -f "${file}" ]]; then
      error "Mandatory file is missing: ${file}"
    else
      info "  [OK] ${file}"
    fi
  done
}

check_mandatory_files
if check_readme_exists; then
  check_readme_links
fi
check_skills_structure

if [[ "${errors}" -gt 0 ]]; then
  info "Documentation consistency check failed with ${errors} error(s)."
  exit 1
fi

info "Documentation consistency check passed."
exit 0
