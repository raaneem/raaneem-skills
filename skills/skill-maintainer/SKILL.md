---
name: skill-maintainer
description: Use when creating, updating, reviewing, or organizing personal Codex skills in the raaneem-skills repository.
---

# Skill Maintainer

Use this skill for work on the user's personal skills repository.

## Workflow

1. Confirm the target skill folder under `skills/`.
2. Keep `SKILL.md` concise and focused on one reusable workflow.
3. Put detailed supporting material in `references/` and mention when to read it from `SKILL.md`.
4. Put deterministic or repeated commands in `scripts/`.
5. Do not add extra documentation inside an individual skill folder unless it is a reference the agent should read.
6. Run `./scripts/install-local.sh` after adding a new skill folder.

## Skill Shape

Every skill needs this frontmatter:

```md
---
name: skill-name
description: Use when the user asks for the specific workflow this skill supports.
---
```

Write descriptions so they are useful even when shortened in a skill list. Start with the trigger case, then mention important boundaries.

## Review Checklist

- The skill has exactly one primary job.
- The description says when to use the skill.
- The body gives steps, not generic advice.
- Large examples or domain docs live in `references/`.
- Scripts are executable if they are meant to be run directly.
