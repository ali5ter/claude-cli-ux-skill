# CLAUDE.md

Developer context for the CLI UX Tester Claude Code plugin.

## What this is

A Claude Code plugin that evaluates CLI usability across 11 criteria (8 core + 3 extended).
Distributed via the Claude Code plugin system. The agent definition lives in `agents/cli-ux-tester.md`.

## Repository structure

```text
agents/
  cli-ux-tester.md        # Agent definition — synthesizes pre-collected results into artifacts
skills/
  cli-ux-tester/
    SKILL.md              # Skill — detects CLI, runs evaluation agents, invokes synthesizer
    testing-checklist.md  # Per-criterion checklists for all 11 criteria (reference for agent)
    test-scenarios.md     # 23 CLI testing scenarios (reference for agent)
    scripts/
      example-test.sh     # Template for automated testing
.claude-plugin/
  plugin.json             # Plugin manifest (current version: 3.1.0)
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

- **Skill** (`cli-ux-tester`) — detects the target CLI, asks clarifying questions if needed,
  spawns three evaluation sub-agents in parallel (Explore + Test A + Test B), then passes all
  collected results to the synthesizer agent
- **Agent** (`cli-ux-tester:cli-ux-tester`) — a pure synthesizer: receives pre-collected test
  data from the skill, applies the 11-criteria framework, and writes all four output artifacts

## Key design decisions

### Skill handles parallel evaluation (issue #4)

The platform does not support sub-agents spawning further sub-agents. The skill spawns all three
evaluation agents directly (from the current session), then passes the collected results to the
agent as context. The agent does not use the `Agent` tool.

### Timestamped output directory (issue #1)

All artifacts go into `CLI_UX_EVALUATION_<YYYYMMDD_HHMMSS>/`. This allows multiple evaluations
to coexist, makes comparison easy, and lets users clean up with `rm -rf CLI_UX_EVALUATION_*/`.

### permissionMode: acceptEdits (issue #10)

The agent auto-approves file writes (the four output artifacts) without bypassing `Bash` command
prompts. This reduces friction during evaluation without bypassing security checks.

### memory: user (issue #12)

The agent retains cross-evaluation learnings at `~/.claude/agent-memory/cli-ux-tester/`.
Useful for pattern tracking across multiple CLIs. See the Memory guidance section in the agent.

### Language-agnostic evaluation

The agent evaluates user-facing behavior only. It does not comment on code quality, architecture,
or language-specific style.

## Modifying the agent

Edit `agents/cli-ux-tester.md`. The YAML frontmatter controls:

- `name`: Agent identifier
- `description`: Activation trigger — keep it specific and under 200 characters
- `model`: Which Claude model to use
- `color`: UI color in Claude Code
- `tools`: Tools the agent can use (no `Agent` — sub-agent spawning is handled by the skill)
- `maxTurns`: Maximum turns before the agent stops (currently 40)
- `permissionMode`: Permission behavior (`acceptEdits` auto-approves file writes)
- `memory`: Memory scope (`user` stores learnings in `~/.claude/agent-memory/cli-ux-tester/`)

The markdown body is the agent's system prompt.

## Migration (for users upgrading from v1.x or v2.x)

Run the included `migrate` script to remove the legacy user skill before reinstalling:

```bash
./migrate
```

The legacy skill was at `~/.claude/skills/cli-ux-tester/`. From v3.0.0, the skill is installed
exclusively as part of the plugin via the `skills/` directory.

## Goals

Make CLI development more user-centered by providing expert UX evaluation automatically within
Claude Code sessions.
