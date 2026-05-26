# 🚀 GitHub Vibe Kit

> **AG Kit 2026.5.13 fully adapted for GitHub Copilot + VS Code**

A complete integration layer that brings the power of **20 specialist AI agents**, **45 skills**, and **14 workflow commands** to GitHub Copilot in VS Code — no Gemini CLI required.

---

## What is this?

**GitHub Vibe Kit** is the bridge between [AG Kit](https://www.npmjs.com/package/@vudovn/ag-kit) and **GitHub Copilot**. It provides:

- ✅ **Auto-routing** — Copilot automatically selects the right specialist agent for every request
- ✅ **14 workflow slash commands** — `/brainstorm`, `/debug`, `/plan`, `/create`, and more
- ✅ **20 agent prompts** — activate any specialist directly (`#agent-frontend`, `#agent-security`, etc.)
- ✅ **Always-on rules** — clean code, Socratic gate, language detection, and more

---

## Quick Start

### Prerequisites
- [VS Code](https://code.visualstudio.com/) with [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) extension
- [Node.js](https://nodejs.org/) 18+

### Installation

**1. Clone this repository into your project root (or copy the files):**

```bash
git clone https://github.com/devkingbunli/github-vibe-kit.git
```

**2. Copy `.github/` to your project root:**

```bash
# From inside github-vibe-kit/
cp -r .github/ /your/project/root/
```

**3. Install AG Kit (the engine that powers the agents and skills):**

```bash
cd /your/project/root
npx @vudovn/ag-kit init
```

**4. Customize `.github/copilot-instructions.md`** — update the `YOUR PROJECT` section at the bottom with your stack, quirks, and environment details.

**5. Reload VS Code** — Copilot will pick up the new instructions automatically.

---

## Usage

### Auto-routing (no setup needed)
Just ask Copilot normally. The correct agent is selected automatically:

```
"fix the login bug"        → 🤖 @debugger
"create a new dashboard"   → 🤖 @frontend-specialist
"optimize this SQL query"  → 🤖 @database-architect
"add Docker to this app"   → 🤖 @devops-engineer
```

### Workflow Commands
In the Copilot chat, click **📎 → Prompt...** and select a workflow:

| Prompt | What it does |
|--------|-------------|
| `#brainstorm` | Explore 3+ options with pros/cons before implementing |
| `#debug` | Systematic root cause analysis |
| `#plan` | Generate a plan file — no code yet |
| `#create` | Build a new application end-to-end |
| `#enhance` | Add features to existing app |
| `#test` | Test strategy + implementation |
| `#deploy` | Deployment procedures |
| `#verify` | Final checklist before deploy |
| `#orchestrate` | Coordinate 3+ agents for complex tasks |
| `#status` | Current project status overview |
| `#ui-ux-pro-max` | Advanced UI/UX design mode |
| `#remember` | Save context for future sessions |
| `#coordinate` | Explicit agent coordination |
| `#preview` | Start servers and preview the app |

### Agent Prompts
Activate a specific specialist directly via **📎 → Prompt...**:

| Prompt | Agent | Domain |
|--------|-------|--------|
| `#agent-frontend` | frontend-specialist | React, Next.js, Tailwind, UI/UX |
| `#agent-backend` | backend-specialist | API, Node, Python, FastAPI |
| `#agent-database` | database-architect | SQL, schema, migrations |
| `#agent-debugger` | debugger | Root cause, systematic debugging |
| `#agent-security` | security-auditor | OWASP, vulnerabilities |
| `#agent-pentest` | penetration-tester | Red team, offensive security |
| `#agent-devops` | devops-engineer | Docker, CI/CD, deploy |
| `#agent-test` | test-engineer | Unit, integration, E2E |
| `#agent-performance` | performance-optimizer | Web Vitals, profiling |
| `#agent-orchestrator` | orchestrator | Multi-agent coordination |
| `#agent-planner` | project-planner | Architecture, discovery |
| `#agent-product` | product-manager/owner | Requirements, backlog, MVP |
| `#agent-mobile` | mobile-developer | React Native, Expo |
| `#agent-archaeologist` | code-archaeologist | Legacy code, refactoring |
| `#agent-seo` | seo-specialist | Rankings, accessibility |
| `#agent-docs` | documentation-writer | READMEs, manuals |
| `#agent-qa` | qa-automation-engineer | E2E pipelines, CI |
| `#agent-explorer` | explorer-agent | Codebase analysis |
| `#agent-game` | game-developer | Game logic, mechanics |

---

## Repository Structure

```
github-vibe-kit/
├── README.md
├── setup.ps1                        ← Windows setup script
├── setup.sh                         ← Linux/macOS setup script
└── .github/
    ├── copilot-instructions.md      ← Always-on Copilot rules (customize this!)
    └── prompts/
        ├── brainstorm.prompt.md
        ├── debug.prompt.md
        ├── plan.prompt.md
        ├── create.prompt.md
        ├── enhance.prompt.md
        ├── test.prompt.md
        ├── deploy.prompt.md
        ├── verify.prompt.md
        ├── orchestrate.prompt.md
        ├── status.prompt.md
        ├── remember.prompt.md
        ├── coordinate.prompt.md
        ├── preview.prompt.md
        ├── ui-ux-pro-max.prompt.md
        ├── agent-frontend.prompt.md
        ├── agent-backend.prompt.md
        ├── agent-database.prompt.md
        ├── agent-debugger.prompt.md
        ├── agent-security.prompt.md
        ├── agent-pentest.prompt.md
        ├── agent-devops.prompt.md
        ├── agent-test.prompt.md
        ├── agent-performance.prompt.md
        ├── agent-orchestrator.prompt.md
        ├── agent-planner.prompt.md
        ├── agent-product.prompt.md
        ├── agent-mobile.prompt.md
        ├── agent-archaeologist.prompt.md
        ├── agent-seo.prompt.md
        ├── agent-docs.prompt.md
        ├── agent-qa.prompt.md
        ├── agent-explorer.prompt.md
        └── agent-game.prompt.md
```

---

## How It Works

```
.github/copilot-instructions.md   ← Copilot reads this automatically (always-on)
.github/prompts/*.prompt.md       ← You activate these manually via 📎 → Prompt...
          │
          ▼  (instructs Copilot to read)
.agent/agents/*.md                ← Specialist agent rules (installed by AG Kit)
.agent/skills/*/SKILL.md          ← Domain knowledge modules
.agent/scripts/*.py               ← Validation scripts
.agent/.shared/                   ← Design system data
```

The `.github/` files are the **activation layer**. The `.agent/` folder (installed via `npx @vudovn/ag-kit init`) is the **engine**.

---

## Customizing for Your Project

Edit `.github/copilot-instructions.md` and replace the `YOUR PROJECT` section:

```markdown
## THIS PROJECT
**Name:** My App
**Stack:** Next.js 15 + TypeScript · Express API · PostgreSQL
**Notes:** Any quirks, conventions, or environment details
```

---

## Credits

- **AG Kit** by [@vudovn](https://www.npmjs.com/package/@vudovn/ag-kit) — the agent/skill engine
- **GitHub Vibe Kit** — Copilot integration layer

---

## License

MIT
