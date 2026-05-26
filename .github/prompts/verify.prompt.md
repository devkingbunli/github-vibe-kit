---
mode: 'agent'
description: 'Checklist final antes do deploy. Roda todos os scripts de validação do AG Kit.'
---

Read the file `.agent/workflows/verify.md` and follow ALL instructions defined there.

What to verify: $ARGUMENTS

Run verification in order: Security → Lint → Schema → Tests → UX → SEO → Lighthouse/E2E.
Use scripts from `.agent/scripts/` as appropriate.
Fix Critical blockers (Security/Lint) before proceeding.
