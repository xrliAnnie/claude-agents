# Monorepo Multi-Agent Quick Start

## 1. Initialize Your Monorepo Project

```bash
# In your monorepo root, ask Claude:
"Use the Orchestrator agent to set up coordination for my monorepo project"

# Or run directly:
./scripts/setup-orchestration.sh --type monorepo --services "backend frontend mobile"
```

## 2. Key Setup for Monorepos

Your monorepo will have this structure:
```
monorepo/
├── coordination/        # Shared by ALL agents
│   ├── specs/          # API contracts, interfaces
│   ├── progress/       # Agent status tracking
│   └── iterations/     # Sprint plans
├── backend/            # ONLY Backend-Developer writes here
├── frontend/           # ONLY Frontend-Developer writes here
├── mobile/             # ONLY Mobile-Developer writes here
└── shared/             # Shared utilities
```

## 3. Agent Instructions Template

When starting agents, use this template:

```
You are working on our monorepo e-commerce project. Rules:
1. You work from the root directory
2. You can READ any file in the project
3. You can WRITE only to [backend|frontend|mobile]/ and coordination/progress/[your-name].md
4. When committing, use:
   git add [your-directory]/ coordination/progress/[your-name].md
   git commit -m '[your-prefix]: description'
5. Check your tasks in coordination/iterations/current
6. Read API specs from coordination/specs/api/
```

## 4. Running Agents in Parallel

### Terminal 1: Backend
```
"Backend-Developer agent, implement the auth API from coordination/iterations/current. 
Write code only in backend/, commit with 'backend:' prefix."
```

### Terminal 2: Frontend
```
"Frontend-Developer agent, build the login UI from coordination/iterations/current.
Write code only in frontend/, commit with 'frontend:' prefix."
```

### Terminal 3: Mobile
```
"Mobile-Developer agent, create the mobile auth flow from coordination/iterations/current.
Write code only in mobile/, commit with 'mobile:' prefix."
```

## 5. Daily Coordination

### Morning Check
```
"Orchestrator, check all agent progress and identify blockers"
```

### Integration Points
```
"Review coordination/specs/api/ and ensure all agents are aligned"
```

### Blocker Resolution
```
"Backend-Developer, Frontend is blocked on API spec. Please update coordination/specs/api/auth.yaml"
```

## 6. Git Workflow

Each agent commits independently:
```bash
# Backend commits
git add backend/ coordination/progress/backend.md
git commit -m 'backend: implement JWT authentication'

# Frontend commits  
git add frontend/ coordination/progress/frontend.md
git commit -m 'frontend: add login form component'

# No merge conflicts! 🎉
```

## 7. Common Commands

### Start new feature
```
"Orchestrator, set up Sprint 2 for payment integration feature"
```

### Check status
```
"Show me the current progress of all agents"
```

### Integration test
```
"Create an integration checklist for current sprint features"
```

### Handoff work
```
"Backend API is complete. Frontend-Developer can now integrate with endpoints in coordination/specs/api/"
```

## 8. Pro Tips for Monorepos

1. **Always specify directories**: Be explicit about where agents can write
2. **Use coordination/specs/**: Define all interfaces before coding starts
3. **Commit frequently**: Small, focused commits prevent conflicts
4. **Update progress daily**: Keep coordination/progress/ files current
5. **Flag blockers early**: Don't let agents get stuck

## Example: Full Feature Flow

```bash
# 1. Plan
"PM-Architecture, create tasks for user profile feature"

# 2. Setup
"Orchestrator, set up sprint for profile feature"

# 3. Specs
"Create API specification for user profiles in coordination/specs/api/profiles.yaml"

# 4. Parallel work (3 terminals)
"Backend: implement profile API"
"Frontend: build profile UI"  
"Mobile: create profile screens"

# 5. Integrate
"Check integration between all profile implementations"

# 6. Test
"QA-Test-Engineer, test the profile feature across all platforms"

# 7. Ship
git log --oneline
# backend: implement profile CRUD API
# frontend: add profile management UI
# mobile: implement profile screens
# qa: add profile feature tests
```

## Remember

- **Orchestrator** sets up structure
- **You** coordinate agents
- **Agents** work independently in their directories
- **Git** stays clean with prefixed commits
- **Progress** is tracked in coordination/

Happy orchestrating! 🎭