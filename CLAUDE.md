# CLAUDE.md

Developer context for the CLI UX Tester Claude Code plugin.

## What this is

A Claude Code plugin that evaluates CLI usability across 8 criteria. Distributed via the Claude Code plugin system.
The agent definition lives in `agents/cli-ux-tester.md`.

## Repository structure

```text
agents/
  cli-ux-tester.md        # Agent definition — performs the evaluation
skills/
  cli-ux-tester/
    SKILL.md              # Skill launcher — detects context and invokes the agent
    testing-checklist.md  # Comprehensive testing checklist (reference for agent)
    test-scenarios.md     # Common CLI testing scenarios (reference for agent)
    scripts/
      example-test.sh     # Template for automated testing
.claude-plugin/
  plugin.json             # Plugin manifest (current version: 3.0.0)
migrate                   # Migration script — removes legacy ~/.claude/skills/cli-ux-tester/
README.md
CLAUDE.md                 # This file
LICENSE
.markdownlint.json        # Markdown lint config (120-char line length for prose)
```

## Installation (for development and testing)

```text
/plugin marketplace add ali5ter/claude-plugins
/plugin install cli-ux-tester@ali5ter
```

Or install directly from a local checkout:

```text
/plugin install /path/to/claude-cli-ux-skill
```

## Architecture

The plugin provides two components:

- **Skill** (`cli-ux-tester`) — lightweight launcher that detects the target CLI, asks clarifying questions
  if needed, then invokes the agent
- **Agent** (`cli-ux-tester:cli-ux-tester`) — performs the full evaluation by delegating to Explore and
  general-purpose sub-agents in parallel, then synthesizes results and writes artifacts

## Key design decisions

### Always use sub-agents (issue #2)

The agent always delegates evaluation work to sub-agents (Explore + general-purpose). The main session only
orchestrates and synthesizes. This keeps the parent session's token budget clean and prevents evaluation bias
from prior conversation context.

### Timestamped output directory (issue #1)

All artifacts go into `CLI_UX_EVALUATION_<YYYYMMDD_HHMMSS>/`. This allows multiple evaluations to coexist,
makes comparison easy, and lets users clean up with `rm -rf CLI_UX_EVALUATION_*/`.

### Language-agnostic evaluation

The agent evaluates user-facing behavior only. It doesn't comment on code quality, architecture, or
language-specific style.

## Modifying the agent

Edit `agents/cli-ux-tester.md`. The YAML frontmatter controls:

- `name`: Agent identifier
- `description`: Activation trigger — make this specific and include examples
- `model`: Which Claude model to use
- `color`: UI color in Claude Code
- `tools`: Tools the agent can use

The markdown body is the agent's system prompt.

## Migration (for users upgrading from v1.x or v2.x)

Run the included `migrate` script to remove the legacy user skill before reinstalling:

```bash
./migrate
```

The legacy skill was at `~/.claude/skills/cli-ux-tester/`. From v3.0.0, the skill is installed exclusively
as part of the plugin via the `skills/` directory.

## Goals

Make CLI development more user-centered by providing expert UX evaluation automatically within Claude Code sessions.

## Issue implementation order

Issues grouped as PRs by merge strategy. Work through groups in order.

### Group 1 — Safe to auto-merge (low risk, isolated changes)

These are small, self-contained fixes with no architectural impact.

- **#3** — Shorten skill description to ≤200 characters (`skills/cli-ux-tester/SKILL.md`)
- **#13** — Trim agent description and move embedded XML examples out of frontmatter (`agents/cli-ux-tester.md`)
- **#11** — Replace `eval` in `example-test.sh` with array-based command invocation (`skills/cli-ux-tester/scripts/example-test.sh`)
- **#9** — Add `maxTurns: 40` to agent frontmatter (`agents/cli-ux-tester.md`)

### Group 2 — Review before merge (moderate risk, inter-file changes)

These touch the skill/agent contract or evaluation framework alignment.

- **#8** — Rewrite skill's AskUserQuestion branching as a single decision tree (`skills/cli-ux-tester/SKILL.md`)
- **#5** — Parameterize sub-agent prompts with CLI target context (`agents/cli-ux-tester.md`)
- **#7** — Add references to `testing-checklist.md` and `test-scenarios.md` in agent prompt (`agents/cli-ux-tester.md`)
- **#6** — Extend agent to all 11 criteria and update `metrics.json` schema
  (coordinated change across `agents/cli-ux-tester.md` + `testing-checklist.md`)

### Group 3 — Review before merge (architectural decisions)

These require a decision or have wider design implications.

- **#4** — Investigate sub-agent nesting limitation and restructure if needed;
  may require moving synthesis logic to the skill or restructuring the agent layer entirely
- **#10** — Decide on `permissionMode` strategy (balance between automation convenience and security)
- **#12** — Decide whether cross-evaluation memory is in scope; add `memory: user` and write-guidance if yes
