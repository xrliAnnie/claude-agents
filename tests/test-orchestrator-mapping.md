# Test: Orchestrator Agent Mapping

This test verifies that the Orchestrator correctly maps existing agents instead of creating new ones.

## Test Scenario 1: New Project Setup

**Input**: User wants to set up agents for a 3D visualization project (GeoForge3D)

**Expected Behavior**:
1. Orchestrator lists available root agents (not create new ones)
2. User selects: Frontend-Developer, Backend-Developer, Data-Engineer, QA-Engineer, Bar-Raiser
3. Orchestrator creates configuration files in `.claude/agents/config/`
4. No new agents are created in `.claude/agents/`

**Configuration Files Created**:
```
.claude/agents/config/
├── Frontend-Developer.config.md
├── Backend-Developer.config.md
├── Data-Engineer.config.md
├── QA-Engineer.config.md
└── Bar-Raiser.config.md
```

## Test Scenario 2: Agent Mapping Rationale

**For Frontend-Developer.config.md**:
```markdown
---
base_agent: Frontend-Developer
project: GeoForge3D
created: 2024-01-28
---

## Project Configuration for Frontend-Developer

### Agent Mapping Rationale
- **Why this agent**: Three.js 3D visualization, React UI, Mapbox integration
- **Key responsibilities**: 3D terrain rendering, map controls, user interface
- **Not creating new agent**: Using existing Frontend-Developer with 3D/WebGL context
```

## Test Scenario 3: Adding Agent to Existing Project

**Input**: User wants to add Security-Engineer to existing project

**Expected Behavior**:
1. Orchestrator analyzes current project state
2. Maps Security-Engineer to project security needs
3. Creates `.claude/agents/config/Security-Engineer.config.md`
4. Does NOT create new agent file

## Verification Checklist

- [ ] No new agent files created in root agents directory
- [ ] Configuration files use `base_agent` reference
- [ ] Mapping rationale documented in each config
- [ ] Project context properly captured
- [ ] Integration points with other agents defined
- [ ] No duplicate agent functionality