# Claude Code Custom Agents

This repository contains custom agents for Claude Code.

## Installation

### For Project-Specific Use
Copy the agents to your project's `.claude/agents/` directory:
```bash
mkdir -p .claude/agents
cp agents/*.md .claude/agents/
```

### For Global Use (All Projects)
Copy the agents to your user's Claude directory:
```bash
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/
```

## Available Agents

- **Backend-Developer**: Expert backend development (staff engineer, 15+ YOE)
- **Frontend-Developer**: Expert frontend development (staff engineer, 15+ YOE)
- **code-refactorer**: Code refactoring assistance
- **content-writer**: Content writing assistance
- **UI/UX**: UI/UX design and frontend architecture assistance
- **PM-PRD**: Product requirements document writing (staff PM level)
- **PM-Architecture**: Project architecture and development planning (staff PM level)
- **security**: Security audit assistance
- **vibe-coding-coach**: Coding guidance and coaching

## Usage

Once installed, Claude Code will automatically detect and use these agents when appropriate for your tasks.