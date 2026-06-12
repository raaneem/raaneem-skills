# Raaneem Skills

Personal Codex skills maintained as a GitHub repository.

## Layout

```text
skills/
  skill-name/
    SKILL.md
    references/
    scripts/
scripts/
  install-local.sh
```

Each skill is a folder with a required `SKILL.md`. Optional `references/`, `scripts/`, and `assets/` folders can be added when the skill needs supporting material.

## Local install

Symlink every skill in this repo into your user-level Codex skills folder:

```bash
./scripts/install-local.sh
```

Codex reads user skills from:

```text
~/.agents/skills
```

After adding a new skill, run the installer again. If Codex does not show the new or updated skill, restart Codex.

## Add a new skill

```bash
mkdir -p skills/my-skill
$EDITOR skills/my-skill/SKILL.md
./scripts/install-local.sh
```

Minimal `SKILL.md`:

```md
---
name: my-skill
description: Use when the user asks for the specific workflow this skill supports.
---

Follow this workflow...
```

## Git workflow

```bash
git add .
git commit -m "Add my-skill"
git push
```

On another machine:

```bash
git clone git@github.com:YOUR_USER/raaneem-skills.git ~/dev/me/raaneem-skills
cd ~/dev/me/raaneem-skills
./scripts/install-local.sh
```

## Install ecosystem skills

Use the Skills CLI for third-party skills:

```bash
pnpm dlx skills find react
pnpm dlx skills add owner/repo@skill-name -g -y
pnpm dlx skills check
pnpm dlx skills update
```
# raaneem-skills
