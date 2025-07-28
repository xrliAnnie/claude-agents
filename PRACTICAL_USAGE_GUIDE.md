# Practical Usage Guide: How to Actually Use the Orchestration Framework

This guide explains exactly how to use the orchestration framework in your daily Claude Code workflow.

## The Key Concept: Status Files Drive Everything

The entire framework operates on a **pull model** where agents monitor status files and act when it's their turn. You don't manually coordinate agents - the status files do it for you.

## Step-by-Step Usage Flow

### 1. Starting a New Project

```bash
# In Claude Code, you say:
"I want to start a new e-commerce project. Use the Orchestrator agent to initialize the orchestration framework."

# The Orchestrator will:
1. Create the directory structure (odyssey/, coordination/)
2. Initialize odyssey/status/phase-status.md
3. Set Phase 1 status to "In Progress"
4. Tell you to create your PRD in docs/PRD.md
```

### 2. Phase 1: Creating the PRD and Milestone Plan

```bash
# First, create your PRD
"Create a PRD for an e-commerce platform with user auth, product catalog, and checkout"
# Save it to docs/PRD.md

# Then, activate Product-Manager
"Product-Manager, check odyssey/status/phase-status.md and begin your work"

# Product-Manager will:
1. See Phase 1 is "In Progress" and they're the owner
2. Read docs/PRD.md
3. Create odyssey/milestone-plan.md
4. Create milestone details in odyssey/milestones/
5. Update checkboxes in phase-status.md
6. Mark Phase 1 as complete when done
```

### 3. Phase 2: Design Creation and Review

```bash
# Check phase status
"Show me odyssey/status/phase-status.md"
# You'll see Phase 1 is complete, Phase 2 is ready

# Activate UX-Designer
"UX-Designer, check the phase status and begin your work"

# UX-Designer will:
1. See Phase 2 is "In Progress"
2. Read PRD and milestone plan
3. Create designs in odyssey/design/
4. Update their checkboxes

# Then activate all engineers for review
"Backend-Developer, Frontend-Developer, Mobile-Developer - check phase status for your review tasks"

# Each engineer will:
1. See they have design review tasks
2. Review the designs
3. Add feedback to odyssey/reviews/design-review.md
4. Check their review checkbox
```

### 4. Phase 3: Technical Architecture

```bash
# Similar pattern - engineers see Phase 3 is ready
"All engineers, check phase status and create your architecture documents"

# Each engineer creates their architecture
# Then cross-reviews happen
# Bar-Raiser and Security-Engineer review everything
```

### 5. Phase 4: Milestone Setup

```bash
"Orchestrator, check phase status and set up milestone 1"

# Orchestrator will:
1. Create coordination/milestone-1/ structure
2. Initialize milestone-1/status.md
3. Copy relevant info from odyssey/
```

### 6. Phase 5: Implementation Loop

```bash
# Check milestone status
"Show me coordination/milestone-1/status.md"

# Activate agents for planning
"Product-Manager and UX-Designer, check milestone 1 status for your tasks"

# For technical design
"All engineers, check milestone 1 status for technical design tasks"

# For implementation
"Backend-Developer, check milestone status and implement your services"
"Frontend-Developer, check milestone status and implement the UI"

# For PR reviews
"All engineers and Bar-Raiser, check milestone status for PR reviews"

# For QA
"QA-Engineer, check milestone status for testing tasks"
```

## The Magic: Agents Know What To Do

Each agent has been updated to:
1. **Monitor status files** - They check odyssey/status/phase-status.md and coordination/milestone-X/status.md
2. **Act when ready** - They see unchecked boxes for their tasks and begin work
3. **Update status** - They check boxes as they complete tasks
4. **Enable others** - Their updates signal other agents it's their turn

## Practical Example Session

```bash
# Monday Morning - Start Project
You: "Orchestrator, initialize framework for my SaaS project"
You: "Create a PRD for a team collaboration SaaS platform" 
You: "Save that to docs/PRD.md"
You: "Product-Manager, check phase status and begin work"

# Product-Manager works autonomously, creates milestone plan

# Tuesday - Design Phase
You: "Show me odyssey/status/phase-status.md"
# See Phase 1 complete, Phase 2 ready
You: "UX-Designer, check phase status and create designs"

# Wednesday - Design Reviews
You: "All engineers, check phase status for your tasks"
# Engineers review designs in parallel

# Thursday - Architecture
You: "All engineers, check phase status and create architectures"

# Friday - Start Implementation
You: "Orchestrator, check phase status and set up milestone 1"
You: "Show me coordination/milestone-1/status.md"
You: "All agents, check milestone 1 status and begin your assigned tasks"
```

## Key Commands to Remember

### Status Checking
```bash
# Check overall project phase
"Show me odyssey/status/phase-status.md"

# Check specific milestone
"Show me coordination/milestone-1/status.md"

# Ask Orchestrator to check status
"Orchestrator, what's the current project status?"
```

### Activating Agents
```bash
# Single agent
"[Agent-Name], check status files and begin your work"

# Multiple agents
"All engineers, check status files for your tasks"

# Specific phase/milestone
"Backend-Developer, check milestone 1 status for implementation tasks"
```

### Progress Updates
```bash
# See what's been done
"Show me the progress in coordination/milestone-1/progress/"

# Check blockers
"Are there any blockers in the current milestone?"
```

## Why This Works

1. **No Manual Coordination** - Status files coordinate everything
2. **Parallel Work** - Multiple agents work simultaneously
3. **Clear Dependencies** - Checkboxes show what's blocking what
4. **Progress Visibility** - Always know where the project stands
5. **Quality Gates** - Reviews happen automatically at the right time

## Common Patterns

### Morning Routine
```bash
1. "Show me odyssey/status/phase-status.md"
2. "Show me coordination/milestone-X/status.md" 
3. "All agents with pending tasks, check status and continue work"
```

### Starting New Work
```bash
1. Check what phase/milestone you're in
2. Activate relevant agents
3. Let them work based on status files
4. Check progress later
```

### Handling Blockers
```bash
1. "Show me current blockers"
2. Resolve the blocker
3. Update status file
4. "Blocked agent, check status again"
```

## Remember

- **Trust the process** - Let status files drive the work
- **Don't micromanage** - Agents know what to do
- **Check status regularly** - But don't need to coordinate manually
- **Let agents update status** - They'll check boxes as they work

The framework turns your multi-agent project into a self-organizing system where work flows naturally from phase to phase and agent to agent!