#!/bin/bash
# Orchestration Setup Script - Version 2.0
# Used by the Orchestrator agent to set up project structure

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Available agents
declare -a AGENT_NAMES=(
    "PM-Architecture"
    "PM-PRD"
    "UI-UX"
    "Backend-Developer"
    "Frontend-Developer"
    "Mobile-Developer"
    "Data-Engineer"
    "Data-Scientist"
    "DevOps-SRE"
    "QA-Test-Engineer"
    "Security-Engineer"
)

declare -a AGENT_DESCRIPTIONS=(
    "Project planning and task breakdown"
    "Product requirements documentation"
    "Design and user experience"
    "Server-side development"
    "Web UI development"
    "iOS/Android development"
    "Data pipelines and analytics"
    "ML models and analysis"
    "Infrastructure and deployment"
    "Testing and quality assurance"
    "Security and compliance"
)

# Agents that need code directories
declare -a CODE_AGENTS=(
    "Backend-Developer"
    "Frontend-Developer"
    "Mobile-Developer"
    "Data-Engineer"
    "DevOps-SRE"
)

# Default directory names
declare -A DEFAULT_DIRS=(
    ["Backend-Developer"]="backend"
    ["Frontend-Developer"]="frontend"
    ["Mobile-Developer"]="mobile"
    ["Data-Engineer"]="data"
    ["DevOps-SRE"]="infrastructure"
)

# Function to check if agent needs code directory
needs_code_dir() {
    local agent=$1
    for code_agent in "${CODE_AGENTS[@]}"; do
        if [[ "$agent" == "$code_agent" ]]; then
            return 0
        fi
    done
    return 1
}

# Function to display agents
display_agents() {
    echo -e "${BLUE}Available Agents:${NC}"
    for i in "${!AGENT_NAMES[@]}"; do
        echo "$((i+1)). ${AGENT_NAMES[$i]} - ${AGENT_DESCRIPTIONS[$i]}"
    done
}

# Function to get selected agents
get_selected_agents() {
    display_agents
    echo ""
    echo -e "${YELLOW}Which agents would you like to include? (Enter numbers separated by commas)${NC}"
    echo "Example: 1,3,4,5,10"
    read -p "> " agent_selection
    
    # Parse selection
    IFS=',' read -ra SELECTED_NUMS <<< "$agent_selection"
    SELECTED_AGENTS=()
    
    for num in "${SELECTED_NUMS[@]}"; do
        # Trim whitespace
        num=$(echo "$num" | tr -d ' ')
        # Validate number
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#AGENT_NAMES[@]}" ]; then
            SELECTED_AGENTS+=("${AGENT_NAMES[$((num-1))]}")
        fi
    done
    
    echo -e "${GREEN}Selected agents:${NC} ${SELECTED_AGENTS[*]}"
}

# Function to configure directories
configure_directories() {
    echo ""
    echo -e "${BLUE}Configure code directories:${NC}"
    
    for agent in "${SELECTED_AGENTS[@]}"; do
        if needs_code_dir "$agent"; then
            default_dir="${DEFAULT_DIRS[$agent]}"
            read -p "$agent directory [default: $default_dir]: " custom_dir
            if [[ -z "$custom_dir" ]]; then
                AGENT_DIRS["$agent"]="$default_dir"
            else
                AGENT_DIRS["$agent"]="$custom_dir"
            fi
        fi
    done
}

# Function to create project structure
create_structure() {
    echo ""
    echo -e "${BLUE}Creating project structure...${NC}"
    
    # Create coordination directories
    mkdir -p coordination/{specs,implementations,progress,iterations,blockers}
    
    # Create agent-specific directories in coordination
    for agent in "${SELECTED_AGENTS[@]}"; do
        mkdir -p "coordination/specs/$agent"
        mkdir -p "coordination/implementations/$agent"
        
        # Create progress file
        cat > "coordination/progress/$agent.md" << EOF
# $agent Progress

## Current Sprint
- [ ] Not started

## Completed Features

## Blocked

## Notes
EOF
    done
    
    # Create code directories
    for agent in "${!AGENT_DIRS[@]}"; do
        dir="${AGENT_DIRS[$agent]}"
        mkdir -p "$dir"
        echo "Created code directory: $dir/"
    done
    
    # Create .claude/agents directory
    mkdir -p .claude/agents
    
    # Create docs directory
    mkdir -p docs
    
    echo -e "${GREEN}✓ Structure created${NC}"
}

# Function to create project-specific agent
create_project_agent() {
    local agent_name=$1
    local code_dir=${AGENT_DIRS[$agent_name]:-""}
    
    # Read root agent if it exists
    local root_agent_file="$HOME/.claude/agents/$agent_name.md"
    if [[ ! -f "$root_agent_file" ]]; then
        echo -e "${YELLOW}Warning: Root agent $agent_name not found${NC}"
        return
    fi
    
    # Extract PRD content if available
    local prd_content=""
    if [[ -f "docs/PRD.md" ]]; then
        prd_content=$(head -50 docs/PRD.md)
    fi
    
    # Create project-specific agent
    cat > ".claude/agents/$agent_name.md" << EOF
$(cat "$root_agent_file")

## Project-Specific Context

This agent is configured for this specific project.

### Project Overview
$prd_content

### Agent Responsibilities
$(if [[ -n "$code_dir" ]]; then
    echo "- Implement features in \`$code_dir/\`"
fi)
- Maintain specs in \`coordination/specs/$agent_name/\`
- Update implementations in \`coordination/implementations/$agent_name/\`
- Track progress in \`coordination/progress/$agent_name.md\`

### Directory Ownership
- **Write Access**: 
$(if [[ -n "$code_dir" ]]; then
    echo "  - \`$code_dir/\` (all subdirectories)"
fi)
  - \`coordination/specs/$agent_name/\`
  - \`coordination/implementations/$agent_name/\`
  - \`coordination/progress/$agent_name.md\`
- **Read Access**: All project files

### Workflow
1. **Design First**: Create spec in \`coordination/specs/$agent_name/[feature]-v1.0.md\`
2. **Implement**: Build in your code directory$(if [[ -n "$code_dir" ]]; then echo " (\`$code_dir/\`)"; fi)
3. **Document**: Update \`coordination/implementations/$agent_name/[feature]-v1.0.md\`
4. **Track**: Update \`coordination/progress/$agent_name.md\`

### Git Workflow
\`\`\`bash
# Only commit files you own
git add$(if [[ -n "$code_dir" ]]; then echo " $code_dir/"; fi) coordination/specs/$agent_name/ coordination/implementations/$agent_name/ coordination/progress/$agent_name.md
git commit -m '$(echo $agent_name | tr '[:upper:]' '[:lower:]' | cut -d'-' -f1): [descriptive message]'
\`\`\`

### Versioning Convention
- Initial spec: \`feature-v1.0.md\`
- Minor updates: \`feature-v1.1.md\`
- Patches: \`feature-v1.1.1.md\`
- Implementation versions must match spec versions
EOF
    
    echo -e "${GREEN}✓ Created project agent: $agent_name${NC}"
}

# Function to create coordination guide
create_coordination_guide() {
    cat > coordination/README.md << 'EOF'
# Project Coordination Guide

## Structure Overview

### `/specs/[agent-name]/`
- Contains versioned specifications for each feature
- Example: `auth-v1.0.md`, `auth-v1.1.md`
- Agents create specs BEFORE implementation

### `/implementations/[agent-name]/`
- Documents HOW features were implemented
- Version numbers MUST match spec versions
- Example: `auth-v1.0.md` implementation for `auth-v1.0.md` spec

### `/progress/[agent-name].md`
- Tracks what each agent is working on
- Updated regularly by agents
- Shows completed, in-progress, and blocked items

### `/iterations/`
- Sprint plans and timelines
- Feature priorities
- Success criteria

### `/blockers/`
- Active blocking issues
- Dependencies between agents

## Versioning Guide

### Version Numbers
- `v1.0` - Initial version of a feature
- `v1.1` - Minor additions/enhancements
- `v1.1.1` - Bug fixes or small changes
- `v2.0` - Major rewrite or breaking changes

### Example Flow
1. Backend creates `coordination/specs/Backend-Developer/auth-v1.0.md`
2. Backend implements auth system
3. Backend creates `coordination/implementations/Backend-Developer/auth-v1.0.md`
4. Frontend reads the spec and implements UI
5. If API needs changes, Backend creates `auth-v1.1.md` spec
6. All agents update to use v1.1

## Agent Workflows

### For All Agents
1. Check current sprint in `/iterations/`
2. Read dependencies from other agents' `/specs/`
3. Create your spec with version number
4. Implement the feature
5. Document implementation
6. Update progress file
7. Commit ONLY your files

### Git Commit Prefixes
- `pm:` - PM-Architecture, PM-PRD
- `design:` - UI-UX
- `backend:` - Backend-Developer
- `frontend:` - Frontend-Developer
- `mobile:` - Mobile-Developer
- `data:` - Data-Engineer, Data-Scientist
- `devops:` - DevOps-SRE
- `qa:` - QA-Test-Engineer
- `security:` - Security-Engineer

## Communication Rules
- All communication through files
- No direct agent-to-agent modification
- Use blockers/ for urgent issues
- Version everything
EOF
    
    echo -e "${GREEN}✓ Created coordination guide${NC}"
}

# Main execution
main() {
    echo -e "${BLUE}=== Orchestrator Setup Script v2.0 ===${NC}"
    echo ""
    
    # Check if this is an existing project
    if [[ -d "coordination" ]]; then
        echo -e "${YELLOW}Existing project detected. Use 'add-agent' mode instead.${NC}"
        exit 1
    fi
    
    # Get selected agents
    declare -A AGENT_DIRS
    get_selected_agents
    
    # Configure directories for code agents
    configure_directories
    
    # Create structure
    create_structure
    
    # Create project-specific agents
    echo ""
    echo -e "${BLUE}Creating project-specific agents...${NC}"
    for agent in "${SELECTED_AGENTS[@]}"; do
        create_project_agent "$agent"
    done
    
    # Create coordination guide
    create_coordination_guide
    
    # Final summary
    echo ""
    echo -e "${GREEN}=== Setup Complete ===${NC}"
    echo ""
    echo "Project structure created with:"
    echo "- ${#SELECTED_AGENTS[@]} agents configured"
    echo "- Versioned specs and implementations"
    echo "- Project-specific agent configurations"
    echo ""
    echo "Next steps:"
    echo "1. Add your PRD to docs/PRD.md"
    echo "2. Run agents with their project-specific instructions"
    echo "3. Each agent should start by creating specs"
    echo ""
    echo "To add more agents later, use:"
    echo "  orchestrator add agent [agent-name]"
}

# Run main function
main "$@"