#!/bin/bash

# Claude Agents Global Installation Script
# This can be run from anywhere if the source files are in the standard location

echo "Installing Claude Agents with Orchestration Framework globally..."

# Try to find the source directory
if [ -d "$HOME/Dev/claude-agents" ]; then
    SOURCE_DIR="$HOME/Dev/claude-agents"
elif [ -d "./agents" ] && [ -f "./ORCHESTRATION_FRAMEWORK.md" ]; then
    SOURCE_DIR="."
else
    echo "Error: Cannot find claude-agents source directory"
    echo "Please run this from the claude-agents directory or ensure it exists at ~/Dev/claude-agents"
    exit 1
fi

echo "Using source directory: $SOURCE_DIR"

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/templates
mkdir -p ~/.claude/orchestration/scripts

# Copy agents
echo "Copying agents..."
cp "$SOURCE_DIR"/agents/*.md ~/.claude/agents/

# Copy framework documentation
echo "Copying framework documentation..."
mkdir -p ~/.claude/orchestration
cp "$SOURCE_DIR"/ORCHESTRATION_FRAMEWORK.md ~/.claude/orchestration/
cp "$SOURCE_DIR"/ORCHESTRATION_QUICK_REFERENCE.md ~/.claude/orchestration/
cp "$SOURCE_DIR"/PRACTICAL_USAGE_GUIDE.md ~/.claude/orchestration/

# Copy templates
echo "Copying templates..."
cp "$SOURCE_DIR"/templates/*.md ~/.claude/templates/

# Copy scripts
echo "Copying scripts..."
cp "$SOURCE_DIR"/scripts/*.sh ~/.claude/orchestration/scripts/
chmod +x ~/.claude/orchestration/scripts/*.sh

echo "Installation complete!"
echo ""
echo "Framework documentation available at:"
echo "  ~/.claude/orchestration/ORCHESTRATION_FRAMEWORK.md"
echo "  ~/.claude/orchestration/ORCHESTRATION_QUICK_REFERENCE.md"
echo "  ~/.claude/orchestration/PRACTICAL_USAGE_GUIDE.md"
echo ""
echo "Agents installed at:"
echo "  ~/.claude/agents/"
echo ""
echo "Templates available at:"
echo "  ~/.claude/templates/"