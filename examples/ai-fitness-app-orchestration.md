# Example: AI Fitness App Multi-Agent Orchestration

This example demonstrates how to use the PM-Architecture agent to orchestrate building an AI-powered fitness app.

## Project Overview

**Product**: AI-powered fitness app with personalized workout plans, real-time form correction, and nutrition tracking.

## Step 1: Initial Planning with PM-Architecture

```bash
# Create project structure
mkdir -p ai-fitness-app/{coordination,docs,src}
cd ai-fitness-app

# Create initial PRD
cat > docs/PRD.md << 'EOF'
# AI Fitness App PRD

## Vision
Create a mobile fitness app that uses AI to provide personalized workout plans, real-time form correction via camera, and nutrition tracking.

## Core Features
1. User onboarding with fitness assessment
2. AI-generated personalized workout plans
3. Real-time form correction using device camera
4. Nutrition tracking with meal photo analysis
5. Progress tracking and analytics
6. Social features for accountability

## Target Platforms
- iOS (primary)
- Android (secondary)
- Apple Watch companion app

## Success Metrics
- User retention: 60% at 30 days
- Workout completion rate: 70%
- Daily active users: 40%
EOF

# Start with PM-Architecture to create comprehensive plan
```

### Claude Code Command:
```
Task(
    description="Create comprehensive development plan for AI fitness app",
    prompt="Analyze the PRD at docs/PRD.md and create a detailed task list with technology recommendations. Focus on mobile-first architecture with AI/ML integration.",
    subagent_type="PM-Architecture"
)
```

## Step 2: Parallel Agent Execution

Based on PM-Architecture's plan, orchestrate specialized agents:

### 2.1 AI/ML Development Track

```bash
# Terminal 1: Data Science
Task(
    description="Design ML models for fitness app",
    prompt="""Design and prototype ML models for:
    1. Workout plan personalization (user fitness level, goals, preferences)
    2. Real-time form analysis using device camera
    3. Nutrition analysis from food photos
    Output models architecture to coordination/ml-architecture.md""",
    subagent_type="Data-Scientist"
)

# Terminal 2: Data Engineering
Task(
    description="Design data pipeline for fitness app",
    prompt="""Design data pipeline for:
    1. User activity data collection and storage
    2. ML model training pipeline
    3. Real-time inference infrastructure
    Reference ML architecture at coordination/ml-architecture.md
    Output to coordination/data-pipeline.md""",
    subagent_type="Data-Engineer"
)
```

### 2.2 Mobile Development Track

```bash
# Terminal 3: Mobile Development
Task(
    description="Architect iOS fitness app",
    prompt="""Create iOS app architecture for AI fitness app:
    1. Camera integration for form analysis
    2. HealthKit integration
    3. Offline-first data sync
    4. Real-time ML inference
    Reference coordination/ml-architecture.md
    Output to src/ios/architecture.md""",
    subagent_type="Mobile-Developer"
)

# Terminal 4: UI/UX Design
Task(
    description="Design fitness app UI/UX",
    prompt="""Design user interface for:
    1. Onboarding flow with fitness assessment
    2. Workout screens with real-time feedback
    3. Progress tracking dashboards
    4. Social features
    Follow iOS HIG, output to coordination/ui-design.md""",
    subagent_type="UI/UX"
)
```

### 2.3 Backend Infrastructure Track

```bash
# Terminal 5: Backend Development
Task(
    description="Design backend API for fitness app",
    prompt="""Design RESTful API and GraphQL schema for:
    1. User management and authentication
    2. Workout plan CRUD operations
    3. ML model serving endpoints
    4. Social features (following, challenges)
    Reference coordination/data-pipeline.md
    Output to coordination/api-spec.yaml""",
    subagent_type="Backend-Developer"
)

# Terminal 6: DevOps/Infrastructure
Task(
    description="Design cloud infrastructure",
    prompt="""Design scalable infrastructure for:
    1. API servers with auto-scaling
    2. ML model serving (consider TensorFlow Serving)
    3. Media storage for workout videos
    4. Real-time video processing pipeline
    Target 100K MAU, output to coordination/infrastructure.md""",
    subagent_type="DevOps-SRE"
)
```

## Step 3: Integration Phase

After initial parallel work, bring agents together:

```bash
# Integration Coordination
Task(
    description="Integrate ML models with mobile app",
    prompt="""Review outputs from all agents and create integration plan:
    - coordination/ml-architecture.md
    - coordination/data-pipeline.md
    - src/ios/architecture.md
    - coordination/api-spec.yaml
    Identify integration points and potential issues.
    Create integration checklist at coordination/integration-plan.md""",
    subagent_type="PM-Architecture"
)
```

## Step 4: Quality Assurance

```bash
# Comprehensive QA Planning
Task(
    description="Create test strategy for AI fitness app",
    prompt="""Create comprehensive test plan covering:
    1. ML model accuracy testing
    2. Mobile app performance testing
    3. API load testing
    4. Camera/form detection accuracy
    5. Cross-device compatibility
    Reference all coordination/*.md files
    Output to coordination/qa-strategy.md""",
    subagent_type="QA-Test-Engineer"
)

# Security Review
Task(
    description="Security audit for fitness app",
    prompt="""Review architecture for security issues:
    1. User data privacy (health data, photos)
    2. API authentication and authorization
    3. ML model security (adversarial inputs)
    4. HIPAA compliance considerations
    Review all coordination/*.md files
    Output to coordination/security-review.md""",
    subagent_type="Security-Engineer"
)
```

## Coordination Files Structure

```
ai-fitness-app/
├── coordination/
│   ├── ml-architecture.md      # Data-Scientist output
│   ├── data-pipeline.md        # Data-Engineer output
│   ├── ui-design.md           # UI/UX output
│   ├── api-spec.yaml          # Backend-Developer output
│   ├── infrastructure.md      # DevOps-SRE output
│   ├── integration-plan.md    # PM-Architecture synthesis
│   ├── qa-strategy.md         # QA-Test-Engineer output
│   └── security-review.md     # Security-Engineer output
├── docs/
│   ├── PRD.md                 # Initial requirements
│   └── plan.md                # PM-Architecture task list
└── src/
    ├── ios/
    │   └── architecture.md    # Mobile-Developer output
    └── backend/
        └── (implementation files)
```

## Monitoring Progress

Create a simple dashboard to track agent progress:

```bash
# Create progress tracker
cat > coordination/progress.md << 'EOF'
# AI Fitness App Development Progress

## Phase 1: Architecture & Design (Days 1-3)
- [x] PM-Architecture: Task breakdown and tech selection
- [x] Data-Scientist: ML model architecture
- [x] UI/UX: Initial designs
- [ ] Mobile-Developer: iOS architecture
- [ ] Backend-Developer: API design
- [ ] DevOps-SRE: Infrastructure plan

## Phase 2: Implementation (Days 4-10)
- [ ] Data-Engineer: Build data pipeline
- [ ] Mobile-Developer: Core app features
- [ ] Backend-Developer: API implementation
- [ ] Frontend-Developer: Admin dashboard

## Phase 3: Integration (Days 11-13)
- [ ] Integration testing
- [ ] ML model integration
- [ ] Performance optimization

## Phase 4: QA & Launch Prep (Days 14-15)
- [ ] QA-Test-Engineer: Full test suite
- [ ] Security-Engineer: Security audit
- [ ] DevOps-SRE: Production deployment
EOF

# Update progress as agents complete tasks
```

## Lessons from This Example

1. **Start with PM-Architecture**: It provides the roadmap and technology decisions
2. **Parallel Tracks**: ML, Mobile, and Backend can progress simultaneously
3. **Coordination Points**: Regular sync through shared files prevents divergence
4. **Integration Planning**: Explicitly plan how components will connect
5. **Quality Gates**: Security and QA reviews before moving to next phase

## Scaling This Approach

For larger projects, you could:
- Add more specialized agents (e.g., `Performance-Engineer` for optimization)
- Create sub-orchestrators for each track (ML, Mobile, Backend)
- Use automated scripts to monitor coordination files
- Implement ChatOps for agent communication
- Set up CI/CD to automatically test integration points

This example demonstrates how PM-Architecture serves as an effective orchestrator, breaking down complex projects into manageable pieces that specialized agents can tackle in parallel.