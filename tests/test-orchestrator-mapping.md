# Test: Orchestrator Agent Selection

This test verifies that the Orchestrator correctly selects existing agents instead of creating new ones.

## Test Scenario 1: New Project Setup

**Input**: User wants to set up agents for a 3D visualization project (GeoForge3D)

**Expected Behavior**:
1. Orchestrator lists available root agents (not create new ones)
2. Orchestrator reads PRD from docs/PRD.md
3. User selects: Frontend-Developer, Backend-Developer, Data-Engineer, QA-Engineer, Bar-Raiser
4. Orchestrator sets up coordination structure
5. No new agents are created

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

## Test Scenario 2: Agent Selection Rationale

**Example Selection**:
```yaml
agent_selection:
  Frontend-Developer:
    reason: "Three.js 3D visualization, React UI, Mapbox integration"
    responsibilities: "3D terrain rendering, map controls, user interface"
  Backend-Developer:
    reason: "API service, terrain data processing"
    responsibilities: "FastAPI endpoints, DEM processing, caching"
```

## Test Scenario 3: Adding Agent to Existing Project

**Input**: User wants to add Security-Engineer to existing project

**Expected Behavior**:
1. Orchestrator reads existing project docs
2. Determines Security-Engineer is needed for API security
3. Adds coordination directories for Security-Engineer
4. Does NOT create new agent file

## Verification Checklist

- [ ] No new agent files created
- [ ] Agents selected from existing pool
- [ ] PRD and design docs are read for context
- [ ] Coordination structure properly set up
- [ ] Selection rationale documented
- [ ] No duplicate agent functionality