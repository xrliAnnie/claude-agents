# Iterative Development Flow with Agents

## Your Current Human Workflow
1. PM generates PRD
2. Designer creates UI/UX design  
3. PM/Designer/Engineers review together
4. Engineers implement in different areas
5. Engineers integrate changes
6. DevOps sets up CI/CD (if needed)
7. QA tests the product
8. QA reports issues, engineers fix
9. Everyone reviews
10. Ship or iterate

## Optimized Agent Workflow

### Phase 1: Planning & Design (Day 1)

```bash
# Step 1: PM creates comprehensive plan
You: "Analyze the PRD at docs/PRD.md and create a development plan"
Claude: [Spawns PM-Architecture agent]
Output: coordination/plan.md

# Step 2: UI/UX creates designs based on PRD
You: "Create UI designs based on the PRD and plan"
Claude: [Spawns UI/UX agent]
Output: coordination/ui-designs.md

# Step 3: Technical review - YOU facilitate this
You: "Review the plan and designs. Are they practical?"
- Read both outputs
- Identify concerns
- Create coordination/review-feedback.md
```

### Phase 2: Parallel Development (Days 2-4)

```bash
# Open 3-4 terminal windows/tabs

# Terminal 1: Backend API
You: "Build the user authentication API based on coordination/plan.md section 3.2"
Claude: [Spawns Backend-Developer agent]
Output: src/api/auth/

# Terminal 2: Frontend 
You: "Build the login UI based on coordination/ui-designs.md page 3"
Claude: [Spawns Frontend-Developer agent]  
Output: src/frontend/auth/

# Terminal 3: Mobile (if needed)
You: "Build iOS login screen based on coordination/ui-designs.md mobile section"
Claude: [Spawns Mobile-Developer agent]
Output: src/ios/auth/

# Terminal 4: Database
You: "Set up the user database schema from coordination/plan.md section 4.1"
Claude: [Spawns Backend-Developer agent with DB focus]
Output: src/database/migrations/
```

### Phase 3: Integration Check (Day 5)

```bash
# Integration coordinator (could be you or PM-Architecture)
You: "Review all the auth implementations and create integration tasks"
Claude: [Reviews files and creates coordination/integration-tasks.md]

# Fix integration issues
You: "Backend developer, update the API to match the frontend's expected format"
Claude: [Spawns Backend-Developer to fix specific issues]
```

### Phase 4: DevOps & Testing Setup (Day 6)

```bash
# Only if DevOps not set up
You: "Set up CI/CD pipeline for our auth feature"
Claude: [Spawns DevOps-SRE agent]
Output: .github/workflows/auth-ci.yml

# QA Test Planning
You: "Create comprehensive test plan for authentication feature"
Claude: [Spawns QA-Test-Engineer agent]
Output: tests/auth/test-plan.md
```

### Phase 5: Testing & Bug Fixes (Day 7-8)

```bash
# QA Testing
You: "Execute the test plan and document issues found"
Claude: [Spawns QA-Test-Engineer agent]
Output: coordination/qa-issues-sprint1.md

# Bug Fix Assignments (You coordinate)
You read QA issues and assign:
- "Fix the login timeout issue (#3) in the backend"
- "Fix the UI alignment issue (#5) on mobile"
- Each fix spawns appropriate agent
```

### Phase 6: Review & Ship (Day 9)

```bash
# Final review checklist
You: "QA engineer, verify all issues are fixed"
Claude: [Spawns QA-Test-Engineer for verification]

# Security review
You: "Security engineer, review the auth implementation"
Claude: [Spawns Security-Engineer agent]

# Ship decision (YOU make this)
You: Review all feedback → Decide ship or iterate
```

## Key Optimizations for Agent Flow

### 1. **Batch Similar Tasks**
Instead of: "Build login", "Build logout", "Build password reset"
Do: "Build complete authentication system with login, logout, and password reset"

### 2. **Pre-Integration Planning**
```bash
# Before parallel development starts
You: "PM-Architecture, define all API contracts and interfaces"
Output: coordination/interfaces/auth-api.yaml

# Share with all agents to prevent integration issues
```

### 3. **Continuous Documentation**
Each agent should update:
- `coordination/decisions/` - Why choices were made
- `coordination/progress/` - What's complete
- `coordination/blockers/` - What's blocking progress

### 4. **Smart Checkpoints**
Create checkpoints where you review before proceeding:
- After planning (before development)
- After first integration (before full testing)  
- After QA round 1 (before shipping)

### 5. **Parallel QA**
Don't wait until the end:
```bash
# While Backend-Developer works on API
You: "QA-Test-Engineer, write API tests for the auth endpoints in coordination/plan.md"

# Tests ready when development completes
```

## Coordination Commands Cheat Sheet

### Starting a Feature
```bash
# 1. Always start with planning
"PM-Architecture agent, create a plan for [feature] based on PRD section X"

# 2. Then design (if UI involved)
"UI/UX agent, design the interface for [feature] based on the plan"

# 3. Then parallel development
"Backend agent, implement API for [feature]"
"Frontend agent, implement UI for [feature]"
"QA agent, write tests for [feature]"
```

### Daily Coordination
```bash
# Morning: Check status
"Read all files in coordination/progress/ and summarize status"

# Identify blockers
"What dependencies are blocking progress based on coordination/blockers/?"

# Assign next tasks
"[Agent], continue with [specific task] now that [dependency] is complete"
```

### Integration Points
```bash
# Before integration
"Review these implementations and identify integration issues:
- src/api/auth/
- src/frontend/auth/
- src/ios/auth/"

# Fix integration
"[Agent], update your implementation to match the interface defined in coordination/interfaces/"
```

## The Key Insight

The most efficient agent workflow is **NOT** a direct translation of your human workflow. Instead:

1. **Front-load planning**: Spend more time on interfaces/contracts
2. **Maximize parallelism**: Run 3-5 agents simultaneously  
3. **Checkpoint frequently**: But batch reviews for efficiency
4. **Document everything**: Agents can't attend meetings, so write it down
5. **You orchestrate**: You're the conductor, agents are the orchestra

## Example: Building Auth Feature

```bash
# Day 1 Morning (30 minutes)
/orchestrate "Build authentication system from PRD section 3"
→ PM-Architecture creates plan
→ You review and approve

# Day 1 Afternoon (2 hours)
Terminal 1: "Backend agent, build auth API per coordination/auth-plan.md"
Terminal 2: "Frontend agent, build login UI per coordination/auth-plan.md"  
Terminal 3: "QA agent, write auth tests per coordination/auth-plan.md"

# Day 2 Morning (1 hour)
"Review all auth implementations and create integration punch list"
→ Fix integration issues in parallel

# Day 2 Afternoon (2 hours)
"QA agent, run all auth tests and report issues"
→ Fix bugs in parallel

# Day 3 Morning (30 minutes)
Final review → Ship ✓
```

Total: 2.5 days vs 5-7 days traditional