# Versioning and Agent Self-Update Example

This example demonstrates the new versioning system and agent self-update workflow.

## Initial Setup

Your project structure after Orchestrator setup:
```
project/
├── docs/
│   ├── PRD.md              # Product Requirements
│   ├── TDD.md              # Technical Design Doc
│   └── ARCHITECTURE.md     # Architecture Overview
├── coordination/
│   ├── specs/
│   │   └── Backend-Developer/
│   ├── implementations/
│   │   └── Backend-Developer/
│   └── progress/
│       └── Backend-Developer.md
├── api/                    # Backend code directory
└── .claude/
    └── agents/
        └── Backend-Developer.md
```

## Agent File After Creation

The Orchestrator reads from `docs/` and creates:

`.claude/agents/Backend-Developer.md`:
```markdown
[Original agent content...]

## Project-Specific Context

This agent is configured for this specific project.

### Project Context

### Product Requirements (PRD)
# E-commerce Platform
- Multi-vendor marketplace
- Real-time inventory
- Stripe payments
- Social login

### Technical Design
- Microservices architecture
- PostgreSQL + Redis
- JWT authentication
- Event-driven updates

### Project-Specific Knowledge
*This section will be updated by the agent at important milestones*

### Agent Responsibilities
- Implement features in `api/`
- Maintain specs in `coordination/specs/Backend-Developer/`
...
```

## Workflow Example: Building Authentication

### Step 1: Create Initial Spec

Backend-Developer creates `coordination/specs/Backend-Developer/v1.0-auth.md`:
```markdown
# Authentication API Spec v1.0

## Overview
JWT-based authentication with social login support.

## Endpoints
- POST /api/v1/auth/register
- POST /api/v1/auth/login
- POST /api/v1/auth/logout
- GET /api/v1/auth/me

## Token Format
- Access token: 15 minutes
- Refresh token: 7 days
...
```

### Step 2: Implement and Document

After implementation, creates `coordination/implementations/Backend-Developer/v1.0-auth.md`:
```markdown
# Authentication Implementation v1.0

## Architecture Decisions
- JWT tokens stored in httpOnly cookies
- Refresh tokens in Redis with user:refresh:{userId} key
- Bcrypt with 10 rounds for passwords

## Key Files
- `api/routes/auth.js` - Route handlers
- `api/middleware/auth.js` - JWT verification
- `api/models/User.js` - User model with password hashing

## Integration Points
- Frontend: Expects tokens in cookies
- Mobile: Sends tokens in Authorization header
```

### Step 3: Update Agent File at Milestone

Backend-Developer updates `.claude/agents/Backend-Developer.md`:
```markdown
### Project-Specific Knowledge
*Updated: 2024-01-20*

#### Authentication Architecture
- JWT in httpOnly cookies (web) and Authorization header (mobile)
- Refresh tokens in Redis (7 day expiry)
- Social login via Passport.js (Google, Facebook)
- Rate limiting: 5 login attempts per 15 minutes

#### Key APIs
- `/api/v1/auth/*` - Authentication endpoints (v1.0)
- Token format: `{userId, email, role, iat, exp}`

#### Business Rules
- Email verification required for registration
- Admins must use 2FA
- Password minimum 8 chars with complexity requirements
```

### Step 4: Version Update After Frontend Feedback

Frontend needs user profile in login response. Backend creates `v1.1-auth.md`:

`coordination/specs/Backend-Developer/v1.1-auth.md`:
```markdown
# Authentication API Spec v1.1

## Changes from v1.0
- Login response now includes user profile object
- Added PUT /api/v1/auth/profile endpoint

## Updated Login Response
```json
{
  "success": true,
  "user": {
    "id": "123",
    "email": "user@example.com",
    "name": "John Doe",
    "avatar": "https://..."
  }
}
```
```

## Benefits of This System

### 1. Automatic File Sorting
```
ls coordination/specs/Backend-Developer/
v1.0-auth.md
v1.0-products.md
v1.1-auth.md
v1.2-auth.md
v2.0-auth.md
```
Files naturally sort in version order!

### 2. Agent Memory Across Sessions
The agent file contains critical project knowledge:
- Architecture decisions
- Business rules
- Integration patterns
- Key constraints

### 3. Seed Document Integration
Orchestrator automatically includes:
- PRD from `docs/PRD.md`
- Technical design from `docs/TDD.md`
- Architecture from `docs/ARCHITECTURE.md`

### 4. Clear Version Tracking
```
Frontend: "I'm using auth API v1.1"
Backend: "I need to update to v1.2 for the new feature"
QA: "Testing against auth v1.2"
```

## When Agents Self-Update

Agents should update their file when:
- ✅ Completing a major feature (auth system done)
- ✅ Making architectural decisions (chose Redis for sessions)
- ✅ Discovering business rules (passwords need complexity)
- ✅ Creating integration points (cookie vs header tokens)
- ❌ NOT for minor bug fixes
- ❌ NOT for temporary workarounds

This creates a living knowledge base that grows with your project!