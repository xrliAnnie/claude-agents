# Simple Example: Building Authentication with Agents

Let me show you exactly how to use agents in Claude Code with a real example.

## Starting the Project

### Step 1: Initial Planning

**What you type in Claude Code:**
```
I need to build an authentication system with email/password login, JWT tokens, and 
password reset. We'll use Node.js backend and React frontend. 

Use the PM-Architecture agent to create a detailed plan.
```

**What Claude does:**
```
I'll use the PM-Architecture agent to create a comprehensive plan for your authentication system.

[Claude automatically runs: Task(description="Plan auth system", prompt="...", subagent_type="PM-Architecture")]
```

**Agent returns:** A detailed plan saved to `coordination/auth-plan.md`

### Step 2: UI Design

**What you type:**
```
Now use the UI/UX agent to design the login and password reset screens based on the plan.
```

**What Claude does:**
```
I'll have the UI/UX agent create the design for your authentication screens.

[Spawns UI/UX agent]
```

**Agent returns:** Designs in `coordination/auth-ui-design.md`

### Step 3: Parallel Development

**Open Terminal Tab 1:**
```
Build the backend authentication API based on coordination/auth-plan.md sections 3-5. 
Include login, logout, and password reset endpoints.
```

**Claude:** [Spawns Backend-Developer agent who builds the API]

**Open Terminal Tab 2:**
```
Build the React login components based on coordination/auth-ui-design.md.
Include form validation and error handling.
```

**Claude:** [Spawns Frontend-Developer agent who builds the UI]

**Open Terminal Tab 3:**
```
Write comprehensive tests for the auth system based on coordination/auth-plan.md section 8.
```

**Claude:** [Spawns QA-Test-Engineer agent who writes tests]

### Step 4: Integration

**After agents complete, you type:**
```
The backend and frontend are done. Can you review both implementations and tell me 
if there are any integration issues?
```

**Claude reviews and might say:**
```
I found a few integration issues:
1. The backend expects 'email' but frontend sends 'username'
2. The error format is different between backend and frontend
3. The JWT token is in a different header than expected

Let me fix these issues.
```

### Step 5: Testing

**What you type:**
```
Run the authentication tests and let me know if there are any failures.
```

**Claude:** [Runs tests and reports results]

## The Key Points

### 1. You Don't Need Special Syntax
Just ask naturally:
- ✅ "Use the Backend-Developer agent to build..."
- ✅ "Have the QA agent test..."
- ✅ "Get the PM-Architecture agent to plan..."

### 2. Agents Work Independently
Each agent:
- Runs in its own context
- Can't see what other agents are doing
- Saves output to files for coordination

### 3. You Orchestrate
You decide:
- When to start each agent
- What files they should read
- When to move to the next phase
- How to resolve conflicts

### 4. Use Multiple Terminal Tabs
For parallel work:
- Tab 1: Backend work
- Tab 2: Frontend work  
- Tab 3: Testing work
- Tab 4: Coordination/review

## Quick Start Template

```bash
# 1. Project setup
mkdir my-project
cd my-project
mkdir -p coordination/{specs,progress,decisions}

# 2. Initial planning (Main tab)
"Create a plan for [your feature] using the PM-Architecture agent"

# 3. Parallel development (Multiple tabs)
Tab 1: "Backend-Developer agent, build [backend part]"
Tab 2: "Frontend-Developer agent, build [frontend part]"
Tab 3: "QA-Test-Engineer agent, write tests for [feature]"

# 4. Integration (Main tab)
"Review all implementations and identify integration issues"

# 5. Testing (Main tab)
"QA agent, run all tests and report results"

# 6. Ship it!
```

## Common Patterns

### Pattern 1: Design-First
```
PM-Architecture → UI/UX → Backend + Frontend in parallel → QA
```

### Pattern 2: API-First  
```
PM-Architecture → Backend (API design) → Frontend + Mobile in parallel → QA
```

### Pattern 3: Test-Driven
```
PM-Architecture → QA (write tests) → Backend + Frontend (implement to pass tests)
```

## What Success Looks Like

After running agents, you'll have:
```
my-project/
├── coordination/
│   ├── auth-plan.md         # PM-Architecture output
│   ├── auth-ui-design.md    # UI/UX output  
│   ├── auth-api-spec.yaml   # Backend-Developer output
│   ├── integration-notes.md # Your coordination notes
│   └── test-results.md      # QA-Test-Engineer output
├── backend/
│   ├── routes/auth.js       # Backend code
│   └── tests/auth.test.js   # Backend tests
├── frontend/
│   ├── components/Login.jsx # Frontend code
│   └── tests/Login.test.js  # Frontend tests
└── README.md               # Project documentation
```

## Tips

1. **Start Small**: Try 2 agents first, then scale up
2. **Be Specific**: "Build login API" > "Build authentication"
3. **Reference Files**: Always tell agents which files to read
4. **Check Progress**: Regularly review coordination/ folder
5. **Batch Related Work**: One agent can do multiple related tasks

The key is: You're having a conversation with Claude, who then manages specialized agents for you. No special syntax needed!