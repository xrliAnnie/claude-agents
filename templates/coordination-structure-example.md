# Updated Coordination Structure Example

This shows the new coordination structure with specs and implementations organized by agent subdirectories.

## Directory Structure

```
project-root/
├── .claude/
│   └── agents/                    # Project-specific agents
│       ├── GeoForge3D-Backend-Developer.md
│       ├── GeoForge3D-Frontend-Developer.md
│       ├── GeoForge3D-Data-Engineer.md
│       ├── GeoForge3D-Security-Engineer.md
│       ├── GeoForge3D-QA-Engineer.md
│       └── GeoForge3D-Bar-Raiser.md
├── coordination/
│   └── v1.3.4.7/                 # Version directory
│       ├── specs/                # Specifications by agent
│       │   ├── Backend-Developer/
│       │   │   ├── color-palette-data-flow.md
│       │   │   └── postprocessing-service-fix.md
│       │   ├── Frontend-Developer/
│       │   │   ├── color-palette-ui.md
│       │   │   └── mapbox-integration.md
│       │   ├── Data-Engineer/
│       │   │   ├── terrain-data-optimization.md
│       │   │   └── scene-descriptor-management.md
│       │   ├── Security-Engineer/
│       │   │   ├── api-security-review.md
│       │   │   └── data-access-audit.md
│       │   ├── QA-Engineer/
│       │   │   └── color-palette-e2e-tests.md
│       │   └── Bar-Raiser/
│       │       └── architecture-review.md
│       ├── implementations/       # Implementation docs by agent
│       │   ├── Backend-Developer/
│       │   │   ├── color-palette-data-flow-impl.md
│       │   │   └── postprocessing-service-fix-impl.md
│       │   ├── Frontend-Developer/
│       │   │   ├── color-palette-ui-impl.md
│       │   │   └── mapbox-integration-impl.md
│       │   ├── Data-Engineer/
│       │   │   ├── terrain-data-optimization-impl.md
│       │   │   └── scene-descriptor-management-impl.md
│       │   ├── Security-Engineer/
│       │   │   ├── api-security-review-results.md
│       │   │   └── data-access-audit-results.md
│       │   ├── QA-Engineer/
│       │   │   └── color-palette-e2e-tests-results.md
│       │   └── Bar-Raiser/
│       │       └── architecture-review-feedback.md
│       └── status.md              # Overall version status
├── docs/
│   └── PRD.md                    # Product Requirements Document
└── src/                          # Source code directories
    ├── backend/
    ├── frontend/
    └── data-pipeline/

## Key Changes from Previous Structure

1. **Agents Location**: Moved from `coordination/agents/` to `.claude/agents/` (repo root)
2. **Versioned Coordination**: All coordination happens under version directories (e.g., `v1.3.4.7/`)
3. **Agent Subdirectories**: Each agent has their own subdirectory under `specs/` and `implementations/`
4. **Clear Ownership**: Each agent owns their specific subdirectories

## Agent Configuration Examples

### Backend-Developer Configuration
```markdown
# GeoForge3D-Backend-Developer

## Your Directories
- **Specs**: `coordination/v*/specs/Backend-Developer/`
- **Implementations**: `coordination/v*/implementations/Backend-Developer/`
- **Code**: `src/backend/`

## Current Tasks (v1.3.4.7)
- Fix color palette data flow in postprocessing service
- Implement proper event handling for color updates
```

### Security-Engineer Configuration
```markdown
# GeoForge3D-Security-Engineer

## Your Directories
- **Specs**: `coordination/v*/specs/Security-Engineer/`
- **Implementations**: `coordination/v*/implementations/Security-Engineer/`
- **Reviews**: Read access to all code directories

## Current Tasks (v1.3.4.7)
- Review API security for new color palette endpoints
- Audit data access patterns in postprocessing service
```

### Bar-Raiser Configuration
```markdown
# GeoForge3D-Bar-Raiser

## Your Directories
- **Specs**: `coordination/v*/specs/Bar-Raiser/`
- **Implementations**: `coordination/v*/implementations/Bar-Raiser/`
- **Reviews**: Read access to all specs and implementations

## Current Tasks (v1.3.4.7)
- Review overall architecture for color palette feature
- Ensure scalability and performance requirements are met
```

## Version Status Tracking

The `coordination/v1.3.4.7/status.md` file tracks overall progress:

```markdown
# Version 1.3.4.7 Status - Color Palette Implementation

## Overview
Implementing color palette selection feature across all product styles.

## Agent Progress

### Backend-Developer
- [x] Color palette data flow spec created
- [ ] Postprocessing service fix implemented
- [ ] Unit tests added

### Frontend-Developer
- [x] Color palette UI spec created
- [ ] React component implemented
- [ ] Mapbox integration complete

### Data-Engineer
- [ ] Terrain data optimization spec
- [ ] Scene descriptor updates

### Security-Engineer
- [ ] API security review complete
- [ ] Data access audit complete

### QA-Engineer
- [ ] E2E test plan created
- [ ] Tests implemented
- [ ] All product styles tested

### Bar-Raiser
- [ ] Architecture review complete
- [ ] Performance validation done

## Blockers
- None currently

## Next Steps
1. Complete backend implementation
2. Frontend implementation
3. Security review
4. QA testing
5. Bar-Raiser final review
```

## Benefits of This Structure

1. **Clear Ownership**: Each agent knows exactly which directories they own
2. **Version Control**: All work is versioned together
3. **Parallel Work**: Agents can work independently in their directories
4. **Easy Navigation**: Consistent structure across all versions
5. **Review Friendly**: Bar-Raiser and Security-Engineer can easily find all specs/implementations
6. **Scalable**: Easy to add new agents or versions