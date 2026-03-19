# CLI UX Tester

A Claude Code Agent definition for comprehensive UX evaluation of command-line interfaces, developer tools, and APIs.
Install via the Claude Code plugin system (`/plugin install cli-ux-tester@ali5ter`).

## Features

- 8-criteria UX framework with 1-5 scoring per dimension
- Active testing by executing real commands and capturing output
- Agent-based evaluation for large or complex CLIs
- Comprehensive output artifacts: evaluation report, remediation plan, metrics, and test scripts
- Language-agnostic: evaluates user-facing behavior regardless of implementation

## Repository structure

This repository contains the agent definition and supporting resources for distribution. When installed via the plugin
system, the agent is managed by Claude Code.

```text
agents/
  cli-ux-tester.md                 # Agent definition (source)
skill/
  testing-checklist.md             # Comprehensive testing checklist
  test-scenarios.md                # Common CLI testing scenarios
  scripts/
    example-test.sh                # Template for automated testing
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

## Migrating from v1.x

If you previously installed via `./install.sh`, run the migration script from this repo:

```bash
./migrate
```

This removes the old manually-installed skill directory. Then install via the plugin commands above.

## Usage

After installation, the agent is available in all Claude Code sessions. Ask it to evaluate any CLI:

```text
Review this CLI for UX issues
Test the error messages in this tool
Check if this API is developer-friendly
Evaluate the help system
```

### What the agent evaluates

The agent applies an 8-criteria framework, rating each dimension 1-5 with specific evidence:

1. **Discovery & Discoverability** - Can users find features?
2. **Command & API Naming** - Are names intuitive and consistent?
3. **Error Handling & Messages** - Are errors clear and actionable?
4. **Help System & Documentation** - Is help comprehensive and accessible?
5. **Consistency & Patterns** - Do similar operations follow patterns?
6. **Visual Design & Output** - Is output readable and well-formatted?
7. **Performance & Responsiveness** - Does the CLI feel fast?
8. **Accessibility & Inclusivity** - Can diverse developers use it?

### Output artifacts

The agent generates a consistent set of files in the evaluated project:

- **CLI_UX_EVALUATION.md** - Comprehensive evaluation report with scores and findings
- **CLI_UX_REMEDIATION_PLAN.md** - Prioritized implementation plan with code examples
- **CLI_UX_EVALUATION_metrics.json** - Machine-readable scores for tracking over time
- **CLI_UX_EVALUATION_test.sh** - Automated regression test script

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

## Safety and quality notes

- The agent executes commands in the current directory to observe real behavior.
- All generated files use the `CLI_UX_EVALUATION` prefix for easy cleanup (`rm -rf CLI_UX_EVALUATION_*/`).
- The agent always delegates evaluation to sub-agents, keeping the current session's token budget clean and ensuring unbiased analysis.

## License

MIT License, Copyright (c) 2026 Alister Lewis-Bowen.
