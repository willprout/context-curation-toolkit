#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
claude_dir="${HOME}/.claude"

mkdir -p "${claude_dir}/skills/brief"
mkdir -p "${claude_dir}/skills/fresh-eyes"
mkdir -p "${claude_dir}/skills/refresh"

cp "${repo_root}/skills/brief/SKILL.md" "${claude_dir}/skills/brief/SKILL.md"
cp "${repo_root}/skills/fresh-eyes/SKILL.md" "${claude_dir}/skills/fresh-eyes/SKILL.md"
cp "${repo_root}/skills/refresh/SKILL.md" "${claude_dir}/skills/refresh/SKILL.md"

touch "${claude_dir}/CLAUDE.md"

if ! grep -q "## Handoffs & Briefings" "${claude_dir}/CLAUDE.md"; then
  {
    printf "\n"
    cat "${repo_root}/claude/CLAUDE.md"
    printf "\n"
  } >> "${claude_dir}/CLAUDE.md"
fi

echo "Installed Fable Thin-Briefing Workflow skills into ${claude_dir}."
echo "Restart open Claude Code sessions to pick them up."
