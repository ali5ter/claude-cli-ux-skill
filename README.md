# CLI UX Tester Skill for Claude Code

A comprehensive UX evaluation skill for command-line interfaces (CLIs), developer tools, and APIs. Automatically activated when working with CLIs in [Claude Code](https://claude.com/claude-code).

## Overview

This skill enables Claude to act as an expert UX designer specializing in command-line interface usability and developer experience. It provides structured testing frameworks, comprehensive checklists, and automated evaluation capabilities for CLI tools and developer-facing APIs.

**Language Agnostic:** This skill evaluates the *user-facing behavior* of CLIs, not their implementation. The UX evaluation framework applies universally to command-line tools regardless of the programming language or framework used to build them.

### What This Skill Evaluates

**In Scope (UX/DX):**

- ✅ User-facing behavior (help text, error messages, output formatting)
- ✅ Developer experience (discoverability, learnability, consistency)
- ✅ Accessibility and inclusivity
- ✅ Bash best practices that affect UX (error handling, exit codes, signal handling)

**Out of Scope (Code Quality):**

- ❌ Internal code quality or architecture
- ❌ Language-specific coding style (unless it impacts UX)
- ❌ Bash scripting best practices unrelated to UX (e.g., `set -e`, variable quoting)
- ❌ Performance optimization internals (though responsiveness is evaluated)

**Note:** For Bash script code review (not UX), use general code review. This skill focuses solely on the user and developer experience.

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

- **Executes actual commands** to test real behavior
- **Captures and analyzes output** for UX issues
- **Tests error scenarios** (missing args, invalid flags, etc.)
- **Records sessions** with asciinema (if available) to capture visual output
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

```prompt
Review this CLI for UX issues
```

**Specific Focus:**

```prompt
Test the error messages in this tool
Evaluate the help system
Check command discoverability
Analyze the progress indicators for usability
Review the subcommand structure
```

**Testing Workflows:**

```prompt
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

```text
You: Review this deployment CLI's command structure for UX issues

Claude: I'll conduct a comprehensive UX evaluation of your deployment CLI.

[Executes commands and analyzes output]

## UX Evaluation: Deployment CLI

### Overall Score: 4.2/5

### Executive Summary
**Strengths:**
- Clear, semantic command naming (deploy, rollback, status)
- Excellent help system with examples
- Smooth progress feedback during deployments

**Issues:**
- No --help flag for environment subcommands
- Inconsistent flag naming between commands
- No confirmation prompt for destructive operations

[... detailed analysis with examples and recommendations ...]
```

## What's Included

```text
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

### Claude Code Tools

The skill uses these **Claude Code built-in tools** when testing:

- **Bash** - Execute commands and capture output
- **Read** - Read source code and documentation files
- **Grep** - Search for patterns in code
- **Glob** - Find files by pattern matching
- **Write** - Create test reports and documentation

These tools are part of Claude Code and require no additional setup.

### Optional External Tools

If available on your system, the skill can use:

- **asciinema** - Record terminal sessions with full visual fidelity (captures colors, animations, spinners, formatting, and all visual output in real-time)
- **agg** - Convert asciinema recordings to animated GIF format for sharing

Install these tools for enhanced visual testing:

```bash
# macOS
brew install asciinema agg

# Ubuntu/Debian
apt-get install asciinema
# agg: cargo install agg

# Arch
pacman -S asciinema
# agg: cargo install agg
```

## Examples of Use

### Testing a New CLI Tool

```text
You: I'm building a new deployment CLI. Can you review the help system?

[Skill activates and tests help discovery, documentation, examples]
```

### Improving Error Messages

```text
You: These error messages feel unclear. What would make them better?

[Skill analyzes error scenarios and suggests improvements with examples]
```

### API Design Review

```text
You: Review this library's API for developer experience

[Skill evaluates naming, consistency, documentation, and ergonomics]
```

## Works Across All Projects

The skill is installed in your **personal** Claude directory (`~/.claude/skills/`), so it automatically works with:

- ✅ CLI tools in any programming language
- ✅ Shell scripts and utilities
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

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on:

- How to report issues and suggest enhancements
- Development setup and testing workflow
- Submitting pull requests
- Code style and documentation standards

Areas where contributions are especially valuable:

- Additional test scenarios for common CLI patterns
- More comprehensive checklist items
- Examples of good/bad CLI design from real tools
- Support for new CLI frameworks and patterns
- Documentation improvements and clarifications

## License

MIT License - see [LICENSE](LICENSE) file for details.

## About

This skill was created to make CLI development more user-centered by providing expert UX evaluation automatically within Claude Code sessions. It combines best practices from CLI design, developer experience research, and usability testing methodologies.

## Resources

### Guidelines & Best Practices

- [CLI Guidelines](https://clig.dev/) - Comprehensive CLI best practices
- [12 Factor CLI Apps](https://medium.com/@jdxcode/12-factor-cli-apps-dd3c227a0e46) - Principles for building great CLIs
- [GNU Command Line Interface Guidelines](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html) - Standards and conventions

### Books

- [Small Sharp Software Tools](https://pragprog.com/) by Brian P. Hogan - Building flexible command-line tools
- [Powerful Command-Line Applications in Go](https://pragprog.com/) by Ricardo Gerardi - Go CLI development

## Acknowledgments

Built for use with [Claude Code](https://claude.com/claude-code), leveraging the Claude Agent SDK's skill system for automatic context-aware activation.
