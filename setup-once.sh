#!/bin/bash

# One-time setup script for Claude Agents
# Run this ONCE to set up ~/.claude/ with all necessary files

echo "=== Claude Agents One-Time Setup ==="
echo ""
echo "This will copy all agents, scripts, and documentation to ~/.claude/"
echo "After this, the Orchestrator can handle project-specific installations automatically."
echo ""

# Check if already installed
if [ -d "$HOME/.claude/agents" ] && [ -f "$HOME/.claude/ORCHESTRATION_FRAMEWORK.md" ]; then
    echo "✓ Claude Agents already installed in ~/.claude/"
    echo "  No action needed."
    exit 0
fi

# Create all directories
echo "Creating directories..."
mkdir -p ~/.claude/{agents,templates,scripts}

# Copy agents
echo "Installing agents..."
cp agents/*.md ~/.claude/agents/

# Copy framework documentation
echo "Installing framework documentation..."
mkdir -p ~/.claude/orchestration
cp ORCHESTRATION_FRAMEWORK.md ~/.claude/orchestration/
cp ORCHESTRATION_QUICK_REFERENCE.md ~/.claude/orchestration/
cp PRACTICAL_USAGE_GUIDE.md ~/.claude/orchestration/

# Copy templates
echo "Installing templates..."
cp templates/*.md ~/.claude/templates/

# Copy scripts
echo "Installing scripts..."
cp scripts/*.sh ~/.claude/scripts/
chmod +x ~/.claude/scripts/*.sh

echo ""
echo "✓ Installation complete!"
echo ""
echo "What was installed:"
echo "  • 12 agents in ~/.claude/agents/"
echo "  • Framework docs in ~/.claude/orchestration/"
echo "  • Templates in ~/.claude/templates/"
echo "  • Scripts in ~/.claude/scripts/"
echo ""
echo "Next steps:"
echo "1. Go to any project directory"
echo "2. Say: 'Orchestrator, initialize the orchestration framework'"
echo "3. The Orchestrator will handle everything from there!"
echo ""
echo "The Orchestrator will automatically install project-specific files when needed."