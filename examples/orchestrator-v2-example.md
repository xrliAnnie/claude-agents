# Orchestrator v2 Example - E-commerce Project

This example shows the new Orchestrator workflow with versioned specs and project-specific agents.

## Step 1: Initial Project Setup

**You type:**
```
I'm starting a new e-commerce project. Use the Orchestrator agent to set up the project.
```

**Orchestrator runs the setup script interactively:**

```
=== Orchestrator Setup Script v2.0 ===

Available Agents:
1. PM-Architecture - Project planning and task breakdown
2. PM-PRD - Product requirements documentation
3. UI-UX - Design and user experience
4. Backend-Developer - Server-side development
5. Frontend-Developer - Web UI development
6. Mobile-Developer - iOS/Android development
7. Data-Engineer - Data pipelines and analytics
8. Data-Scientist - ML models and analysis
9. DevOps-SRE - Infrastructure and deployment
10. QA-Test-Engineer - Testing and quality assurance
11. Security-Engineer - Security and compliance

Which agents would you like to include? (Enter numbers separated by commas)
Example: 1,3,4,5,10
> 1,3,4,5,6,10

Selected agents: PM-Architecture UI-UX Backend-Developer Frontend-Developer Mobile-Developer QA-Test-Engineer

Configure code directories:
Backend-Developer directory [default: backend]: api
Frontend-Developer directory [default: frontend]: web
Mobile-Developer directory [default: mobile]: mobile-app
```

**Result:**
```
project/
├── coordination/
│   ├── specs/
│   │   ├── PM-Architecture/
│   │   ├── UI-UX/
│   │   ├── Backend-Developer/
│   │   ├── Frontend-Developer/
│   │   ├── Mobile-Developer/
│   │   └── QA-Test-Engineer/
│   ├── implementations/
│   │   └── [same structure as specs]
│   ├── progress/
│   │   ├── PM-Architecture.md
│   │   ├── UI-UX.md
│   │   └── [etc...]
│   └── README.md
├── api/                    # Backend code
├── web/                    # Frontend code
├── mobile-app/             # Mobile code
├── .claude/
│   └── agents/             # Project-specific agents
└── docs/
```

## Step 2: Add PRD and Let Agents Read It

**You add your PRD:**
```
docs/PRD.md:
# E-commerce Platform PRD

## Overview
Build a modern e-commerce platform with:
- User authentication (social login)
- Product catalog with search
- Shopping cart and checkout
- Order management
- Admin dashboard

## Tech Stack
- Backend: Node.js, PostgreSQL
- Frontend: React, TypeScript
- Mobile: React Native
```

## Step 3: PM-Architecture Creates Initial Plan

**You type:**
```
PM-Architecture agent, analyze the PRD and create initial feature specs.
```

**PM-Architecture creates:**
```
coordination/specs/PM-Architecture/project-plan-v1.0.md
coordination/specs/PM-Architecture/auth-feature-v1.0.md
coordination/specs/PM-Architecture/catalog-feature-v1.0.md
```

## Step 4: UI-UX Creates Design Specs

**You type:**
```
UI-UX agent, create design specs for the authentication feature based on 
coordination/specs/PM-Architecture/auth-feature-v1.0.md
```

**UI-UX creates:**
```
coordination/specs/UI-UX/auth-design-v1.0.md
coordination/implementations/UI-UX/auth-mockups-v1.0.md (with Figma links)
```

## Step 5: Backend Creates API Spec

**You type:**
```
Backend-Developer agent, create API spec for authentication based on:
- coordination/specs/PM-Architecture/auth-feature-v1.0.md
- coordination/specs/UI-UX/auth-design-v1.0.md
```

**Backend-Developer creates:**
```
coordination/specs/Backend-Developer/auth-api-v1.0.md:

# Authentication API Spec v1.0

## Endpoints

### POST /api/auth/register
Request:
```json
{
  "email": "string",
  "password": "string",
  "name": "string"
}
```

### POST /api/auth/login
...

## JWT Token Format
...
```

## Step 6: Parallel Implementation

**Terminal 1 - Backend:**
```
Backend-Developer agent, implement the auth API based on your spec v1.0.
Write code in api/ directory.
```

**Backend works and creates:**
- `api/routes/auth.js`
- `api/models/User.js`
- `coordination/implementations/Backend-Developer/auth-api-v1.0.md`

**Terminal 2 - Frontend:**
```
Frontend-Developer agent, implement login UI based on:
- coordination/specs/UI-UX/auth-design-v1.0.md
- coordination/specs/Backend-Developer/auth-api-v1.0.md
```

**Frontend creates:**
- `web/src/pages/Login.tsx`
- `web/src/components/AuthForm.tsx`
- `coordination/implementations/Frontend-Developer/auth-ui-v1.0.md`

## Step 7: API Changes Required

**Frontend discovers issue:**
```
Frontend updates: coordination/progress/Frontend-Developer.md

## Blocked
- Need API to return user profile data on login (not just token)
```

**Backend creates new version:**
```
coordination/specs/Backend-Developer/auth-api-v1.1.md:
- Added user profile in login response

Then implements changes and creates:
coordination/implementations/Backend-Developer/auth-api-v1.1.md
```

## Step 8: QA Creates Test Specs

**You type:**
```
QA-Test-Engineer agent, create test specs for auth feature v1.1
```

**QA creates:**
```
coordination/specs/QA-Test-Engineer/auth-tests-v1.1.md
coordination/implementations/QA-Test-Engineer/auth-test-results-v1.1.md
```

## Step 9: Adding New Agent Mid-Project

**Two weeks later, you need ML features:**
```
Use the Orchestrator to add a Data-Scientist agent to our project.
```

**Orchestrator runs add-agent.sh:**
```
Available Agents:
1. PM-Architecture [Already added]
2. PM-PRD
3. UI-UX [Already added]
...
8. Data-Scientist - ML models and analysis
...

Which agent would you like to add? > 8
```

**Creates:**
- `.claude/agents/Data-Scientist.md` (with project context from PRD)
- `coordination/specs/Data-Scientist/`
- `coordination/implementations/Data-Scientist/`
- `coordination/progress/Data-Scientist.md`

## Key Benefits of New Structure

### 1. Clear Versioning
```
Backend creates: auth-api-v1.0.md
Frontend uses: auth-api-v1.0.md
Backend updates: auth-api-v1.1.md
Frontend updates to use: auth-api-v1.1.md
```

### 2. Agent-Named Directories
Easy to reference:
- `coordination/specs/Backend-Developer/`
- `coordination/specs/Frontend-Developer/`

### 3. Project-Specific Agents
Each agent knows:
- The project context (from PRD)
- Their specific directories
- Their git commit prefix
- The versioning convention

### 4. Clean Git History
```
git log --oneline:
backend: implement auth API v1.0
frontend: add login UI v1.0
backend: update auth API to v1.1
frontend: update for API v1.1
qa: add auth tests v1.1
```

### 5. Easy Progress Tracking
```
cat coordination/progress/*.md | grep -A5 "Current Sprint"
```

## Tips for Success

1. **Always version specs**: Start with v1.0, increment thoughtfully
2. **Match versions**: Implementation v1.1 must match spec v1.1
3. **Design first**: Create spec before writing code
4. **Update progress**: Keep progress files current
5. **Use blockers**: Flag issues immediately in progress files

The new Orchestrator makes multi-agent development more structured and manageable!