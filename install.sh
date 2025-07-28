#!/bin/bash

# Claude Agents Installation Script

echo "Installing Claude Agents with Orchestration Framework..."

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/templates
mkdir -p ~/.claude/scripts

# Copy agents
echo "Copying agents..."
cp agents/*.md ~/.claude/agents/

# Copy framework documentation
echo "Copying framework documentation..."
cp ORCHESTRATION_FRAMEWORK.md ~/.claude/
cp ORCHESTRATION_QUICK_REFERENCE.md ~/.claude/
cp PRACTICAL_USAGE_GUIDE.md ~/.claude/

# Copy templates
echo "Copying templates..."
cp templates/*.md ~/.claude/templates/

# Copy scripts
echo "Copying scripts..."
cp scripts/*.sh ~/.claude/scripts/
chmod +x ~/.claude/scripts/*.sh

echo "Installation complete!"
echo ""
echo "Framework documentation available at:"
echo "  ~/.claude/ORCHESTRATION_FRAMEWORK.md"
echo "  ~/.claude/ORCHESTRATION_QUICK_REFERENCE.md"
echo "  ~/.claude/PRACTICAL_USAGE_GUIDE.md"
echo ""
echo "Agents installed at:"
echo "  ~/.claude/agents/"
echo ""
echo "Templates available at:"
echo "  ~/.claude/templates/"