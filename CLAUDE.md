# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains a **Claude Code skill** for CLI UX testing and evaluation. It's designed to be installed in users' personal Claude skills directory (`~/.claude/skills/cli-ux-tester/`) and automatically activated when they work with command-line interfaces.

## Repository Structure

```
claude-cli-ux-skill/
├── skill/                       # The actual skill files
│   ├── SKILL.md                 # Main skill definition with YAML frontmatter
│   ├── testing-checklist.md     # Comprehensive testing checklist
│   ├── test-scenarios.md        # Common CLI testing scenarios
│   └── scripts/
│       └── example-test.sh      # Template for automated testing
├── install.sh                   # Bootstrap installer script
├── README.md                    # User-facing documentation
├── CLAUDE.md                    # This file - developer context
└── LICENSE                      # MIT License
```

## What Is a Claude Code Skill?

Skills are **model-invoked, reusable capabilities** in Claude Code:

- **Location**: Installed to `~/.claude/skills/skill-name/`
- **Structure**: Directory containing `SKILL.md` with YAML frontmatter
- **Activation**: Automatically invoked based on the `description` field
- **Scope**: Available across all Claude Code sessions once installed
- **Tools**: Can specify which tools the skill uses

## Key Architecture Concepts

### Skill Definition (skill/SKILL.md)

The main skill file has two parts:

1. **YAML Frontmatter** (controls activation):
```yaml
---
name: cli-ux-tester
description: Expert UX evaluator for command-line interfaces...
---
```

The `description` field is **critical** - it determines when Claude automatically uses this skill. Make it specific about:
- What the skill does (UX evaluation)
- What it applies to (CLIs, terminal tools, APIs)
- When to use it (testing, reviewing, evaluating)
- Key concepts (discoverability, error messages, help systems)

2. **Markdown Content** (guides the skill behavior):
- Instructions on how to perform UX testing
- The 8-criteria framework
- Testing methodology
- Output format expectations
- Best practices

### Supporting Files

Supporting files provide structured guidance:
- **testing-checklist.md**: Ensures comprehensive testing coverage
- **test-scenarios.md**: Provides concrete examples to follow
- **scripts/example-test.sh**: Template for automated testing

### Installation Script (install.sh)

The installer:
- Copies `skill/` directory to `~/.claude/skills/cli-ux-tester/`
- Makes scripts executable
- Handles updates and backups
- Provides clear success/error messages

## Development Guidelines

### Modifying the Skill

When making changes to the skill:

1. **Update skill/SKILL.md** for core behavior changes
2. **Update testing-checklist.md** to add new checklist items
3. **Update test-scenarios.md** to add new testing scenarios
4. **Update README.md** to reflect new features or usage
5. **Test locally** by running `./install.sh --update`

### Testing Changes

To test skill modifications:

```bash
# Make your changes to files in skill/
vim skill/SKILL.md

# Install/update to your local Claude skills
./install.sh --update

# Test in a Claude Code session
cd /path/to/some-cli-project
# Then ask Claude: "Review this CLI for UX issues"
```

### Skill Activation Criteria

The skill activates when the user's message contains:
- Keywords: CLI, command-line, terminal, bash, shell, UX, usability
- Concepts: testing, evaluation, review, critique, analysis
- Specific asks: error messages, help system, discoverability

To improve activation, refine the `description` field in `skill/SKILL.md`.

### Tools the Skill Uses

The skill has access to these Claude Code tools:
- **Bash**: Execute commands and capture output
- **Read**: Read files and documentation
- **Grep**: Search code for patterns
- **Glob**: Find files by pattern
- **Write**: Create test reports and artifacts
- **Task**: Spawn specialized agents for unbiased evaluation (Explore and general-purpose agents)

## The UX Testing Framework

The skill implements an 8-criteria framework for CLI evaluation:

1. **Discovery & Discoverability** - Help systems, version info, documentation
2. **Command & API Naming** - Intuitiveness, consistency, conventions
3. **Error Handling** - Message clarity, actionability, context
4. **Help System** - Completeness, examples, accessibility
5. **Consistency** - Patterns, defaults, configuration
6. **Visual Design** - Formatting, colors, progress indicators
7. **Performance** - Responsiveness, startup time, streaming
8. **Accessibility** - Language clarity, skill levels, terminal compatibility

Each criterion is rated 1-5 with specific evidence from testing.

## Agent-Based Evaluation Architecture

The skill supports two evaluation approaches:

### Direct Testing (Current Session)

Used for small/simple CLIs:
- Executes commands directly in the current session
- Reads source code and documentation
- Generates evaluation reports
- Fast and efficient for straightforward cases

### Agent-Based Evaluation (Fresh Sessions)

Used for large/complex CLIs to ensure unbiased analysis:
- **Exploration Agent** (`subagent_type='Explore'`):
  - Maps codebase structure
  - Finds CLI entry points, help text, error handling
  - Understands command structure and patterns
  - No bias from current conversation context

- **General-Purpose Agent** (`subagent_type='general-purpose'`):
  - Executes comprehensive test scenarios
  - Tests all commands and flags systematically
  - Documents actual vs expected behavior
  - Collects evidence for each criterion

### Benefits of Agent-Based Approach

1. **Fresh Token Budget**: Each agent gets independent token allocation
2. **Unbiased Evaluation**: No context bleed from current conversation
3. **Specialized Focus**: Agents can focus on specific aspects
4. **Parallel Processing**: Multiple agents can work concurrently
5. **Scalability**: Handles large codebases without overwhelming current session

### When to Use Which Approach

**Use Direct Testing when:**
- CLI has <10 commands
- Simple command structure
- Quick evaluation needed
- Current token budget is sufficient

**Use Agent-Based when:**
- CLI has >10 commands or complex subcommand structure
- Large codebase requiring extensive exploration
- Need unbiased evaluation (no prior assumptions)
- Current session has limited token budget
- Want parallel evaluation of different aspects

## Output Artifacts

The skill generates a consistent set of files using the `CLI_UX_EVALUATION_*` naming convention:

### Required Files

1. **CLI_UX_EVALUATION.md**
   - Comprehensive evaluation report
   - Executive summary with overall score
   - Detailed findings across 8 criteria
   - Specific issues with evidence and examples
   - Quick wins and strategic recommendations

2. **CLI_UX_REMEDIATION_PLAN.md**
   - Prioritized action items (Critical → Nice-to-have)
   - Estimated effort for each item (Small, Medium, Large, Very Large)
   - Dependencies between items
   - Code changes needed with file locations
   - Testing recommendations
   - Migration/rollout strategy

### Optional Files

3. **CLI_UX_EVALUATION_METRICS.json**
   - Machine-readable metrics for tracking improvements
   - Scores for each criterion
   - Issue counts by priority
   - Effort estimates
   - Quick wins count

4. **CLI_UX_EVALUATION_TEST.sh**
   - Automated test script based on example-test.sh
   - Customized for the specific CLI
   - Tests all identified scenarios
   - Can be run repeatedly to verify fixes

5. **CLI_UX_EVALUATION_SESSION.cast**
   - asciinema recording of test session (if available)
   - Captures visual output, colors, animations
   - Useful for demonstrating UX issues

6. **CLI_UX_EVALUATION_SUMMARY.txt**
   - Plain text summary for quick reference
   - Overall score and key findings
   - Quick wins list
   - Next steps

7. **CLI_UX_EVALUATION_BEFORE_AFTER.md**
   - Side-by-side comparisons
   - Code examples showing improvements
   - Visual mockups of better UX

### File Naming Convention

All evaluation artifacts use the `CLI_UX_EVALUATION` prefix to:
- Keep related files together in directory listings
- Make it easy to find all evaluation outputs
- Allow easy cleanup with `rm CLI_UX_EVALUATION_*`
- Enable gitignore patterns if needed

## Common Development Tasks

### Adding a New Test Scenario

1. Edit `skill/test-scenarios.md`
2. Follow the existing scenario format:
   - Context description
   - Test flow (bash commands)
   - Evaluation criteria
   - Good/bad examples
3. Update the summary section
4. Run `./install.sh --update` to deploy

### Adding New Checklist Items

1. Edit `skill/testing-checklist.md`
2. Add items under appropriate category
3. Use `- [ ]` checkbox format
4. Provide clear, actionable descriptions
5. Run `./install.sh --update` to deploy

### Improving Skill Activation

If the skill isn't activating when expected:

1. Edit the `description` field in `skill/SKILL.md`
2. Add more specific keywords and concepts
3. Test with various phrasings
4. Keep it focused but comprehensive

### Updating the Test Script Template

1. Edit `skill/scripts/example-test.sh`
2. Add new test groups following existing patterns
3. Ensure proper exit code handling
4. Keep output colorful and clear
5. Update comments and documentation

### Testing Agent-Based Evaluation

1. Find a large/complex CLI project to test with
2. Ask Claude: "Review this CLI for UX issues"
3. Observe whether it uses direct testing or spawns agents
4. Verify the Task tool is called with appropriate subagent_type
5. Check that all output artifacts are generated correctly
6. Validate the CLI_UX_EVALUATION_*.* naming convention

### Validating Output Artifacts

1. Ensure CLI_UX_EVALUATION.md exists and is comprehensive
2. Verify CLI_UX_REMEDIATION_PLAN.md has prioritized action items
3. Check CLI_UX_EVALUATION_METRICS.json is valid JSON with correct structure
4. Test CLI_UX_EVALUATION_TEST.sh script runs successfully
5. Confirm all files use the CLI_UX_EVALUATION prefix

### Testing with Different CLI Sizes

**Small CLI (Direct Testing)**:
- Simple tool with <10 commands
- Should execute directly in current session
- Fast evaluation without spawning agents

**Medium CLI (Either Approach)**:
- 10-30 commands or moderate complexity
- May use either approach based on context
- Test both paths work correctly

**Large CLI (Agent-Based)**:
- >30 commands or complex subcommand structure
- Should spawn Explore and general-purpose agents
- Verify agents coordinate correctly
- Check that findings are synthesized properly

## Installation Flow

When a user runs `./install.sh`:

1. Script validates `skill/` directory exists
2. Checks if already installed at `~/.claude/skills/cli-ux-tester/`
3. If exists, prompts for overwrite or use `--update` flag
4. Creates backup of existing installation
5. Copies `skill/` to `~/.claude/skills/cli-ux-tester/`
6. Makes scripts executable
7. Displays success message with usage instructions

## File Modification Guidelines

### skill/SKILL.md
- YAML frontmatter must be valid
- `name` and `description` are required
- Markdown content provides detailed instructions
- Use clear section headers
- Include concrete examples
- Link to supporting files with relative paths

### testing-checklist.md
- Group items into logical categories
- Use checkbox format for trackability
- Keep items specific and actionable
- Include "why" for non-obvious items

### test-scenarios.md
- Each scenario has: context, test flow, evaluation, examples
- Use real bash commands that can be copied
- Show both good and bad examples
- Provide specific recommendations

### scripts/example-test.sh
- Follow bash best practices
- Use `set -e` for error handling
- Provide colored output for readability
- Include comprehensive comments
- Make it easy to customize

## Distribution

This skill is designed to be:
- **Cloned** from GitHub
- **Installed** via `./install.sh`
- **Updated** via `git pull` + `./install.sh --update`
- **Shared** via GitHub URL

Users don't commit the skill to their projects - they install it once to `~/.claude/skills/` and it works globally.

## Versioning

Consider using semantic versioning:
- **Major**: Breaking changes to skill structure or installation
- **Minor**: New features (scenarios, checklist items, frameworks)
- **Patch**: Bug fixes, documentation improvements

Tag releases in git for users to reference stable versions.

## Best Practices for Skill Development

1. **Be specific in descriptions**: Good activation depends on clear, detailed description text
2. **Provide concrete examples**: Show actual commands and outputs
3. **Link to supporting files**: Use the checklist and scenarios
4. **Test with real CLIs**: Validate the framework against actual tools
5. **Keep it actionable**: Always suggest specific improvements
6. **Stay tool-agnostic**: Work with any CLI, not just specific frameworks
7. **Document edge cases**: Handle TTY detection, missing tools gracefully
8. **Generate consistent artifacts**: Always use CLI_UX_EVALUATION_* naming convention
9. **Choose appropriate evaluation approach**: Use direct testing for simple CLIs, agent-based for complex ones
10. **Coordinate agents effectively**: When using multiple agents, synthesize their findings clearly
11. **Provide machine-readable output**: Include metrics.json for tracking improvements over time

## Troubleshooting

**Skill not activating?**
- Check the `description` field in `skill/SKILL.md`
- Make sure it's installed: `ls ~/.claude/skills/cli-ux-tester/`
- Try more explicit prompts: "Use the CLI UX tester to evaluate..."

**Installation fails?**
- Check permissions on `~/.claude/` directory
- Verify `skill/` directory has all required files
- Run with `bash -x install.sh` for debugging

**Scripts not executable?**
- The installer should handle this, but manually: `chmod +x skill/scripts/*.sh`

**Agent-based evaluation not working?**
- Verify the Task tool is available in Claude Code
- Check that SKILL.md correctly documents agent usage
- Ensure agents are being called with correct subagent_type ('Explore' or 'general-purpose')
- Review agent prompts for clarity and completeness

**Output artifacts not generated?**
- Check that Write tool calls use CLI_UX_EVALUATION_* prefix
- Verify file paths are correct (relative to project root)
- Ensure SKILL.md documents all required artifacts
- Test with a simple CLI first to debug

**Agents not coordinating properly?**
- Review the agent prompts in SKILL.md
- Ensure agents return structured output that can be synthesized
- Check that the main session waits for agents to complete
- Verify TaskOutput tool is used correctly to retrieve agent results

## Contributing Guidelines

When adding features or improvements:
1. Update the relevant file in `skill/`
2. Update `README.md` if it affects user-facing features
3. Update this `CLAUDE.md` if it affects development workflow
4. Test the changes locally
5. Keep commits focused and well-described
6. Follow existing formatting and style

## License

MIT License - Users are free to modify and distribute this skill.

## Goals

This skill aims to:
- Make CLI development more user-centered
- Provide consistent UX evaluation across projects
- Reduce the learning curve for good CLI design
- Automate UX testing workflows
- Build a comprehensive knowledge base of CLI best practices

By packaging this as a reusable skill, developers can get expert CLI UX feedback automatically in any project.
