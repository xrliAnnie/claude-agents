# Using the Orchestrator Agent

This example shows how to use the Orchestrator agent to set up and manage a multi-agent project.

## Step 1: Initial Setup

**You type:**
```
I'm starting a new e-commerce project. It's a monorepo with backend (Node.js), 
frontend (React), and mobile (React Native). Use the Orchestrator agent to 
set up the project structure.
```

**Claude responds:**
```
I'll use the Orchestrator agent to set up your e-commerce project structure 
with proper coordination for multi-agent development.
```

**Orchestrator agent will:**
1. Create coordination directories
2. Set up monorepo structure
3. Initialize progress tracking
4. Create sprint templates
5. Generate agent instructions

**Result:**
```
ecommerce-project/
├── coordination/
│   ├── README.md           # Coordination guide
│   ├── specs/              # Shared specifications
│   ├── progress/           # Agent progress files
│   ├── iterations/         # Sprint planning
│   └── blockers/           # Blocker tracking
├── backend/                # Backend code
├── frontend/               # Frontend code
├── mobile/                 # Mobile code
├── shared/                 # Shared utilities
└── .claude/
    └── orchestration/      # Agent instructions
```

## Step 2: Planning First Sprint

**You type:**
```
Now use PM-Architecture to analyze this PRD and create our first sprint plan:

# E-commerce PRD
- User authentication with social login
- Product catalog with search
- Shopping cart
- Checkout with Stripe
- Order history
```

**PM-Architecture creates plan, then you:**
```
Use the Orchestrator agent to set up our first sprint focusing on 
authentication and product catalog.
```

**Orchestrator will:**
- Update `coordination/iterations/sprint-01/plan.md`
- Assign specific tasks to each agent
- Define integration points
- Set up API contracts in `coordination/specs/api/`

## Step 3: Distributing Work to Agents

**You type:**
```
Give me the instructions to share with each agent for this sprint.
```

**Orchestrator provides customized instructions:**

### For Backend-Developer:
```
Your Sprint 1 tasks:
1. Build authentication API with JWT and social login
2. Create product catalog API with search
3. Read specs from coordination/specs/api/auth.yaml
4. Write code ONLY in backend/
5. Update coordination/progress/backend.md daily
6. Commit with prefix: "backend: [message]"
```

### For Frontend-Developer:
```
Your Sprint 1 tasks:
1. Build login/signup pages with social login buttons
2. Create product listing and search UI
3. Read API specs from coordination/specs/api/
4. Write code ONLY in frontend/
5. Update coordination/progress/frontend.md daily
6. Commit with prefix: "frontend: [message]"
```

### For Mobile-Developer:
```
Your Sprint 1 tasks:
1. Build authentication flow with biometric option
2. Create product browsing interface
3. Read API specs from coordination/specs/api/
4. Write code ONLY in mobile/
5. Update coordination/progress/mobile.md daily
6. Commit with prefix: "mobile: [message]"
```

## Step 4: Daily Coordination

**Each morning, you type:**
```
Use the Orchestrator to check progress and identify any blockers.
```

**Orchestrator will:**
- Read all progress files
- Identify completed tasks
- Find blockers
- Suggest next actions

**Example output:**
```
## Progress Summary - Sprint 1, Day 3

### Completed
✅ Backend: Auth API endpoints done
✅ Frontend: Login UI complete
✅ Mobile: Auth flow designed

### In Progress
🔄 Backend: Product search implementation (70%)
🔄 Frontend: Product listing page (50%)
🔄 Mobile: Login implementation (60%)

### Blockers
🚨 Frontend: Waiting for product API pagination spec
🚨 Mobile: Need auth token format clarification

### Recommended Actions
1. Backend to document pagination in coordination/specs/api/products.yaml
2. Schedule integration test for auth flow
3. Mobile and Backend sync on token format
```

## Step 5: Integration Checkpoint

**Mid-sprint, you type:**
```
Use the Orchestrator to coordinate an integration check between all agents.
```

**Orchestrator creates:**
```markdown
# Integration Checkpoint - Sprint 1

## Auth Integration
- [ ] Backend /login endpoint returns expected format
- [ ] Frontend stores JWT token correctly
- [ ] Mobile handles token refresh
- [ ] All clients handle 401 errors consistently

## API Contracts
- [ ] Product API matches coordination/specs/api/products.yaml
- [ ] Error formats consistent across all endpoints
- [ ] Pagination works as specified

## Test Coverage
- [ ] Backend: Auth endpoints have unit tests
- [ ] Frontend: Login flow has E2E tests
- [ ] Mobile: Auth flow has integration tests

## Next Steps
1. Fix any mismatches found
2. Update specs if needed
3. Continue to remaining sprint work
```

## Step 6: Sprint Wrap-up

**End of sprint, you type:**
```
Use the Orchestrator to wrap up Sprint 1 and prepare for Sprint 2.
```

**Orchestrator will:**
1. Create retrospective from progress files
2. Archive Sprint 1 documentation
3. Create Sprint 2 template
4. Identify carry-over tasks
5. Update coordination structure

## Key Benefits

1. **No Manual Setup**: Orchestrator creates all structure
2. **Clear Boundaries**: Each agent knows exactly where to work
3. **Progress Visibility**: Always know who's doing what
4. **Conflict Prevention**: Monorepo-friendly git workflow
5. **Easy Coordination**: File-based communication that works

## Pro Tips

### Tip 1: Let Orchestrator Handle Structure
Don't manually create directories. Ask:
```
"Set up orchestration for my [type] project with [services]"
```

### Tip 2: Regular Check-ins
Daily:
```
"Check progress and blockers"
```

### Tip 3: Integration First
Define interfaces early:
```
"Create API specs for [feature] before implementation starts"
```

### Tip 4: Sprint Rhythm
Keep sprints short (5-7 days) for faster feedback:
```
"Set up a 5-day sprint for [features]"
```

The Orchestrator agent eliminates the manual work of coordination, letting you focus on building your product!