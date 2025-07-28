#!/bin/bash

# Claude Agents Project Installation Script
# This installs agents and framework docs into current project's .claude directory

echo "Installing Claude Agents into current project..."

# Check if we're in a git repo or project directory
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "README.md" ]; then
    echo "Warning: This doesn't look like a project root directory."
    echo "Are you sure you want to install here? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# Create directories
echo "Creating .claude directories..."
mkdir -p .claude/agents
mkdir -p .claude/templates
mkdir -p .claude/orchestration

# Find the source directory
# If running from ~/.claude/scripts/, look for the original source
if [ -d "$HOME/Dev/claude-agents" ]; then
    SOURCE_DIR="$HOME/Dev/claude-agents"
elif [ -d "$HOME/.claude/agents" ] && [ -f "$HOME/.claude/ORCHESTRATION_FRAMEWORK.md" ]; then
    # Use global installation as source
    SOURCE_DIR="$HOME/.claude"
    AGENTS_SOURCE="$SOURCE_DIR/agents"
    TEMPLATES_SOURCE="$SOURCE_DIR/templates"
else
    # Try to find it relative to script location
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    if [ -f "$(dirname "$SCRIPT_DIR")/ORCHESTRATION_FRAMEWORK.md" ]; then
        SOURCE_DIR="$(dirname "$SCRIPT_DIR")"
    else
        echo "Error: Cannot find claude-agents source files"
        echo "Please ensure claude-agents is installed globally or available at ~/Dev/claude-agents"
        exit 1
    fi
fi

# Set source paths
AGENTS_SOURCE="${AGENTS_SOURCE:-$SOURCE_DIR/agents}"
TEMPLATES_SOURCE="${TEMPLATES_SOURCE:-$SOURCE_DIR/templates}"

# Copy agents
echo "Copying agents from $AGENTS_SOURCE..."
cp "$AGENTS_SOURCE"/*.md .claude/agents/

# Copy framework documentation
echo "Copying framework documentation..."
if [ -f "$SOURCE_DIR/ORCHESTRATION_FRAMEWORK.md" ]; then
    cp "$SOURCE_DIR"/ORCHESTRATION_FRAMEWORK.md .claude/orchestration/
    cp "$SOURCE_DIR"/ORCHESTRATION_QUICK_REFERENCE.md .claude/orchestration/
    cp "$SOURCE_DIR"/PRACTICAL_USAGE_GUIDE.md .claude/orchestration/
else
    # If using global install as source, copy from orchestration subdirectory
    cp "$SOURCE_DIR"/orchestration/*.md .claude/orchestration/
fi

# Copy templates
echo "Copying templates from $TEMPLATES_SOURCE..."
cp "$TEMPLATES_SOURCE"/*.md .claude/templates/

echo "Installation complete!"
echo ""
echo "Framework documentation available at:"
echo "  .claude/orchestration/ORCHESTRATION_FRAMEWORK.md"
echo "  .claude/orchestration/ORCHESTRATION_QUICK_REFERENCE.md"
echo "  .claude/orchestration/PRACTICAL_USAGE_GUIDE.md"
echo ""
echo "Agents installed at:"
echo "  .claude/agents/"
echo ""
echo "Next steps:"
echo "1. Create your PRD in docs/PRD.md"
echo "2. Use Orchestrator agent to initialize the framework"