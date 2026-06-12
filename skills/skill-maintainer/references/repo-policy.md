# Raaneem Skills Repo Policy

This repository is the source of truth for the user's personal skills.

Prefer symlinking skills into `~/.agents/skills` during active development. Use package-manager installs only when testing the repository as a consumer.

When updating skills, preserve the existing folder name unless the skill name itself is intentionally changing. If a skill is renamed, update the symlink by rerunning `./scripts/install-local.sh` and remove the old symlink manually if needed.
