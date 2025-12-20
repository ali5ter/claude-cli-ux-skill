# CLI UX Tester Skill for Claude Code

A comprehensive UX evaluation skill for command-line interfaces (CLIs), developer tools, and APIs. Automatically activated when working with CLIs in [Claude Code](https://claude.com/claude-code).

## Overview

This skill enables Claude to act as an expert UX designer specializing in command-line interface usability and developer experience. It provides structured testing frameworks, comprehensive checklists, and automated evaluation capabilities for any CLI tool or developer-facing API.

## Features

### 🎯 Automatic Activation

The skill automatically activates when you mention:
- CLI, command-line, terminal, bash, shell
- UX testing, usability, developer experience
- Error messages, help systems, documentation
- API design, developer tools, SDKs

### 📊 8-Criteria UX Framework

Evaluates CLIs across 8 key dimensions (rated 1-5):
1. **Discovery & Discoverability** - Can users find features?
2. **Command & API Naming** - Are names intuitive and consistent?
3. **Error Handling & Messages** - Are errors clear and actionable?
4. **Help System & Documentation** - Is help comprehensive and accessible?
5. **Consistency & Patterns** - Do similar operations follow patterns?
6. **Visual Design & Output** - Is output readable and well-formatted?
7. **Performance & Responsiveness** - Does the CLI feel fast?
8. **Accessibility & Inclusivity** - Can diverse developers use it?

### 🧪 Active Testing Capabilities

- **Executes actual commands** to test behavior
- **Captures and analyzes output** for UX issues
- **Tests error scenarios** (missing args, invalid flags, etc.)
- **Records sessions** with asciinema (if available)
- **Generates detailed reports** with specific findings and recommendations

### 📋 Comprehensive Resources

- **Testing Checklist** - 100+ items across 10 categories
- **Test Scenarios** - 15 common CLI testing scenarios with examples
- **Example Test Script** - Automated testing template
- **Best Practices** - Guidance on good vs bad CLI design

## Installation

### Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/claude-cli-ux-skill.git
cd claude-cli-ux-skill
./install.sh
```

The skill will be installed to `~/.claude/skills/cli-ux-tester/`

### Update Existing Installation

```bash
cd claude-cli-ux-skill
git pull
./install.sh --update
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/claude-cli-ux-skill.git

# Copy to Claude skills directory
mkdir -p ~/.claude/skills
cp -r claude-cli-ux-skill/skill ~/.claude/skills/cli-ux-tester
```

## Usage

Once installed, the skill works automatically across all your Claude Code sessions.

### Example Prompts

**General UX Review:**
```
Review this CLI for UX issues
```

**Specific Focus:**
```
Test the error messages in this tool
Evaluate the help system
Check command discoverability
Analyze the spinner commands for usability
```

**Testing Workflows:**
```
Test this CLI with common error scenarios
Record a session and analyze the UX
Check if this API is developer-friendly
```

### What Happens When Activated

When you ask about CLI UX, the skill will:

1. **Execute commands** to test actual behavior
   ```bash
   command --help
   command --version
   command invalid_args
   ```

2. **Read documentation and source code**
   - README files
   - Help text
   - Implementation details

3. **Apply the 8-criteria framework**
   - Rate each criterion 1-5
   - Provide specific evidence
   - Note strengths and issues

4. **Generate actionable recommendations**
   - Quick wins (easy + high impact)
   - Strategic improvements
   - Code examples showing before/after

### Example Interaction

```
You: Review pfb's spinner commands for UX issues

Claude: I'll conduct a comprehensive UX evaluation of pfb's spinner functionality.

[Executes commands and analyzes output]

## UX Evaluation: pfb Spinner Commands

### Overall Score: 4.2/5

### Executive Summary
**Strengths:**
- Clear, semantic command naming (spinner start/stop)
- Excellent backward compatibility
- Smooth visual feedback

**Issues:**
- No --help flag for spinner subcommand
- Limited documentation of manual start/stop workflow
- No progress percentage option

[... detailed analysis with examples and recommendations ...]
```

## What's Included

```
claude-cli-ux-skill/
├── README.md                    # This file
├── CLAUDE.md                    # Context for working on this skill
├── LICENSE                      # MIT License
├── install.sh                   # Installation script
└── skill/
    ├── SKILL.md                 # Main skill definition
    ├── testing-checklist.md     # Comprehensive testing checklist
    ├── test-scenarios.md        # 15 common CLI testing scenarios
    └── scripts/
        └── example-test.sh      # Automated testing template
```

## Configuration

The skill uses these tools when available:
- **Bash** - Execute commands and capture output
- **Read** - Read source code and documentation
- **Grep** - Search for patterns in code
- **Glob** - Find files by pattern
- **Write** - Create test reports

Optional tools (if installed):
- **asciinema** - Record terminal sessions
- **agg** - Convert recordings to GIF

## Examples of Use

### Testing a New CLI Tool

```
You: I'm building a new deployment CLI. Can you review the help system?

[Skill activates and tests help discovery, documentation, examples]
```

### Improving Error Messages

```
You: These error messages feel unclear. What would make them better?

[Skill analyzes error scenarios and suggests improvements with examples]
```

### API Design Review

```
You: Review this library's API for developer experience

[Skill evaluates naming, consistency, documentation, and ergonomics]
```

## Works Across All Projects

The skill is installed in your **personal** Claude directory (`~/.claude/skills/`), so it automatically works in:
- ✅ Any CLI tool you're developing
- ✅ Shell scripts and bash utilities
- ✅ Developer APIs and SDKs
- ✅ Terminal UI/TUI applications
- ✅ Any repository with command-line interfaces

## Customization

You can customize the skill by editing files in `~/.claude/skills/cli-ux-tester/`:

- **SKILL.md** - Adjust the UX framework or add new criteria
- **testing-checklist.md** - Add project-specific checklist items
- **test-scenarios.md** - Add custom scenarios for your domain
- **scripts/example-test.sh** - Adapt the test script template

## Uninstall

```bash
rm -rf ~/.claude/skills/cli-ux-tester
```

## Requirements

- [Claude Code](https://claude.com/claude-code) - The official CLI for Claude
- Bash 4.0+ (for test scripts)

Optional:
- [asciinema](https://asciinema.org/) - Record terminal sessions
- [agg](https://github.com/asciinema/agg) - Convert recordings to GIF

## Contributing

Contributions are welcome! This skill can be improved with:
- Additional test scenarios
- More comprehensive checklists
- Better examples of good/bad CLI design
- Support for more CLI frameworks and patterns

## License

MIT License - see [LICENSE](LICENSE) file for details.

## About

This skill was created to make CLI development more user-centered by providing expert UX evaluation automatically within Claude Code sessions. It combines best practices from CLI design, developer experience research, and usability testing methodologies.

## Resources

- [CLI Guidelines](https://clig.dev/) - Comprehensive CLI best practices
- [12 Factor CLI Apps](https://medium.com/@jdxcode/12-factor-cli-apps-dd3c227a0e46)
- [Command Line Interface Guidelines](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html)
- [Designing Command-Line Tools](https://pragprog.com/titles/pg_clt/designing-command-line-tools/)

## Acknowledgments

Built for use with [Claude Code](https://claude.com/claude-code), leveraging the Claude Agent SDK's skill system for automatic context-aware activation.
