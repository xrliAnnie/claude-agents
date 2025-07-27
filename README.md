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

### Orchestration
- **Orchestrator**: Project setup, multi-agent coordination, and iteration management

### Development Team
- **Backend-Developer**: Expert backend development with refactoring capabilities (staff engineer, 15+ YOE)
- **Frontend-Developer**: Expert frontend development with refactoring capabilities (staff engineer, 15+ YOE)
- **Mobile-Developer**: iOS and Android development expertise (staff engineer, 15+ YOE)
- **Data-Engineer**: Data pipelines, warehousing, and analytics infrastructure (staff engineer, 15+ YOE)
- **Data-Scientist**: ML/AI expertise with educational transparency (staff data scientist, 15+ YOE)

### Infrastructure & Operations
- **DevOps-SRE**: Infrastructure automation, CI/CD, and site reliability (staff engineer, 15+ YOE)
- **Security-Engineer**: Enterprise security auditing and vulnerability assessment

### Quality & Testing
- **QA-Engineer**: Test automation, performance testing, and quality assurance (staff engineer, 15+ YOE)

### Product & Design
- **Product-Manager**: PRD writing and development planning (staff PM, 15+ YOE)
- **Designer**: UI/UX design and frontend architecture assistance

### Content & Documentation
- **content-writer**: Content writing assistance

## Usage

Once installed, Claude Code will automatically detect and use these agents when appropriate for your tasks.