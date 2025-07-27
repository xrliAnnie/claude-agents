#!/bin/bash
# Orchestration Setup Script
# Used by the Orchestrator agent to quickly initialize project structure

set -e

# Default values
PROJECT_TYPE="monorepo"
SERVICES="backend frontend mobile"
INCLUDE_INFRA="yes"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --type)
      PROJECT_TYPE="$2"
      shift 2
      ;;
    --services)
      SERVICES="$2"
      shift 2
      ;;
    --no-infra)
      INCLUDE_INFRA="no"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "🎯 Setting up orchestration structure..."
echo "   Type: $PROJECT_TYPE"
echo "   Services: $SERVICES"

# Create coordination structure
echo "📁 Creating coordination directories..."
mkdir -p coordination/{specs,progress,decisions,iterations,blockers}
mkdir -p coordination/specs/{api,database,interfaces}
mkdir -p coordination/iterations/{template,sprint-01}

# Create service directories based on type
if [ "$PROJECT_TYPE" = "monorepo" ]; then
  echo "📁 Creating monorepo structure..."
  for service in $SERVICES; do
    mkdir -p "$service"
  done
  mkdir -p shared
  [ "$INCLUDE_INFRA" = "yes" ] && mkdir -p infrastructure
else
  echo "📁 Creating service-based structure..."
  mkdir -p services
  for service in $SERVICES; do
    mkdir -p "services/$service"
  done
  mkdir -p clients/{web,mobile}
fi

# Create .claude orchestration directory
mkdir -p .claude/orchestration

# Initialize progress files
echo "📝 Creating progress tracking files..."
for service in $SERVICES; do
  cat > "coordination/progress/${service}.md" << EOF
# ${service^} Progress

## Current Sprint
- [ ] Not started

## Completed

## Blocked

## Notes
EOF
done

# Create additional progress files
for role in qa devops security; do
  cat > "coordination/progress/${role}.md" << EOF
# ${role^^} Progress

## Current Sprint
- [ ] Not started

## Completed

## Blocked

## Notes
EOF
done

# Create sprint template
echo "📋 Creating sprint template..."
cat > coordination/iterations/template.md << 'EOF'
# Sprint [NUMBER] Plan

## Sprint Goal
[One sentence describing the main outcome]

## Duration
- Start: [DATE]
- End: [DATE]
- Days: [NUMBER]

## Features/Tasks

### Priority 1 (Must Have)
- [ ] Feature/Task description
  - Backend: [specific task]
  - Frontend: [specific task]
  - Mobile: [specific task]

### Priority 2 (Should Have)
- [ ] Feature/Task description

### Priority 3 (Nice to Have)
- [ ] Feature/Task description

## Agent Assignments

### Backend-Developer
1. [ ] Task with reference to coordination/specs/
2. [ ] Integration with frontend

### Frontend-Developer
1. [ ] Task with reference to coordination/specs/
2. [ ] Integration with backend

### Mobile-Developer
1. [ ] Task with reference to coordination/specs/
2. [ ] Integration with backend

### QA-Test-Engineer
1. [ ] Test plan for features
2. [ ] Integration test suite

### DevOps-SRE
1. [ ] Infrastructure needs
2. [ ] Deployment pipeline

## Success Criteria
- [ ] All P1 features complete
- [ ] Tests passing (>90% coverage)
- [ ] Integration verified
- [ ] No critical bugs

## Dependencies
- External: [any external dependencies]
- Internal: [cross-team dependencies]

## Risks
- [Identified risks and mitigation]
EOF

# Create coordination README
echo "📚 Creating coordination guide..."
cat > coordination/README.md << EOF
# Project Coordination Guide

## Structure
- \`specs/\` - Shared specifications (API contracts, interfaces, schemas)
- \`progress/\` - Agent progress tracking
- \`decisions/\` - Architectural decisions and rationale
- \`iterations/\` - Sprint plans and retrospectives
- \`blockers/\` - Current blocking issues

## Workflow

### For Agents
1. Read your tasks from \`iterations/current/plan.md\`
2. Check dependencies in \`specs/\`
3. Update your progress in \`progress/[agent].md\`
4. Flag blockers in \`blockers/\`

### For Orchestrator
1. Monitor all \`progress/*.md\` files
2. Resolve blockers
3. Update iteration plans
4. Coordinate integration points

## Git Workflow
Each agent commits with prefixes:
- \`backend:\` for backend changes
- \`frontend:\` for frontend changes
- \`mobile:\` for mobile changes
- \`devops:\` for infrastructure changes
- \`qa:\` for test changes
- \`docs:\` for documentation changes

## Communication
All inter-agent communication happens through files in this directory.
No agent should modify another agent's primary directory.
EOF

# Create initial sprint plan
echo "🚀 Creating first sprint..."
cp coordination/iterations/template.md coordination/iterations/sprint-01/plan.md
ln -sf sprint-01/plan.md coordination/iterations/current

# Create agent instruction template
echo "📜 Creating agent instructions..."
cat > .claude/orchestration/agent-instructions.md << 'EOF'
# Agent Working Instructions

## For All Agents

### Directory Access
- **You work from**: Project root directory
- **You can read**: Any file in the project
- **You can write to**: Only your designated directories + coordination files

### Your Designated Directories
- Backend-Developer: `backend/`, `coordination/progress/backend.md`
- Frontend-Developer: `frontend/`, `coordination/progress/frontend.md`
- Mobile-Developer: `mobile/`, `coordination/progress/mobile.md`
- QA-Test-Engineer: `tests/`, `qa/`, `coordination/progress/qa.md`
- DevOps-SRE: `infrastructure/`, `.github/`, `coordination/progress/devops.md`

### Git Commit Rules
```bash
# Only stage files from your directories
git add [your-directory]/ coordination/progress/[your-name].md
git commit -m '[prefix]: descriptive message'
```

### Coordination Protocol
1. Start by reading: `coordination/iterations/current`
2. Check specs: `coordination/specs/`
3. Update progress: `coordination/progress/[your-name].md`
4. Check for blockers: `coordination/blockers/`

### Integration Points
- API contracts: `coordination/specs/api/`
- Data models: `coordination/specs/database/`
- UI components: `coordination/specs/interfaces/`

## Example Workflow
1. Read your sprint tasks
2. Check if dependencies are ready
3. Implement your tasks
4. Update progress file
5. Commit with proper prefix
6. Flag any blockers
EOF

echo "✅ Orchestration setup complete!"
echo ""
echo "Next steps:"
echo "1. Have PM-Architecture analyze your PRD"
echo "2. Update coordination/iterations/sprint-01/plan.md with tasks"
echo "3. Start agents with instructions from .claude/orchestration/agent-instructions.md"
echo ""
echo "To monitor progress:"
echo "  cat coordination/progress/*.md"