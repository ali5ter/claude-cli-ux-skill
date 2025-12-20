#!/usr/bin/env bash
#
# Install script for CLI UX Tester skill
#
# This script installs the cli-ux-tester skill to your personal Claude skills directory.
#
# Usage:
#   ./install.sh           # Install to default location
#   ./install.sh --update  # Update existing installation
#

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default installation directory
INSTALL_DIR="${HOME}/.claude/skills/cli-ux-tester"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SOURCE="${SCRIPT_DIR}/skill"

# Parse arguments
UPDATE_MODE=false
if [[ "${1:-}" == "--update" ]] || [[ "${1:-}" == "-u" ]]; then
    UPDATE_MODE=true
fi

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}CLI UX Tester Skill Installer${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if skill source exists
if [[ ! -d "$SKILL_SOURCE" ]]; then
    echo -e "${RED}Error: Skill source directory not found: $SKILL_SOURCE${NC}"
    exit 1
fi

# Check if already installed
if [[ -d "$INSTALL_DIR" ]]; then
    if [[ "$UPDATE_MODE" == true ]]; then
        echo -e "${YELLOW}Updating existing installation...${NC}"
        echo "Location: $INSTALL_DIR"
        echo ""
    else
        echo -e "${YELLOW}Skill already installed at: $INSTALL_DIR${NC}"
        echo ""
        read -p "Overwrite existing installation? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Installation cancelled.${NC}"
            echo ""
            echo "To update, run: $0 --update"
            exit 0
        fi
        echo ""
    fi

    # Backup existing installation
    BACKUP_DIR="${INSTALL_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${BLUE}Creating backup...${NC}"
    mv "$INSTALL_DIR" "$BACKUP_DIR"
    echo "Backup saved to: $BACKUP_DIR"
    echo ""
fi

# Create installation directory
echo -e "${BLUE}Installing skill...${NC}"
mkdir -p "$(dirname "$INSTALL_DIR")"

# Copy skill files
cp -r "$SKILL_SOURCE" "$INSTALL_DIR"

# Make scripts executable
if [[ -d "$INSTALL_DIR/scripts" ]]; then
    chmod +x "$INSTALL_DIR/scripts"/*.sh 2>/dev/null || true
fi

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo -e "${BLUE}Installed to:${NC} $INSTALL_DIR"
echo ""

# Verify installation
echo -e "${BLUE}Installed files:${NC}"
if command -v tree &> /dev/null; then
    tree -L 2 "$INSTALL_DIR"
else
    find "$INSTALL_DIR" -type f | sed "s|$INSTALL_DIR|.|g" | sort
fi
echo ""

# Instructions
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Installation Successful!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "The CLI UX Tester skill is now available in all your Claude Code sessions."
echo ""
echo -e "${BLUE}How to use:${NC}"
echo "  Simply mention CLI testing, UX evaluation, or usability in any Claude Code session."
echo ""
echo -e "${BLUE}Example prompts:${NC}"
echo '  - "Review this CLI for UX issues"'
echo '  - "Test the error messages in this tool"'
echo '  - "Evaluate the help system"'
echo '  - "Check command discoverability"'
echo ""
echo -e "${BLUE}The skill will automatically activate when relevant.${NC}"
echo ""
echo -e "${BLUE}Resources:${NC}"
echo "  - Skill definition:    $INSTALL_DIR/SKILL.md"
echo "  - Testing checklist:   $INSTALL_DIR/testing-checklist.md"
echo "  - Test scenarios:      $INSTALL_DIR/test-scenarios.md"
echo "  - Example test script: $INSTALL_DIR/scripts/example-test.sh"
echo ""
echo -e "${BLUE}To uninstall:${NC}"
echo "  rm -rf $INSTALL_DIR"
echo ""
