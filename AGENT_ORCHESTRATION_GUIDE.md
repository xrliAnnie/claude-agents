# Multi-Agent Orchestration Guide for Claude Code

## Overview

Based on best practices from Anthropic's multi-agent research system and real-world usage patterns, here's how to effectively orchestrate your team of specialized agents in Claude Code.

## Recommended Architecture: Orchestrator-Worker Pattern

### Why This Pattern Works
- **Parallel Processing**: 3-5 agents can work simultaneously, reducing development time by up to 90%
- **Separation of Concerns**: Each agent focuses on their expertise without overlap
- **Scalable Coordination**: The orchestrator manages complexity while workers execute specialized tasks
- **Token Efficiency**: Grouping related tasks reduces overall token usage compared to sequential execution

## Three Proven Orchestration Models

### 1. **PM-Driven Orchestration** (Recommended for Most Projects)

The PM-Architecture agent acts as your technical orchestrator:

```
User → PM-Architecture (Orchestrator)
         ├── UI/UX (Design specs)
         ├── Backend-Developer (API design)
         ├── Frontend-Developer (UI implementation)
         ├── QA-Test-Engineer (Test planning)
         └── DevOps-SRE (Infrastructure setup)
```

**Workflow:**
1. Start with PM-Architecture to analyze your PRD and create a comprehensive task list
2. PM-Architecture delegates specific tasks to specialized agents
3. Each agent works on their domain with clear boundaries
4. PM-Architecture synthesizes results and ensures integration

**Example Session:**
```bash
# Start with PM-Architecture
Task(description="Create development plan from PRD", 
     prompt="Analyze this PRD and create a comprehensive task list with technology recommendations", 
     subagent_type="PM-Architecture")

# PM-Architecture then delegates:
Task(description="Design user authentication flow", 
     prompt="Based on the requirements, design secure authentication with OAuth2 and biometrics", 
     subagent_type="Backend-Developer")
```

### 2. **Human-Led Orchestration** (Best for Learning & Control)

You act as the orchestrator, directly managing agents:

```
You (Orchestrator)
  ├── Data-Scientist (ML model design)
  ├── Data-Engineer (Pipeline setup)
  ├── Backend-Developer (API integration)
  └── Mobile-Developer (App implementation)
```

**Workflow:**
1. Create a `project-context.md` file with overall requirements
2. Open multiple terminal sessions (using tmux or multiple windows)
3. Use git worktrees for isolated branches per agent
4. Coordinate through a shared `coordination/` directory

**Setup Commands:**
```bash
# Create coordination directory
mkdir -p coordination/{specs,progress,decisions}

# Create git worktrees for parallel work
git worktree add -b feature/backend ../project-backend
git worktree add -b feature/frontend ../project-frontend
git worktree add -b feature/mobile ../project-mobile

# Start agents in separate sessions
# Session 1: Backend API
Task(description="Implement user service API", 
     prompt="Create RESTful API for user management per specs in coordination/specs/api.md", 
     subagent_type="Backend-Developer")

# Session 2: Mobile App
Task(description="Build iOS authentication flow", 
     prompt="Implement biometric authentication per coordination/specs/auth.md", 
     subagent_type="Mobile-Developer")
```

### 3. **The 3 Amigo Pattern** (Best for MVPs)

Three core agents collaborate on product development:

```
PM-Architecture → UI/UX → Frontend-Developer
      ↓              ↓              ↓
  [Requirements] [Designs]    [Implementation]
      ↓              ↓              ↓
        Integrated MVP in hours
```

**This pattern is powerful because:**
- Each agent builds on the previous one's work
- Creates rich, multi-layered context
- Transforms from concept to working MVP rapidly

## Practical Implementation Guide

### 1. Project Setup

```bash
# Create project structure
mkdir -p .claude/{agents,commands,coordination}

# Copy your agents
cp ~/.claude/agents/*.md .claude/agents/

# Create orchestration command
cat > .claude/commands/orchestrate.md << 'EOF'
---
name: orchestrate
description: Orchestrate multiple agents for complex tasks
---

# Multi-Agent Orchestration

Analyze this task and create a plan for orchestrating multiple specialized agents:

1. Break down the task into specialized components
2. Identify which agents should handle each component
3. Define clear interfaces between agents
4. Create a coordination timeline
5. Specify how results will be integrated

Task: {task_description}

Output format:
- Orchestration plan with agent assignments
- Coordination timeline
- Integration points
- Success criteria
EOF
```

### 2. Coordination Infrastructure

Create a shared context file that all agents reference:

```markdown
# coordination/project-context.md

## Project Overview
[High-level description]

## Active Agents
- Backend-Developer: Working on API (branch: feature/api)
- Frontend-Developer: Building UI (branch: feature/ui)
- QA-Test-Engineer: Creating test suite (branch: feature/tests)

## Shared Interfaces
- API Contract: coordination/specs/api-v1.yaml
- Data Models: coordination/specs/models.json
- UI Components: coordination/specs/components.md

## Progress Tracking
- [ ] Authentication API (Backend-Developer)
- [ ] Login UI (Frontend-Developer)
- [ ] Auth test suite (QA-Test-Engineer)

## Decision Log
- 2024-01-15: Chose JWT for authentication
- 2024-01-16: Decided on React Native for mobile
```

### 3. Agent Communication Patterns

#### Asynchronous File-Based Communication
```bash
# Agent 1 writes specification
echo "API specification complete" > coordination/progress/backend.status
cp api-spec.yaml coordination/specs/

# Agent 2 reads and implements
cat coordination/specs/api-spec.yaml
echo "Frontend implementing API client" > coordination/progress/frontend.status
```

#### Synchronous Handoffs
```python
# In your orchestration script
def orchestrate_feature():
    # Step 1: Design
    design_result = Task(
        description="Design user profile feature",
        prompt="Create comprehensive design for user profiles",
        subagent_type="UI/UX"
    )
    
    # Step 2: Backend
    backend_result = Task(
        description="Implement profile API",
        prompt=f"Implement API based on design: {design_result}",
        subagent_type="Backend-Developer"
    )
    
    # Step 3: Frontend
    frontend_result = Task(
        description="Build profile UI",
        prompt=f"Build UI for design: {design_result} using API: {backend_result}",
        subagent_type="Frontend-Developer"
    )
```

### 4. Managing Token Usage

**Token Optimization Strategies:**
- Group related tasks together
- Use explicit, detailed instructions to prevent redundant work
- Share context through files rather than repeating in prompts
- Monitor token usage: agents use ~4x more than chat, multi-agent ~15x

**Example of Efficient Delegation:**
```python
# Inefficient: Vague instructions lead to duplicate work
Task(prompt="Build authentication")  # ❌

# Efficient: Clear boundaries and specific outputs
Task(
    prompt="""Build JWT authentication service:
    - Input: coordination/specs/auth-requirements.md
    - Output: src/services/auth.js with login(), logout(), refresh()
    - Use existing User model from src/models/user.js
    - Write tests in src/services/auth.test.js
    - Document API in coordination/specs/auth-api.md
    """,
    subagent_type="Backend-Developer"
)  # ✅
```

## Advanced Patterns

### 1. Parallel Exploration
Use multiple agents to explore different solutions:

```python
# Explore three different ML approaches simultaneously
approaches = ["neural-network", "gradient-boosting", "ensemble"]
results = []

for approach in approaches:
    result = Task(
        description=f"Implement {approach} for churn prediction",
        prompt=f"Build and evaluate {approach} model using data in data/users.csv",
        subagent_type="Data-Scientist"
    )
    results.append(result)

# Main agent compares results
comparison = Task(
    description="Compare ML approaches",
    prompt=f"Compare these three approaches and recommend the best: {results}",
    subagent_type="Data-Scientist"
)
```

### 2. Progressive Enhancement
Start simple and iteratively improve:

```bash
# Phase 1: MVP
/spawn "Build basic CRUD API" --agent Backend-Developer

# Phase 2: Enhancement
/spawn "Add caching and optimization" --agent Backend-Developer --context "Enhance existing API at src/api/"

# Phase 3: Scale
/spawn "Add horizontal scaling" --agent DevOps-SRE --context "Scale API from previous phases"
```

### 3. Quality Gates
Integrate QA at each step:

```python
def develop_with_quality_gates(feature):
    # Development
    code = Task(prompt=f"Implement {feature}", subagent_type="Backend-Developer")
    
    # Immediate QA review
    review = Task(
        prompt=f"Review this code for quality and security: {code}",
        subagent_type="QA-Test-Engineer"
    )
    
    if "issues" in review:
        # Fix issues
        fixed_code = Task(
            prompt=f"Fix these issues in the code: {review['issues']}",
            subagent_type="Backend-Developer"
        )
```

## Choosing the Right Orchestration Model

### Use PM-Driven Orchestration When:
- You have a clear PRD or requirements document
- Building a new product from scratch
- Need comprehensive planning across multiple tech stacks
- Want to minimize your coordination overhead

### Use Human-Led Orchestration When:
- You need fine-grained control over the process
- Learning how different agents work together
- Dealing with sensitive or complex business logic
- Integrating with existing systems

### Use The 3 Amigo Pattern When:
- Building MVPs or prototypes rapidly
- Need quick iteration cycles
- Working on user-facing features
- Want natural handoffs between design and implementation

## Common Pitfalls to Avoid

1. **Over-Orchestration**: Don't create agents for every tiny task
2. **Under-Specification**: Vague instructions lead to duplicate work
3. **Missing Context**: Always provide shared context files
4. **Token Waste**: Group related tasks to reduce overhead
5. **No Integration Plan**: Define how agent outputs will merge

## Monitoring and Optimization

Track your multi-agent system performance:

```bash
# Create monitoring script
cat > monitor-agents.sh << 'EOF'
#!/bin/bash
echo "=== Agent Activity Monitor ==="
echo "Active branches:"
git worktree list

echo -e "\nCoordination status:"
ls -la coordination/progress/

echo -e "\nRecent specs:"
ls -lt coordination/specs/ | head -5

echo -e "\nToken usage estimate:"
# Add your token tracking logic here
EOF

chmod +x monitor-agents.sh
```

## Getting Started Checklist

- [ ] Set up coordination directory structure
- [ ] Create project-context.md with initial requirements
- [ ] Copy agents to project `.claude/agents/`
- [ ] Decide on orchestration model (PM-driven recommended)
- [ ] Create initial task breakdown
- [ ] Set up git worktrees if using parallel development
- [ ] Define shared interfaces and specifications
- [ ] Start with 2-3 agents initially, scale up as needed
- [ ] Monitor token usage and optimize as necessary
- [ ] Document decisions in coordination/decisions/

Remember: Start simple, measure results, and scale up your orchestration complexity as you gain experience with the system.