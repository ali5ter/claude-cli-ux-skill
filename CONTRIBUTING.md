# Contributing to CLI UX Tester Skill

Thank you for your interest in contributing to the CLI UX Tester skill! This skill helps developers create better command-line interfaces by providing expert UX evaluation within Claude Code.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Submitting Changes](#submitting-changes)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors, regardless of experience level, background, or identity.

### Expected Behavior

- Be respectful and constructive in discussions
- Focus on what's best for the community and users
- Show empathy towards other contributors
- Accept constructive criticism gracefully
- Be patient with newcomers

### Unacceptable Behavior

- Harassment, discrimination, or personal attacks
- Trolling or inflammatory comments
- Publishing others' private information
- Other conduct that would be inappropriate in a professional setting

## How Can I Contribute?

### Reporting Issues

If you find a bug or have a suggestion:

1. **Search existing issues** to avoid duplicates
2. **Open a new issue** with a clear title and description
3. **Include examples** when possible (CLI tools, commands, expected vs actual behavior)
4. **Specify your environment** (Claude Code version, OS, shell)

### Suggesting Enhancements

Enhancement suggestions are welcome! Consider:

- **New UX criteria** - Additional evaluation dimensions
- **Test scenarios** - Common CLI testing patterns
- **Checklist items** - Specific UX checks to include
- **Best practice examples** - Good/bad CLI design patterns
- **Tool integrations** - Additional testing tools to support

### Contributing Code

We welcome contributions that:

- Add new test scenarios to `skill/test-scenarios.md`
- Expand the testing checklist in `skill/testing-checklist.md`
- Improve the UX framework in `skill/SKILL.md`
- Enhance documentation and examples
- Fix bugs or typos
- Add support for new CLI frameworks or patterns

## Development Setup

### Prerequisites

- [Claude Code](https://claude.com/claude-code) installed
- Git for version control
- A text editor
- (Optional) A CLI tool to test against

### Getting Started

1. **Fork the repository** on GitHub

2. **Clone your fork** locally:

   ```bash
   git clone https://github.com/YOUR_USERNAME/claude-cli-ux-skill.git
   cd claude-cli-ux-skill
   ```

3. **Create a branch** for your changes:

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Install the skill** locally to test:

   ```bash
   ./install.sh
   ```

### Testing Your Changes

After making changes, test them thoroughly:

1. **Update the skill** in your Claude directory:

   ```bash
   ./install.sh --update
   ```

2. **Test with a real CLI** in a Claude Code session:

   ```bash
   cd /path/to/some-cli-project
   # Then in Claude Code: "Review this CLI for UX issues"
   ```

3. **Verify activation** - Check that your changes are being used
4. **Test edge cases** - Try different CLI types and languages
5. **Check documentation** - Ensure examples are accurate

## Making Changes

### File Structure

```text
claude-cli-ux-skill/
├── skill/                       # Core skill files
│   ├── SKILL.md                 # Main skill definition (YAML + instructions)
│   ├── testing-checklist.md     # Comprehensive checklist
│   ├── test-scenarios.md        # Common testing scenarios
│   └── scripts/
│       └── example-test.sh      # Test script template
├── install.sh                   # Installation script
├── README.md                    # User documentation
├── CLAUDE.md                    # Developer context
└── CONTRIBUTING.md              # This file
```

### Types of Changes

#### 1. Adding Test Scenarios

Edit `skill/test-scenarios.md`:

```markdown

## Scenario N: [Descriptive Name]

### Context

[When/why to use this scenario]

### Test Flow

# Commands to run

command --test

### Evaluation Criteria

- What to look for
- Good vs bad indicators

### Example

**Good:** [Example]
**Bad:** [Example]
```

#### 2. Adding Checklist Items

Edit `skill/testing-checklist.md`:

```markdown
### [Category Name]

- [ ] Specific, actionable item to check
- [ ] Another item with clear pass/fail criteria
```

#### 3. Enhancing the UX Framework

Edit `skill/SKILL.md`:

- **YAML frontmatter**: Only change if updating activation keywords
- **Markdown content**: Add criteria, examples, or testing methodology
- **Keep the 8 criteria structure** unless proposing a major change

#### 4. Improving Documentation

Edit `README.md` or `CLAUDE.md`:

- **README.md**: User-facing documentation
- **CLAUDE.md**: Developer/contributor context
- Keep examples generic (not project-specific)
- Use clear, simple language

### Commit Guidelines

Write clear, descriptive commit messages:

```bash
# Good commit messages
git commit -m "Add test scenario for interactive prompts"
git commit -m "Fix typo in error handling checklist"
git commit -m "Update README with Python CLI examples"

# Less helpful
git commit -m "Update files"
git commit -m "Fix stuff"
```

Format:

- Use present tense ("Add feature" not "Added feature")
- Be specific about what changed
- Reference issues if applicable (`Fixes #123`)

## Submitting Changes

### Pull Request Process

1. **Update documentation** if you've changed functionality
2. **Test thoroughly** using `./install.sh --update`
3. **Commit your changes** with clear messages
4. **Push to your fork**:

   ```bash
   git push origin feature/your-feature-name
   ```

5. **Open a Pull Request** on GitHub with:

   - Clear title describing the change
   - Description of what changed and why
   - Examples of testing you performed
   - Any relevant issue numbers

### Pull Request Checklist

- [ ] Changes have been tested with real CLIs
- [ ] Documentation is updated (README, CLAUDE.md if needed)
- [ ] Examples are generic and applicable to any CLI
- [ ] Commit messages are clear and descriptive
- [ ] No project-specific references (e.g., "pfb")
- [ ] Changes follow existing formatting and style
- [ ] No unintentional file changes included

### Review Process

- Maintainers will review your PR
- Discussion and feedback may be requested
- Changes may be requested before merging
- Once approved, your PR will be merged

## Style Guidelines

### Markdown

- Use ATX-style headers (`#` not underlines)
- Use fenced code blocks with language tags
- Use **bold** for emphasis, *italic* sparingly
- Keep lines under 100 characters when possible
- Use lists for scannable content

### Code Examples

```bash
# Good: Clear, generic, commented
mycli deploy --env production  # Deploy to production

# Bad: Project-specific, no context
pfb spinner start
```

### Writing Style

- **Clear and concise** - Respect the reader's time
- **Active voice** - "Run the command" not "The command should be run"
- **Generic examples** - Avoid specific project names
- **Inclusive language** - "They/them" for generic developers
- **Avoid jargon** - Or explain it when necessary

### YAML Frontmatter

Only modify `skill/SKILL.md` frontmatter if:

- Adding activation keywords to `description`
- Changing the skill name (requires discussion first)

Format:

```yaml
---
name: cli-ux-tester
description: Expert UX evaluator for command-line interfaces...
---
```

### Testing Checklist Items

Format:

```markdown
- [ ] Clear, actionable item (not vague)
- [ ] Item with context (why it matters)
```

Not:

```markdown
- [ ] Check stuff
- [ ] Make it better
```

## Questions or Need Help?

- **Open an issue** for questions or discussions
- **Check existing issues** for similar topics
- **Read CLAUDE.md** for developer context
- **Ask in your PR** if unsure about something

## Recognition

Contributors will be recognized in:

- GitHub contributors list
- Release notes for significant contributions
- Special thanks for major enhancements

## License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers this project.

## Thank You

Your contributions make CLI tools better for everyone. Whether you're fixing a typo, adding a test scenario, or proposing a major enhancement, your efforts are appreciated.
