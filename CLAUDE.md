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
- **Write**: Create test reports (when generating critique documents)

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
