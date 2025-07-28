# Claude Code Custom Agents with Orchestration Framework

This repository contains custom agents for Claude Code that work together using a 5-phase orchestration framework for agent-led software development.

## Installation

### For Project-Specific Use
Copy the agents to your project's `.claude/agents/` directory:
```bash
mkdir -p .claude/agents
cp agents/*.md .claude/agents/
```

### For Global Use (All Projects)
Copy the agents, framework docs, and scripts to your user's Claude directory:
```bash
# Copy agents
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/

# Copy framework documentation
cp ORCHESTRATION_FRAMEWORK.md ~/.claude/
cp ORCHESTRATION_QUICK_REFERENCE.md ~/.claude/
cp PRACTICAL_USAGE_GUIDE.md ~/.claude/

# Copy templates
mkdir -p ~/.claude/templates
cp templates/*.md ~/.claude/templates/

# Copy orchestration scripts
mkdir -p ~/.claude/scripts
cp scripts/*.sh ~/.claude/scripts/
chmod +x ~/.claude/scripts/*.sh
```

## Orchestration Framework

The agents work together using a 5-phase development framework:
1. **Strategic Planning** - Product-Manager creates milestone plan
2. **Product Design** - UX-Designer creates designs, engineers review
3. **Technical Architecture** - Engineers create and cross-review architectures
4. **Milestone Setup** - Orchestrator prepares milestone directories
5. **Implementation** - Iterative development within each milestone

See `ORCHESTRATION_FRAMEWORK.md` for detailed information.

## Available Agents

### Orchestration
- **Orchestrator**: Framework initialization, milestone setup, and status monitoring

### Development Team
- **Backend-Developer**: Expert backend development with comprehensive DevOps capabilities (staff engineer, 15+ YOE)
- **Frontend-Developer**: Expert frontend development with deployment capabilities (staff engineer, 15+ YOE)
- **Mobile-Developer**: iOS and Android development with release automation (staff engineer, 15+ YOE)
- **Data-Engineer**: Data pipelines, warehousing, and analytics infrastructure (staff engineer, 15+ YOE)
- **Data-Scientist**: ML/AI expertise with educational transparency (staff data scientist, 15+ YOE)

### Security & Compliance
- **Security-Engineer**: Enterprise security auditing and vulnerability assessment

### Quality & Testing
- **QA-Engineer**: Test automation, performance testing, and quality assurance (staff engineer, 15+ YOE)
- **Bar-Raiser**: Principal-level technical review for designs and code (principal engineer, 20+ YOE)

### Product & Design
- **Product-Manager**: PRD writing and development planning (staff PM, 15+ YOE)
- **UX-Designer**: UI/UX design and frontend architecture assistance

### Content & Documentation
- **Content-Writer**: Content writing assistance

## Orchestration Framework

This repository includes a comprehensive orchestration framework for managing complex multi-agent projects:

### Phase-Based Development
1. **Strategic Planning**: Product-Manager creates milestone breakdown
2. **Product Design**: UX-Designer creates, all engineers review
3. **Technical Architecture**: Engineers design systems, cross-review
4. **Milestone Setup**: Orchestrator creates project structure
5. **Implementation Loop**: Design → Build → Test → Review → Ship

### Key Features
- **Milestone-Based**: Break large projects into 2-4 week milestones
- **Microservice Architecture**: Independent services for parallel development
- **Review Gates**: Every phase has quality checkpoints
- **Cross-Functional Reviews**: Engineers review each other's work
- **Comprehensive Testing**: Unit tests by developers, E2E tests by QA

### Documentation
- [ORCHESTRATION_FRAMEWORK.md](ORCHESTRATION_FRAMEWORK.md) - Complete framework guide
- [ORCHESTRATION_QUICK_REFERENCE.md](ORCHESTRATION_QUICK_REFERENCE.md) - Quick command reference
- [PRACTICAL_USAGE_GUIDE.md](PRACTICAL_USAGE_GUIDE.md) - Step-by-step usage instructions

## Usage

Once installed, Claude Code will automatically detect and use these agents when appropriate for your tasks.

### Quick Start with Pull Model
```bash
# 1. Initialize framework
"Orchestrator, initialize framework for my [project type] project"

# 2. Create PRD
"Create a PRD for [your project description]"
"Save that to docs/PRD.md"

# 3. Start Phase 1
"Product-Manager, check phase status and begin work"

# 4. Agents work autonomously
# Just check status and activate agents when needed:
"Show me odyssey/status/phase-status.md"
"All engineers, check phase status for your tasks"
```

**Key Insight**: Agents monitor status files and work when it's their turn. You don't manually coordinate - the framework does it for you!