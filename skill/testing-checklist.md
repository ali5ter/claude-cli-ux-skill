# CLI UX Testing Checklist

Use this checklist to ensure comprehensive testing of command-line interfaces.

## Pre-Testing Setup

- [ ] Identify the CLI tool name and version
- [ ] Locate documentation (README, man pages, --help)
- [ ] Identify target user personas (beginner, intermediate, expert)
- [ ] Set up test environment

## 1. Discovery & Discoverability

### Help System
- [ ] `command --help` works
- [ ] `command -h` works (if applicable)
- [ ] `command help` works (if applicable)
- [ ] Help text is comprehensive
- [ ] Help text includes examples
- [ ] Subcommands have their own help (`command subcommand --help`)

### Version Information
- [ ] `command --version` works
- [ ] `command -v` works (if applicable)
- [ ] Version format is clear (semantic versioning preferred)

### Documentation
- [ ] README exists and is clear
- [ ] Installation instructions are complete
- [ ] Usage examples are provided
- [ ] Common use cases are documented
- [ ] Troubleshooting guide exists
- [ ] Man pages exist (for system tools)

### Discovery Methods
- [ ] Tool explains itself when run without args
- [ ] Error messages suggest help commands
- [ ] Related commands are mentioned

## 2. Command & API Naming

### Naming Conventions
- [ ] Command names are intuitive
- [ ] Verb-noun pattern is used consistently
- [ ] Abbreviations are standard or explained
- [ ] Similar operations use similar names
- [ ] Names match user mental models

### Flag Consistency
- [ ] Long flags use double dashes (`--flag`)
- [ ] Short flags use single dash (`-f`)
- [ ] Boolean flags don't require arguments
- [ ] Flag names are descriptive
- [ ] Common flags use standard names (`--verbose`, `--quiet`, `--force`)

### Subcommands
- [ ] Subcommands are clearly named
- [ ] Subcommand structure is consistent
- [ ] Subcommands are grouped logically

## 3. Error Handling & Messages

### Error Message Quality
- [ ] Errors are specific, not generic
- [ ] Errors explain what went wrong
- [ ] Errors suggest how to fix
- [ ] Errors include relevant context (file paths, line numbers)
- [ ] Errors don't expose internal implementation details

### Error Scenarios to Test
- [ ] Missing required arguments: `command`
- [ ] Invalid flag: `command --invalid-flag`
- [ ] File not found: `command nonexistent.txt`
- [ ] Permission denied: `command /protected/file`
- [ ] Invalid input format: `command malformed-input`
- [ ] Network errors (if applicable)
- [ ] Timeout errors (if applicable)

### Exit Codes
- [ ] Success returns 0
- [ ] Errors return non-zero codes
- [ ] Different error types have distinct codes
- [ ] Exit codes are documented

## 4. Help System & Documentation

### Help Text Structure
- [ ] Usage line shows syntax clearly
- [ ] Description explains purpose
- [ ] All options are documented
- [ ] Option descriptions are clear
- [ ] Examples are included
- [ ] Related commands are mentioned
- [ ] Links to more documentation provided

### Documentation Completeness
- [ ] All features are documented
- [ ] Edge cases are explained
- [ ] Configuration options are documented
- [ ] Environment variables are listed
- [ ] Limitations are mentioned

## 5. Consistency & Patterns

### Command Patterns
- [ ] Similar operations follow same pattern
- [ ] Flag order doesn't matter (where possible)
- [ ] Subcommand structure is consistent
- [ ] Input/output formats are consistent

### Default Behavior
- [ ] Defaults are sensible and safe
- [ ] Defaults are documented
- [ ] Defaults can be overridden
- [ ] Behavior without flags is predictable

### Configuration
- [ ] Config file locations are standard
- [ ] Config file format is clear
- [ ] Environment variables follow naming convention
- [ ] CLI flags override config files
- [ ] Config precedence is documented

## 6. Visual Design & Output

### Output Formatting
- [ ] Output is well-formatted
- [ ] Columns are aligned
- [ ] Tables have headers
- [ ] Long outputs are paginated or truncated gracefully

### Color Usage
- [ ] Colors have semantic meaning
- [ ] Colors work on dark and light backgrounds
- [ ] Color can be disabled (`--no-color`)
- [ ] NO_COLOR environment variable is respected
- [ ] Critical info isn't color-only (accessible)

### Progress Indicators
- [ ] Long operations show progress
- [ ] Spinners animate smoothly
- [ ] Progress bars update frequently
- [ ] Estimated time is shown (if possible)
- [ ] Progress can be disabled for scripts

### Interactive Elements
- [ ] Prompts are clear
- [ ] Default values are shown
- [ ] Prompts can be skipped with flags
- [ ] Confirmation prompts for destructive operations
- [ ] Ctrl+C exits gracefully

## 7. Performance & Responsiveness

### Startup Performance
- [ ] `--help` is instant (<100ms)
- [ ] `--version` is instant (<100ms)
- [ ] Simple commands feel immediate (<500ms)
- [ ] Lazy loading is used for heavy dependencies

### Operation Performance
- [ ] Long operations show progress
- [ ] Streaming output for large data
- [ ] Incremental results when possible
- [ ] Timeouts are configurable
- [ ] Performance is acceptable for target use cases

### Resource Usage
- [ ] Memory usage is reasonable
- [ ] CPU usage is reasonable
- [ ] Disk I/O is efficient
- [ ] Network usage is efficient (if applicable)

## 8. Accessibility & Inclusivity

### Language & Communication
- [ ] Language is clear and simple
- [ ] Jargon is explained or avoided
- [ ] Examples use diverse contexts
- [ ] Error messages are helpful, not blaming

### Terminal Compatibility
- [ ] Works in different shells (bash, zsh, fish)
- [ ] Works with different terminal emulators
- [ ] Works in SSH/remote sessions
- [ ] Works with different terminal sizes
- [ ] Handles terminal resize gracefully

### Keyboard Accessibility
- [ ] All features are keyboard-accessible
- [ ] Tab completion works (if applicable)
- [ ] Arrow keys work in interactive modes
- [ ] Common keyboard shortcuts work (Ctrl+C, Ctrl+D)

### Different Skill Levels
- [ ] Beginners can accomplish basic tasks
- [ ] Experts have advanced options
- [ ] Progressive disclosure of complexity
- [ ] Good defaults for common use cases

## 9. Integration & Interoperability

### Shell Integration
- [ ] Tab completion available
- [ ] Works in pipes: `cat file | command | grep pattern`
- [ ] Respects stdin/stdout/stderr correctly
- [ ] Exit codes work with `&&` and `||`

### Standard Conventions
- [ ] Follows POSIX conventions (where applicable)
- [ ] Respects standard environment variables (HOME, PATH, etc.)
- [ ] Uses standard config locations (XDG Base Directory)
- [ ] Works with standard tools (grep, awk, sed)

### Output Formats
- [ ] JSON output available
- [ ] YAML output available (if relevant)
- [ ] CSV output available (for tabular data)
- [ ] Plain text output available
- [ ] Format is selectable via flag

## 10. Security & Safety

### Destructive Operations
- [ ] Destructive ops require confirmation
- [ ] `--force` flag bypasses confirmation (documented)
- [ ] Dry-run mode available (`--dry-run`, `--whatif`)
- [ ] Backup options for destructive changes

### Credential Handling
- [ ] Credentials never in command history
- [ ] Credentials from env vars or config files
- [ ] Credentials not echoed to screen
- [ ] Secure defaults for permissions

### Input Validation
- [ ] Inputs are validated
- [ ] SQL injection prevented (if applicable)
- [ ] Command injection prevented
- [ ] Path traversal prevented

## Testing Notes

### Observations

[Space for notes during testing]

### Issues Found

[List specific issues with severity]

### Recommendations

[Specific improvements to suggest]

## Rating Summary

Rate each category 1-5:

- Discovery & Discoverability: ___/5
- Command & API Naming: ___/5
- Error Handling & Messages: ___/5
- Help System & Documentation: ___/5
- Consistency & Patterns: ___/5
- Visual Design & Output: ___/5
- Performance & Responsiveness: ___/5
- Accessibility & Inclusivity: ___/5

**Overall UX Score: ___/5** (average of above)

## Next Steps

Based on findings:
1. [Priority 1 action item]
2. [Priority 2 action item]
3. [Priority 3 action item]
