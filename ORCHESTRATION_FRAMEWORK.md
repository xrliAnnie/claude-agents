# Multi-Agent Orchestration Framework

## Overview

This framework defines a comprehensive orchestration system for complex software projects using multiple specialized agents. The system follows a phased approach with milestone-based development, ensuring quality through multiple review cycles and clear ownership boundaries.

## Core Principles

1. **Phase-Based Development**: Projects progress through distinct phases with clear completion criteria
2. **Milestone-Driven**: Large projects broken into manageable milestones
3. **Multi-Agent Collaboration**: Specialized agents work together with defined interfaces
4. **Review-First Culture**: Every artifact undergoes peer review before progression
5. **Microservice Architecture**: Systems designed as independent services for parallel development

## Directory Structure

**Note**: For the new versioned coordination structure with agent subdirectories, see `/templates/coordination-structure-example.md`

```
project-root/
├── docs/                    # Initial PRD and project documents
├── odyssey/                 # Master planning and design documents
│   ├── status/             # Status tracking files
│   │   └── phase-status.md # Overall phase tracking
│   ├── milestone-plan.md    # High-level milestone breakdown
│   ├── milestones/         # Detailed milestone specifications
│   │   ├── m1-foundation/
│   │   ├── m2-core/
│   │   └── m3-scale/
│   ├── design/             # Product design artifacts
│   │   ├── design-system.md
│   │   └── mockups/
│   ├── architecture/       # High-level technical design
│   │   ├── system-design.md
│   │   ├── service-map.md
│   │   └── data-flow.md
│   └── reviews/           # Collected feedback
│       ├── design-review.md
│       └── tech-review.md
├── coordination/           # Active development coordination
│   ├── milestone-1/       # Current milestone work
│   │   ├── status.md      # Milestone status tracking
│   │   ├── specs/
│   │   │   ├── Product-Manager/
│   │   │   │   └── v1.0-requirements.md
│   │   │   ├── Backend-Developer/
│   │   │   │   └── v1.0-api-design.md
│   │   │   └── [agent-name]/
│   │   │       └── v[X.Y]-[feature].md
│   │   ├── implementations/
│   │   │   └── [agent-name]/
│   │   │       └── v[X.Y]-[feature]-implementation.md
│   │   ├── progress/
│   │   │   └── [agent-name].md
│   │   └── reviews/
│   │       ├── design-reviews/
│   │       └── pr-reviews/
│   ├── milestone-2/       # Future milestone
│   └── milestone-3/       # Future milestone
└── [code directories]/    # Actual implementation
```

## Status Tracking System

### Phase Status File (`odyssey/status/phase-status.md`)
Tracks overall project phases with checkboxes for completion:
- All agents monitor this file (pull model)
- Agents act when their phase becomes active
- Update checkboxes when completing tasks

### Milestone Status File (`coordination/milestone-X/status.md`)
Tracks detailed milestone progress:
- Sub-phases within each milestone
- Individual task assignments
- Cross-review tracking
- Blocker identification

## Phase 1: Strategic Planning

**Owner**: Product-Manager  
**Duration**: 3-5 days  
**Output**: Milestone plan and high-level strategy

### Activities

1. **PRD Analysis**
   ```bash
   Product-Manager reads docs/PRD.md
   → Creates odyssey/milestone-plan.md
   → Breaks down into 3-5 milestones
   → Defines success criteria per milestone
   ```

2. **Milestone Planning**
   - Each milestone should be 2-4 weeks of work
   - Clear deliverables and dependencies
   - Identified team members per milestone
   - Risk assessment and mitigation

3. **Deliverables**
   ```
   odyssey/
   ├── milestone-plan.md
   └── milestones/
       ├── m1-foundation/
       │   ├── objectives.md
       │   ├── deliverables.md
       │   └── team.md
       └── [other milestones]/
   ```

### Review Gate
- Human review of milestone plan
- Approval before proceeding to Phase 2

## Phase 2: Product Design & Review (OPTIONAL)

**Owner**: UX-Designer (lead), All Engineers (reviewers)  
**Duration**: 5-7 days  
**Output**: Approved design system and mockups  
**When to Skip**: For MVPs, technical tools, or when Frontend-Developer can work directly from PRD

### When This Phase is Needed
- Consumer-facing applications requiring polished UI
- Complex user workflows needing visualization  
- When stakeholders need to approve visual design
- Projects with dedicated design resources

### When to Skip This Phase
- Internal tools or admin dashboards
- API-only services
- MVPs where speed matters more than polish
- When Frontend-Developer has clear UI direction from PRD

### Activities (When Phase is Active)

1. **Design Creation**
   ```bash
   UX-Designer reads:
   → docs/PRD.md
   → odyssey/milestone-plan.md
   
   Creates:
   → odyssey/design/design-system.md
   → odyssey/design/mockups/
   → odyssey/design/user-flows.md
   ```

2. **Collaborative Review**
   - All engineers review designs
   - Technical feasibility assessment
   - Performance implications
   - Security considerations
   - Accessibility requirements

3. **Feedback Collection**
   ```
   odyssey/reviews/design-review.md
   
   ## Feedback Summary
   
   ### Backend-Developer
   - API implications: ...
   - Data model suggestions: ...
   
   ### Frontend-Developer
   - Component complexity: ...
   - State management needs: ...
   
   ### Security-Engineer
   - Authentication flows: ...
   - Data privacy concerns: ...
   ```

### Review Gate
- All engineers approve design
- Design revised based on feedback
- Human final approval

## Phase 3: Technical Architecture

**Owner**: All Engineers (collaborative)  
**Duration**: 5-7 days  
**Output**: Approved system architecture  
**Input**: PRD, milestone plan, and designs (if Phase 2 was executed)

### Adjustments When Phase 2 Was Skipped
- Frontend-Developer creates UI architecture based on PRD requirements
- Engineers collaborate on UI/UX decisions during architecture review
- Additional focus on component library selection and UI patterns

### Activities

1. **Architecture Design**
   ```bash
   Each engineer creates their domain architecture:
   
   Backend-Developer → odyssey/architecture/backend-services.md
   Frontend-Developer → odyssey/architecture/frontend-architecture.md
   Mobile-Developer → odyssey/architecture/mobile-architecture.md
   Data-Engineer → odyssey/architecture/data-pipeline.md
   ```

2. **Microservice Design**
   - Each service independently deployable
   - Clear API contracts
   - Shared nothing architecture
   - Service communication patterns

3. **Cross-Domain Review**
   ```
   Review Matrix:
   - Backend reviews Frontend architecture
   - Frontend reviews Backend API design
   - Bar-Raiser reviews all architectures
   - Security-Engineer reviews security aspects
   ```

4. **Architecture Revision**
   - Incorporate feedback
   - Ensure consistency
   - Validate against milestones

### Review Gate
- Bar-Raiser approval
- Security-Engineer approval
- All engineers consensus
- Human final approval

## Phase 4: Milestone Setup

**Owner**: Orchestrator  
**Duration**: 1 day  
**Output**: Milestone coordination structure

### Activities

1. **Directory Creation**
   ```bash
   coordination/
   ├── milestone-1/
   │   ├── specs/
   │   │   ├── Product-Manager/
   │   │   ├── UX-Designer/
   │   │   ├── Backend-Developer/
   │   │   └── [all agents]/
   │   ├── implementations/
   │   ├── progress/
   │   └── reviews/
   └── [other milestones]/
   ```

2. **Milestone Kickoff**
   - Copy relevant odyssey docs to milestone
   - Create progress tracking files
   - Set up review templates

## Phase 5: Iterative Milestone Implementation

**Owner**: All Agents  
**Duration**: 2-4 weeks per milestone  
**Output**: Working software increment

### 5.1 Milestone Planning (2-3 days)

1. **Detailed Requirements**
   ```bash
   Product-Manager → coordination/milestone-X/specs/Product-Manager/requirements.md
   UX-Designer → coordination/milestone-X/specs/UX-Designer/ui-specs.md
   ```

2. **Technical Design**
   ```bash
   Each engineer creates detailed design:
   Backend-Developer → coordination/milestone-X/specs/Backend-Developer/v1.0-api-design.md
   Frontend-Developer → coordination/milestone-X/specs/Frontend-Developer/v1.0-component-design.md
   Mobile-Developer → coordination/milestone-X/specs/Mobile-Developer/v1.0-app-design.md
   ```

### 5.2 Design Review (1-2 days)

1. **Cross-Review Process**
   ```
   Review Matrix:
   - Frontend-Developer reviews Backend-Developer's API design
   - Backend-Developer reviews Frontend-Developer's component design
   - Mobile-Developer reviews Backend API design
   - All engineers review each other's designs
   - Bar-Raiser reviews all designs for best practices
   - Security-Engineer reviews all designs for vulnerabilities
   ```

2. **Document Review Feedback Location**
   
   For design document reviews, feedback should be collected in structured markdown files:
   
   ```
   coordination/milestone-X/reviews/design-reviews/
   ├── backend-design-feedback.md     # All feedback on backend design
   ├── frontend-design-feedback.md    # All feedback on frontend design
   ├── mobile-design-feedback.md      # All feedback on mobile design
   └── security-review.md            # Security-specific feedback
   ```
   
   **Feedback Format**:
   ```markdown
   # Backend Design v1.0 Feedback
   
   ## Frontend-Developer Review
   - **API Consistency**: The endpoint naming...
   - **Response Format**: Consider using...
   - **Error Handling**: Need consistent error codes...
   
   ## Security-Engineer Review
   - **Authentication**: JWT expiry should be...
   - **Rate Limiting**: Add rate limits to...
   
   ## Bar-Raiser Review
   - **Scalability**: This design won't scale beyond...
   - **Alternative**: Consider event-driven approach...
   ```
   
   **For Architecture Reviews (Phase 3)**:
   ```
   odyssey/reviews/
   ├── design-review.md              # Phase 2 design feedback
   ├── architecture-review.md        # General architecture feedback
   ├── security-architecture-review.md  # Security-specific feedback
   └── bar-raiser-architecture-review.md # Principal-level feedback
   ```

3. **Design Revision**
   - Engineers revise based on feedback
   - Create v1.1 if significant changes needed
   - Get re-approval after revisions

### 5.3 Implementation (5-10 days)

1. **Parallel Development**
   ```bash
   Backend-Developer implements in backend/
   Frontend-Developer implements in frontend/
   Mobile-Developer implements in mobile/
   ```

2. **Unit Testing**
   - Each developer writes comprehensive unit tests
   - Achieve >80% code coverage
   - Tests included in CI pipeline

3. **Local Verification**
   ```bash
   # Backend verification
   docker-compose up backend-service
   curl -X POST http://localhost:8080/api/...
   
   # Frontend verification
   npm start
   # Use MCP Playwright to capture screenshots
   # Verify console logs
   ```

### 5.4 Code Review & PR Process (2-3 days)

1. **PR Creation**
   ```bash
   # Each agent commits only their changes
   git add [their-files]
   git commit -m "feat(backend): implement user service"
   git push
   gh pr create --title "..." --body "..."
   ```

2. **Review Process**
   
   Since all agents operate under one GitHub account, they identify themselves in comments:
   
   ```bash
   # Each agent prefixes their comments with their name
   gh pr comment [PR-number] -b "Backend-Developer: The API design looks good..."
   gh pr comment [PR-number] -b "Security-Engineer: ⚠️ Found SQL injection vulnerability..."
   gh pr comment [PR-number] -b "Bar-Raiser: 🔴 This won't scale beyond 1000 RPS..."
   
   # Approval comments
   gh pr comment [PR-number] -b "Frontend-Developer: LGTM! ✅"
   gh pr comment [PR-number] -b "Security-Engineer: Security review passed ✅"
   gh pr comment [PR-number] -b "Bar-Raiser: Meets our high bar! 🎆"
   ```

3. **Approval Workflow**
   - Address all feedback
   - Collect "LGTM" or approval comments from all required reviewers:
     - Cross-functional reviews (Frontend ↔ Backend ↔ Mobile)
     - Bar-Raiser approval (always required)
     - Security-Engineer approval (always required)
   - Human reviews all agent feedback and merges when consensus reached

### 5.5 QA & Integration Testing (1-2 days)

1. **E2E Testing**
   ```bash
   QA-Engineer:
   → Runs integration tests
   → Uses MCP to test web UI
   → Validates API contracts
   → Performance testing
   ```

2. **Sign-off**
   - QA-Engineer approves functionality
   - All tests passing
   - Performance benchmarks met

### 5.6 Documentation & Closure (1 day)

1. **Implementation Docs**
   ```bash
   Each engineer writes implementation documentation:
   → coordination/milestone-X/implementations/Backend-Developer/v1.0-api-implementation.md
   → coordination/milestone-X/implementations/Frontend-Developer/v1.0-ui-implementation.md
   → coordination/milestone-X/implementations/Mobile-Developer/v1.0-app-implementation.md
   
   Contents:
   → What was implemented
   → Key technical decisions
   → Challenges encountered and solutions
   → Performance metrics
   → Future improvements
   ```

2. **Milestone Review**
   - Human reviews all deliverables
   - Approval to proceed to next milestone

## Review Gates Summary

1. **Phase 1 Gate**: Milestone plan approval
2. **Phase 2 Gate**: Design approval from all engineers
3. **Phase 3 Gate**: Architecture approval (Bar-Raiser + Security + All)
4. **Milestone Design Gate**: Technical design consensus
5. **PR Gate**: All reviewer approvals
6. **QA Gate**: All tests passing + QA sign-off
7. **Milestone Gate**: Human review of deliverables

## Success Metrics

- **Quality**: <2 bugs per milestone in production
- **Velocity**: 90% milestone completion on schedule
- **Collaboration**: 100% designs reviewed before implementation
- **Testing**: >80% code coverage, 100% E2E coverage
- **Security**: Zero critical vulnerabilities

## Tools & Integration

### MCP Integration
- **Playwright/Puppeteer**: UI testing and verification
- **Context7**: Framework documentation and best practices
- **Sequential**: Complex analysis during reviews

### Git Workflow
- Feature branches per milestone
- PR-based development
- Automated CI/CD per service
- Protected main branch

## Best Practices

1. **Early Feedback**: Review designs before implementation
2. **Parallel Work**: Independent services enable parallel development
3. **Clear Ownership**: Each agent owns specific directories
4. **Incremental Delivery**: Ship working software each milestone
5. **Continuous Documentation**: Document decisions as you go

## Common Pitfalls to Avoid

1. **Skipping Reviews**: Never skip review gates
2. **Big Bang Integration**: Test integration continuously
3. **Unclear Requirements**: Always clarify before implementing
4. **Solo Decision Making**: Architecture decisions need consensus
5. **Incomplete Testing**: Both unit and E2E tests are mandatory