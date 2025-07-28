# Test: Orchestrator Agent Creation

This test verifies that the Orchestrator correctly creates project-specific agents based on existing agent types.

## Test Scenario 1: New Project Setup

**Input**: User wants to set up agents for a 3D visualization project (GeoForge3D)

**Expected Behavior**:
1. Orchestrator lists available root agent types
2. Orchestrator reads PRD from docs/PRD.md
3. User selects: Frontend-Developer, Backend-Developer, Data-Engineer, QA-Engineer, Bar-Raiser
4. Orchestrator creates project-specific agents:
   - GeoForge3D-Frontend-Developer
   - GeoForge3D-Backend-Developer
   - GeoForge3D-Data-Engineer
   - GeoForge3D-QA-Engineer
   - GeoForge3D-Bar-Raiser
5. Each agent includes project context from PRD

**Coordination Structure Created**:
```
coordination/
├── specs/
│   ├── Frontend-Developer/
│   ├── Backend-Developer/
│   ├── Data-Engineer/
│   ├── QA-Engineer/
│   └── Bar-Raiser/
├── implementations/
│   └── [same structure]
└── progress/
    ├── Frontend-Developer.md
    ├── Backend-Developer.md
    ├── Data-Engineer.md
    ├── QA-Engineer.md
    └── Bar-Raiser.md
```

## Test Scenario 2: Agent Creation Details

**Example Creation**:
```yaml
agents_created:
  GeoForge3D-Frontend-Developer:
    based_on: Frontend-Developer
    reason: "Three.js 3D visualization, React UI, Mapbox integration"
    project_context: "3D terrain rendering, map controls, WebGL"
  GeoForge3D-Backend-Developer:
    based_on: Backend-Developer
    reason: "API service, terrain data processing"
    project_context: "FastAPI endpoints, DEM processing, caching"
```

## Test Scenario 3: Adding Agent to Existing Project

**Input**: User wants to add Security-Engineer to existing project

**Expected Behavior**:
1. Orchestrator reads existing project docs
2. Determines Security-Engineer is needed for API security
3. Creates GeoForge3D-Security-Engineer based on root Security-Engineer
4. Adds coordination directories for new agent
5. Does NOT create new agent TYPE (uses existing Security-Engineer type)

## Verification Checklist

- [ ] Project-specific agents created with [RepoName]-[AgentType] naming
- [ ] All agents based on existing agent types from root
- [ ] No new agent TYPES created (e.g., no "3D-Processing-Agent")
- [ ] PRD and design docs incorporated into agent context
- [ ] Coordination structure properly set up
- [ ] Creation rationale documented
- [ ] Each agent maintains its type's core functionality