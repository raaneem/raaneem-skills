#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/skills"

destinations=(
  "Codex:${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"
  "Claude Code:${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
  "OpenCode:${OPENCODE_SKILLS_DIR:-$HOME/.config/opencode/skills}"
)

if [[ ! -d "$source_dir" ]]; then
  echo "No skills directory found: $source_dir" >&2
  exit 1
fi

installed=0
skipped=0

link_skill() {
  local tool_name="$1"
  local dest_dir="$2"
  local skill_dir="$3"
  local skill_name="$4"
  local link_path="$dest_dir/$skill_name"

  mkdir -p "$dest_dir"

  if [[ -L "$link_path" ]]; then
    local current_target
    current_target="$(readlink "$link_path")"
    if [[ "$current_target" == "$skill_dir" ]]; then
      echo "[$tool_name] Already linked: $skill_name"
    else
      echo "[$tool_name] Relinking: $skill_name"
      rm "$link_path"
      ln -s "$skill_dir" "$link_path"
    fi
  elif [[ -e "$link_path" ]]; then
    echo "[$tool_name] Skipping $skill_name: $link_path already exists and is not a symlink" >&2
    skipped=$((skipped + 1))
    return
  else
    echo "[$tool_name] Linking: $skill_name"
    ln -s "$skill_dir" "$link_path"
  fi

  installed=$((installed + 1))
}

for skill_dir in "$source_dir"/*; do
  [[ -d "$skill_dir" ]] || continue

  skill_name="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"

  if [[ ! -f "$skill_file" ]]; then
    echo "Skipping $skill_name: missing SKILL.md"
    skipped=$((skipped + 1))
    continue
  fi

  for destination in "${destinations[@]}"; do
    tool_name="${destination%%:*}"
    dest_dir="${destination#*:}"
    link_skill "$tool_name" "$dest_dir" "$skill_dir" "$skill_name"
  done
done

echo
echo "Installed or verified $installed skill link(s)."
if [[ "$skipped" -gt 0 ]]; then
  echo "Skipped $skipped item(s)."
fi
echo "Restart Codex, Claude Code, or OpenCode if newly added skills do not appear."
