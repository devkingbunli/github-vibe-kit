---
mode: 'agent'
description: 'Planejamento de projeto sem código. Usa project-planner agent e gera arquivo de plano.'
---

Read the file `.agent/workflows/plan.md` and follow ALL instructions defined there.
Also read `.agent/agents/project-planner.md` to activate the project-planner agent.

Request to plan: $ARGUMENTS

CRITICAL: NO CODE. Generate plan file only at `docs/PLAN-{task-slug}.md`.
Apply Socratic Gate: ask clarifying questions before planning.
