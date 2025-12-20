# CLI UX Test Scenarios

Common testing scenarios for evaluating command-line interface usability.

## Scenario 1: First-Time User

**Context**: A developer encounters your CLI for the first time.

**Test Flow**:
```bash
# What happens when they just run the command?
command

# Can they find help?
command --help
command help

# Can they discover the version?
command --version
```

**Evaluate**:
- Does the tool explain itself?
- Is help easy to find?
- Are next steps clear?
- Is there a getting started guide?

**Good Example**:
```
$ mytool

mytool - A tool for doing awesome things

Usage: mytool <command> [options]

Commands:
  init     Initialize a new project
  build    Build the project
  deploy   Deploy to production

Get started: mytool init
For help:    mytool --help
```

**Bad Example**:
```
$ mytool
Error: missing required argument
```

## Scenario 2: Missing Required Arguments

**Context**: User runs command without required arguments.

**Test Flow**:
```bash
# No arguments
command

# Some but not all arguments
command arg1

# Wrong argument types
command --flag=invalid
```

**Evaluate**:
- Error message specificity
- Suggested corrections
- Example usage shown
- Exit code is non-zero

**Good Example**:
```
$ deploy

Error: Missing required argument: <environment>

Usage: deploy <environment> [options]

Examples:
  deploy staging
  deploy production --tag v1.2.3

For more information: deploy --help
```

## Scenario 3: Invalid Flag or Option

**Context**: User provides an unrecognized flag.

**Test Flow**:
```bash
command --invalid-flag
command -x
command --typo
```

**Evaluate**:
- Does it suggest similar valid flags?
- Does it show available flags?
- Is the error clear about what's invalid?

**Good Example**:
```
$ build --optimze

Error: Unknown option '--optimze'

Did you mean '--optimize'?

Available options:
  --optimize    Enable optimizations
  --verbose     Show detailed output
  --output      Specify output directory

For more information: build --help
```

## Scenario 4: File Not Found

**Context**: User references a non-existent file.

**Test Flow**:
```bash
command nonexistent.txt
command --config missing.yml
command --input /path/does/not/exist
```

**Evaluate**:
- Shows the path that was checked
- Suggests alternatives if applicable
- Explains what file is needed and why

**Good Example**:
```
$ process --config app.yml

Error: Configuration file not found: 'app.yml'

Searched in:
  ./app.yml
  ~/.config/myapp/app.yml
  /etc/myapp/app.yml

To create a default config: myapp init --config
For more help: myapp --help
```

## Scenario 5: Permission Denied

**Context**: User lacks permissions for an operation.

**Test Flow**:
```bash
command /protected/file
command --output /system/file
sudo command  # If applicable
```

**Evaluate**:
- Clear about permission issue
- Suggests solution (sudo, chmod, etc.)
- Explains why permission is needed

**Good Example**:
```
$ install --global

Error: Permission denied to write to '/usr/local/bin'

This command requires elevated privileges.
Try: sudo install --global

Or install locally: install --user
```

## Scenario 6: Interactive Prompts

**Context**: Tool uses interactive prompts for input.

**Test Flow**:
```bash
# Run interactive command
command interactive-task

# Test with yes/no prompts
# Test with text input
# Test with selection menus
```

**Evaluate**:
- Prompts are clear
- Default values shown
- Can skip with flags for automation
- Ctrl+C exits gracefully

**Good Example**:
```
$ init

? Project name: (my-project) █
? Use TypeScript? (Y/n) Y
? Install dependencies? (Y/n) Y

✓ Created project 'my-project'
✓ Installed dependencies

Next steps:
  cd my-project
  npm start
```

## Scenario 7: Long-Running Operations

**Context**: Command takes significant time to complete.

**Test Flow**:
```bash
# Run operation that takes >2 seconds
command long-task

# Check for progress indication
# Test cancellation (Ctrl+C)
```

**Evaluate**:
- Progress indicator present
- Estimated time shown
- Can be cancelled gracefully
- Final summary shown

**Good Example**:
```
$ build

Building project...
[████████████████████████░░░░] 87% (43/50 files)
Estimated time remaining: 3s

✓ Build complete in 27s
  Output: dist/
  Size: 2.3 MB
```

## Scenario 8: Error Recovery

**Context**: Operation fails partway through.

**Test Flow**:
```bash
# Trigger partial failure
command complex-task  # That fails midway

# Check state after failure
# Try to resume or rollback
```

**Evaluate**:
- Clear about what failed
- State of partial completion
- How to recover or retry
- Rollback if destructive

**Good Example**:
```
$ deploy production

Deploying to production...
✓ Built assets
✓ Uploaded to CDN
✗ Database migration failed: Connection timeout

Error: Deployment partially complete

Completed:
  ✓ Build (commit abc123)
  ✓ CDN upload

Failed:
  ✗ Database migration

To retry: deploy production --resume
To rollback: deploy rollback
```

## Scenario 9: Configuration Files

**Context**: Tool uses configuration files.

**Test Flow**:
```bash
# Run without config
command

# Create config
command init --config

# Run with config
command --config custom.yml

# Invalid config
echo "invalid: ][" > bad.yml
command --config bad.yml
```

**Evaluate**:
- Config file location is clear
- Config format is documented
- Validation errors are helpful
- Can generate default config

**Good Example**:
```
$ run --config myconfig.yml

Error: Invalid configuration file 'myconfig.yml'

  Line 5: Unexpected token ']['

  Expected format:
    server:
      port: 3000
      host: localhost

To generate a default config: run init --config
For config docs: https://docs.example.com/config
```

## Scenario 10: Output Formats

**Context**: Tool provides multiple output formats.

**Test Flow**:
```bash
# Default output
command list

# Different formats
command list --format json
command list --format yaml
command list --format table
command list --format csv
```

**Evaluate**:
- Default format is human-readable
- Machine-readable formats available
- Format flag is consistent
- Output is valid in specified format

**Good Example**:
```bash
# Human-readable default
$ list
Users:
  - Alice (admin)
  - Bob (user)
  - Carol (user)

# Machine-readable
$ list --format json
{"users":[{"name":"Alice","role":"admin"},{"name":"Bob","role":"user"}]}

# Formatted JSON
$ list --format json --pretty
{
  "users": [
    {"name": "Alice", "role": "admin"},
    {"name": "Bob", "role": "user"}
  ]
}
```

## Scenario 11: Piping and Redirection

**Context**: Tool used in shell pipelines.

**Test Flow**:
```bash
# As input receiver
cat file.txt | command process

# As output producer
command generate | grep pattern

# Both
cat input.txt | command transform | grep result

# Output redirection
command > output.txt
command 2> errors.txt
command > output.txt 2>&1
```

**Evaluate**:
- Respects stdin/stdout/stderr
- Buffering is appropriate
- Exit codes work correctly
- Progress indicators disabled in pipes

**Good Example**:
```bash
# Interactive when TTY
$ transform data.txt
Processing... [████████] 100%
✓ Done

# Silent in pipes
$ transform data.txt | grep success
success: 42 records processed
```

## Scenario 12: Dry Run Mode

**Context**: User wants to preview changes.

**Test Flow**:
```bash
# Dry run
command dangerous-operation --dry-run
command dangerous-operation --whatif
command dangerous-operation --preview

# Check nothing actually changed
```

**Evaluate**:
- Dry run flag exists
- Shows what would happen
- No side effects occur
- Clear about simulation

**Good Example**:
```
$ delete --pattern "*.tmp" --dry-run

Dry run mode: No files will be deleted

Would delete:
  cache/temp1.tmp (2.3 MB)
  cache/temp2.tmp (1.1 MB)
  logs/debug.tmp (5.2 MB)

Total: 3 files, 8.6 MB

To execute: delete --pattern "*.tmp"
```

## Scenario 13: Tab Completion

**Context**: User expects tab completion in shell.

**Test Flow**:
```bash
# Install completions
command completion install

# Test completion
command <TAB>
command subcommand --<TAB>
```

**Evaluate**:
- Completion is available
- Installation is documented
- Completes commands
- Completes flags
- Completes file paths where relevant

## Scenario 14: Verbosity Levels

**Context**: User wants more or less output detail.

**Test Flow**:
```bash
# Quiet mode
command --quiet
command -q

# Verbose mode
command --verbose
command -v

# Debug mode
command --debug
```

**Evaluate**:
- Multiple verbosity levels
- Quiet suppresses all but essential
- Verbose shows helpful details
- Debug shows technical details

**Good Example**:
```
# Default
$ build
✓ Build complete

# Verbose
$ build --verbose
Compiling src/main.ts
Compiling src/utils.ts
Bundling...
Minifying...
✓ Build complete in 2.3s

# Debug
$ build --debug
[DEBUG] Config loaded from: ./config.yml
[DEBUG] Node version: 18.0.0
[DEBUG] Compiling src/main.ts
[DEBUG] AST parsed: 245 nodes
[DEBUG] Output size: 125 KB
✓ Build complete in 2.3s
```

## Scenario 15: Version Compatibility

**Context**: Tool versions change over time.

**Test Flow**:
```bash
# Check version
command --version

# Check for updates
command update --check

# Migrate from old version
```

**Evaluate**:
- Version clearly displayed
- Breaking changes documented
- Migration guides available
- Backward compatibility noted

## Testing Template

Use this template for each scenario:

```markdown
## Scenario: [Name]

**Commands Executed**:
```bash
[actual commands run]
```

**Observed Behavior**:
[what happened]

**Expected Behavior**:
[what should happen]

**Rating**: ___/5

**Issues**:
- [specific issue 1]
- [specific issue 2]

**Recommendations**:
- [specific improvement 1]
- [specific improvement 2]
```

## Summary

After testing all relevant scenarios:

1. **Most Common Issues**: [patterns observed]
2. **Best Aspects**: [what works well]
3. **Priority Fixes**: [top 3 improvements needed]
4. **Overall Usability**: ___/5
