# CLI UX Tester

A Claude Code plugin that provides expert UX evaluation for command-line interfaces, developer tools, and APIs.
Install via the Claude Code plugin system (`/plugin install cli-ux-tester@ali5ter`).

## Features

- 8-criteria UX framework with 1-5 scoring per dimension
- Active testing by executing real commands and capturing output
- Agent-based evaluation for large or complex CLIs
- Comprehensive output artifacts: evaluation report, remediation plan, metrics, and test scripts
- Language-agnostic: evaluates user-facing behavior regardless of implementation

## Repository structure

```text
agents/
  cli-ux-tester.md                 # Agent definition — performs the evaluation
skills/
  cli-ux-tester/
    SKILL.md                       # Skill launcher — detects context and invokes the agent
    testing-checklist.md           # Comprehensive testing checklist
    test-scenarios.md              # Common CLI testing scenarios
    scripts/
      example-test.sh              # Template for automated testing
.claude-plugin/
  plugin.json                      # Plugin manifest
migrate                            # Migration script for v1.x users
README.md
LICENSE
```

## Install

Inside Claude Code, run:

```text
/plugin marketplace add ali5ter/claude-plugins
/plugin install cli-ux-tester@ali5ter
```

## Migrating from v1.x or v2.x

If you previously installed via `./install.sh` or an earlier version of this plugin, run the migration script:

```bash
./migrate
```

Then reinstall via the plugin commands above.

## Usage

After installation, ask Claude to evaluate any CLI in your session:

```text
Review this CLI for UX issues
Test the error messages in this tool
Check if this API is developer-friendly
Evaluate the help system
```

The skill detects which CLI to evaluate from the current directory or your message, then launches the evaluation
agent automatically.

### What gets evaluated

The agent applies an 8-criteria framework, rating each dimension 1-5 with specific evidence:

1. **Discovery & Discoverability** — Can users find features?
2. **Command & API Naming** — Are names intuitive and consistent?
3. **Error Handling & Messages** — Are errors clear and actionable?
4. **Help System & Documentation** — Is help comprehensive and accessible?
5. **Consistency & Patterns** — Do similar operations follow patterns?
6. **Visual Design & Output** — Is output readable and well-formatted?
7. **Performance & Responsiveness** — Does the CLI feel fast?
8. **Accessibility & Inclusivity** — Can diverse developers use it?

### Output artifacts

All results go into a timestamped directory in the evaluated project:

```text
CLI_UX_EVALUATION_<YYYYMMDD_HHMMSS>/
├── EVALUATION.md          # Full report with scores and evidence
├── REMEDIATION_PLAN.md    # Prioritized action items with effort estimates
├── metrics.json           # Machine-readable scores for tracking over time
└── test.sh                # Automated regression test script
```

Clean up with: `rm -rf CLI_UX_EVALUATION_*/`

### Scope

**In scope (UX/DX):**

- User-facing behavior: help text, error messages, output formatting
- Developer experience: discoverability, learnability, consistency
- Accessibility and inclusivity
- Exit codes and signal handling as they affect UX

**Out of scope (code quality):**

- Internal code architecture or style
- Language-specific best practices unrelated to UX
- Performance internals (though responsiveness is evaluated)

## How it works

The plugin provides two components that work together:

- **Skill** (`cli-ux-tester`) — lightweight launcher that detects the target CLI, asks clarifying questions if
  needed, then invokes the agent
- **Agent** (`cli-ux-tester:cli-ux-tester`) — performs the full evaluation by delegating to specialized
  sub-agents (Explore + general-purpose) in parallel, then synthesizes results and writes all artifacts

This separation keeps the parent session's token budget clean and ensures unbiased analysis through fresh
sub-agent contexts.

## Safety and quality notes

- The agent executes commands in the current directory to observe real behavior.
- All generated files use a timestamped directory for easy cleanup.
- The agent always delegates evaluation to sub-agents, keeping the current session's token budget clean.

## License

MIT License, Copyright (c) 2026 Alister Lewis-Bowen.
