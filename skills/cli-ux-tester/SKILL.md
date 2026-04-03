---
name: cli-ux-tester
description: Expert UX evaluator for CLIs, terminal tools, and developer APIs. Use when reviewing command usability, error messages, help systems, or developer experience.
version: 3.0.0
allowed-tools: Read, Bash, AskUserQuestion, Agent
---

# CLI UX Tester

This skill evaluates the usability of command-line interfaces and developer tools. It identifies the target CLI,
asks clarifying questions if needed, then launches an agent to perform a comprehensive evaluation.

**Architecture:** This skill acts as a lightweight launcher. It collects context, then delegates all evaluation work
to the `cli-ux-tester:cli-ux-tester` agent, which keeps the parent session's token budget clean and ensures
unbiased analysis.

## Step 1: Detect target CLI

Try to identify the CLI to evaluate from the user's message and current directory context.

**From the user's message:**

- If the user names a specific command or tool (e.g., "review my-tool"), use that as the target.

**From the current directory:**

```bash
# Check for executable entry points
ls -la *.sh bin/ scripts/ 2>/dev/null | head -20

# Check for package.json with a bin field (Node.js CLI)
cat package.json 2>/dev/null | grep -A5 '"bin"'

# Check for Python CLI setup
cat setup.py pyproject.toml 2>/dev/null | grep -A5 'console_scripts\|entry_points' | head -20

# Check for Go main package
ls main.go cmd/ 2>/dev/null

# Check README for CLI name and usage
head -50 README.md 2>/dev/null
```

## Step 2: Ask clarifying questions if needed

Skip this step if the target CLI was already identified from the user's message in Step 1.

Otherwise, ask exactly one AskUserQuestion using the appropriate form below:

**Entry point(s) detected in current directory** → ask which to evaluate:

```text
Question: "Which CLI should I evaluate?"
Options:
  - [Each detected entry point]
  - A different installed command (provide the name)
  - A different path (provide the path)
```

**No entry points detected** → ask the user to specify:

```text
Question: "Which CLI tool should I evaluate?"
Options:
  - An installed command available in $PATH (provide the name)
  - A path to an executable (provide the path)
```

Proceed directly to Step 3 with whatever the user provides.

## Step 3: Launch evaluation agent

Once the target CLI is identified, launch a `cli-ux-tester:cli-ux-tester` agent with the collected context.

Pass the agent:

- The working directory
- The CLI entry point (command name, script path, or executable)
- Any relevant context from the user's message (e.g., "focus on error messages", "check the help system")
- Paths to the reference files:
  - Use Glob (`**/testing-checklist.md`) to locate `testing-checklist.md`
  - Use Glob (`**/test-scenarios.md`) to locate `test-scenarios.md`

## Step 4: Report results

When the agent completes, inform the user:

```text
✅ Evaluation complete!
📁 Results saved to: {timestamped_directory}
📊 Overall score: {overall_score}/5
🔍 Top issues: {brief_summary}

Clean up with: rm -rf CLI_UX_EVALUATION_*/
```

## Error handling

- **CLI not found**: Ask the user to confirm the command name or path
- **Permission denied**: Note the issue and ask if they want to test a different entry point
- **No CLI in current directory**: Ask the user to specify which tool to evaluate
