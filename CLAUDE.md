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
  plugin.json             # Plugin manifest
README.md
CLAUDE.md                 # This file
LICENSE
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

## Goals

Make CLI development more user-centered by providing expert UX evaluation automatically within Claude Code sessions.
