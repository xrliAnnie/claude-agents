# Project Phase Status

**Project**: [Project Name]  
**Created**: [Date]  
**Last Updated**: [Date]

## Phase 1: Strategic Planning
- [ ] PRD created in `docs/PRD.md`
- [ ] Product-Manager read and analyzed PRD
- [ ] Milestone plan created in `odyssey/milestone-plan.md`
- [ ] 3-5 milestones defined in `odyssey/milestones/`
- [ ] Success criteria defined for each milestone
- [ ] Team members identified per milestone
- [ ] Risk assessment completed
- [ ] Human review completed
- [ ] Phase approved

**Status**: Not Started  
**Owner**: Product-Manager  
**Start Date**: -  
**End Date**: -  
**Blockers**: None

## Phase 2: Product Design (OPTIONAL)
- [ ] **Decision**: Skip design phase (check if skipping)
- [ ] **Decision**: Execute design phase (check if executing)

### If Executing Design Phase:
- [ ] UX-Designer assigned
- [ ] UX-Designer read PRD and milestone plan
- [ ] Design system created in `odyssey/design/design-system.md`
- [ ] Mockups created in `odyssey/design/mockups/`
- [ ] User flows documented
- [ ] All engineers have reviewed designs:
  - [ ] Backend-Developer review completed
  - [ ] Frontend-Developer review completed
  - [ ] Mobile-Developer review completed
  - [ ] Security-Engineer review completed
- [ ] Feedback documented in `odyssey/reviews/design-review.md`
- [ ] Design revisions completed based on feedback
- [ ] All engineers approved final design
- [ ] Human review completed
- [ ] Phase approved

**Status**: Evaluate after Phase 1  
**Owner**: UX-Designer (if executing) / Skip (if not needed)  
**Decision Criteria**: 
- Skip for: MVPs, internal tools, technical APIs, admin dashboards
- Execute for: Consumer apps, complex UX, visual design requirements
**Start Date**: -  
**End Date**: -  
**Blockers**: None

## Phase 3: Technical Architecture
- [ ] All engineers assigned
- [ ] Engineers read PRD, milestone plan, and designs (if available)
- [ ] Architecture documents created:
  - [ ] Backend-Developer: `odyssey/architecture/backend-services.md`
  - [ ] Frontend-Developer: `odyssey/architecture/frontend-architecture.md`
  - [ ] Mobile-Developer: `odyssey/architecture/mobile-architecture.md`
  - [ ] Data-Engineer: `odyssey/architecture/data-pipeline.md` (if applicable)
- [ ] Cross-reviews completed:
  - [ ] Backend reviewed Frontend architecture
  - [ ] Frontend reviewed Backend architecture
  - [ ] Mobile reviewed Backend architecture
  - [ ] Bar-Raiser reviewed all architectures
  - [ ] Security-Engineer reviewed all architectures
- [ ] Feedback documented in `odyssey/reviews/tech-review.md`
- [ ] Architecture revisions completed
- [ ] All engineers approved final architecture
- [ ] Bar-Raiser approved
- [ ] Security-Engineer approved
- [ ] Human review completed
- [ ] Phase approved

**Status**: Waiting for Phase 2  
**Owner**: All Engineers (collaborative)  
**Start Date**: -  
**End Date**: -  
**Blockers**: None

## Phase 4: Milestone Setup
- [ ] Orchestrator assigned
- [ ] Milestone directories created under `coordination/`
- [ ] Status files initialized for each milestone
- [ ] Agent-specific directories created
- [ ] Framework instructions added to project agents
- [ ] Human review completed
- [ ] Phase approved

**Status**: Waiting for Phase 3  
**Owner**: Orchestrator  
**Start Date**: -  
**End Date**: -  
**Blockers**: None

## Phase 5: Milestone Implementation
- [ ] Milestone 1 started
  - [ ] Status: [Not Started/In Progress/Completed]
  - [ ] Start Date: -
  - [ ] End Date: -
- [ ] Milestone 2 started
  - [ ] Status: [Not Started/In Progress/Completed]
  - [ ] Start Date: -
  - [ ] End Date: -
- [ ] Milestone 3 started
  - [ ] Status: [Not Started/In Progress/Completed]
  - [ ] Start Date: -
  - [ ] End Date: -
- [ ] All milestones completed
- [ ] Project delivered

**Status**: Waiting for Phase 4  
**Owner**: All Agents  
**Start Date**: -  
**End Date**: -  
**Blockers**: None

---

## How to Use This File

1. **All agents monitor this file** using a pull model
2. **Check your phase** - When your phase status changes to "In Progress", begin work
3. **Update checkboxes** as you complete tasks
4. **Update status** when all your tasks are complete
5. **Add blockers** if you encounter issues
6. **Transition phases** - Orchestrator updates phase status when all checkboxes are complete

## Status Values
- **Not Started**: Phase hasn't begun
- **In Progress**: Phase is active
- **Blocked**: Waiting on resolution
- **Review**: Awaiting human review
- **Completed**: Phase finished and approved
- **Waiting for Phase X**: Dependent on previous phase