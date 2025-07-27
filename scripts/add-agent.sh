#!/bin/bash
# Add Agent Script - For adding agents to existing projects
# Used by the Orchestrator agent

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Available agents (same as setup script)
declare -a AGENT_NAMES=(
    "Product-Manager"
    "Designer"
    "Backend-Developer"
    "Frontend-Developer"
    "Mobile-Developer"
    "Data-Engineer"
    "Data-Scientist"
    "DevOps-SRE"
    "QA-Engineer"
    "Security-Engineer"
)

declare -a AGENT_DESCRIPTIONS=(
    "PRD writing and development planning"
    "UI/UX design and user experience"
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
    
    # Check which agents are already added
    local existing_agents=()
    if [[ -d ".claude/agents" ]]; then
        for agent_file in .claude/agents/*.md; do
            if [[ -f "$agent_file" ]]; then
                agent_name=$(basename "$agent_file" .md)
                existing_agents+=("$agent_name")
            fi
        done
    fi
    
    for i in "${!AGENT_NAMES[@]}"; do
        local agent="${AGENT_NAMES[$i]}"
        local desc="${AGENT_DESCRIPTIONS[$i]}"
        local status=""
        
        # Check if already added
        for existing in "${existing_agents[@]}"; do
            if [[ "$agent" == "$existing" ]]; then
                status=" ${GREEN}[Already added]${NC}"
                break
            fi
        done
        
        echo "$((i+1)). $agent - $desc$status"
    done
}

# Function to get seed content
get_seed_content() {
    local seed_content=""
    
    # Read PRD
    if [[ -f "docs/PRD.md" ]]; then
        seed_content="${seed_content}\n### Product Requirements (PRD)\n"
        seed_content="${seed_content}$(head -50 docs/PRD.md)\n"
    fi
    
    # Read Technical Design Doc
    if [[ -f "docs/TDD.md" ]]; then
        seed_content="${seed_content}\n### Technical Design\n"
        seed_content="${seed_content}$(head -50 docs/TDD.md)\n"
    elif [[ -f "docs/TECHNICAL_DESIGN.md" ]]; then
        seed_content="${seed_content}\n### Technical Design\n"
        seed_content="${seed_content}$(head -50 docs/TECHNICAL_DESIGN.md)\n"
    fi
    
    # Read Architecture if exists
    if [[ -f "docs/ARCHITECTURE.md" ]]; then
        seed_content="${seed_content}\n### Architecture Overview\n"
        seed_content="${seed_content}$(head -30 docs/ARCHITECTURE.md)\n"
    fi
    
    # If still empty, look for any PRD/design files
    if [[ -z "$seed_content" ]]; then
        local prd_file=$(find . -name "*PRD*.md" -o -name "*prd*.md" | head -1)
        if [[ -n "$prd_file" ]]; then
            seed_content="### Project Documentation\n"
            seed_content="${seed_content}$(head -50 "$prd_file")\n"
        fi
    fi
    
    echo "$seed_content"
}

# Function to create project-specific agent
create_project_agent() {
    local agent_name=$1
    local code_dir=$2
    
    # Read root agent
    local root_agent_file="$HOME/.claude/agents/$agent_name.md"
    if [[ ! -f "$root_agent_file" ]]; then
        echo -e "${RED}Error: Root agent $agent_name not found${NC}"
        return 1
    fi
    
    # Get seed content
    local seed_content=$(get_seed_content)
    
    # Create directories
    mkdir -p "coordination/specs/$agent_name"
    mkdir -p "coordination/implementations/$agent_name"
    
    # Create progress file
    cat > "coordination/progress/$agent_name.md" << EOF
# $agent_name Progress

## Current Sprint
- [ ] Not started

## Completed Features

## Blocked

## Notes
EOF
    
    # Create code directory if needed
    if [[ -n "$code_dir" ]]; then
        mkdir -p "$code_dir"
        echo "Created code directory: $code_dir/"
    fi
    
    # Create project-specific agent
    cat > ".claude/agents/$agent_name.md" << EOF
$(cat "$root_agent_file")

## Project-Specific Context

This agent is configured for this specific project.

### Project Context
$seed_content

### Project-Specific Knowledge
*This section will be updated by the agent at important milestones*

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
1. **Design First**: Create spec in \`coordination/specs/$agent_name/v1.0-[feature].md\`
2. **Implement**: Build in your code directory$(if [[ -n "$code_dir" ]]; then echo " (\`$code_dir/\`)"; fi)
3. **Document**: Update \`coordination/implementations/$agent_name/v1.0-[feature].md\`
4. **Track**: Update \`coordination/progress/$agent_name.md\`
5. **Self-Update**: Update this agent file at important milestones with key decisions

### Git Workflow
\`\`\`bash
# Only commit files you own
git add$(if [[ -n "$code_dir" ]]; then echo " $code_dir/"; fi) coordination/specs/$agent_name/ coordination/implementations/$agent_name/ coordination/progress/$agent_name.md
git commit -m '$(echo $agent_name | tr '[:upper:]' '[:lower:]' | cut -d'-' -f1): [descriptive message]'
\`\`\`

### Versioning Convention
- Initial spec: \`v1.0-feature.md\`
- Minor updates: \`v1.1-feature.md\`
- Patches: \`v1.1.1-feature.md\`
- Implementation versions must match spec versions
- Version prefix ensures files sort chronologically

### When to Self-Update This Agent File
Update the "Project-Specific Knowledge" section when:
- Making architectural decisions that affect the whole project
- Creating important APIs or interfaces
- Discovering critical business rules or constraints
- Establishing integration patterns with other agents
- Learning domain-specific requirements

This helps future sessions remember important context without searching through all files.
EOF
    
    echo -e "${GREEN}✓ Added agent: $agent_name${NC}"
}

# Main function
main() {
    echo -e "${BLUE}=== Add Agent to Existing Project ===${NC}"
    echo ""
    
    # Check if this is an existing project
    if [[ ! -d "coordination" ]]; then
        echo -e "${RED}Error: No coordination directory found.${NC}"
        echo "Please run setup-orchestration.sh first to initialize the project."
        exit 1
    fi
    
    # Display available agents
    display_agents
    echo ""
    
    # Get agent selection
    echo -e "${YELLOW}Which agent would you like to add? (Enter number or agent name)${NC}"
    read -p "> " selection
    
    # Parse selection
    local selected_agent=""
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "${#AGENT_NAMES[@]}" ]; then
        selected_agent="${AGENT_NAMES[$((selection-1))]}"
    else
        # Check if it's a valid agent name
        for agent in "${AGENT_NAMES[@]}"; do
            if [[ "$agent" == "$selection" ]]; then
                selected_agent="$agent"
                break
            fi
        done
    fi
    
    if [[ -z "$selected_agent" ]]; then
        echo -e "${RED}Invalid selection${NC}"
        exit 1
    fi
    
    # Check if already exists
    if [[ -f ".claude/agents/$selected_agent.md" ]]; then
        echo -e "${YELLOW}Agent $selected_agent already exists in this project.${NC}"
        read -p "Do you want to update it? (y/n): " update_choice
        if [[ "$update_choice" != "y" ]]; then
            exit 0
        fi
    fi
    
    # Configure directory if needed
    local code_dir=""
    if needs_code_dir "$selected_agent"; then
        default_dir="${DEFAULT_DIRS[$selected_agent]}"
        echo ""
        read -p "$selected_agent directory [default: $default_dir]: " custom_dir
        if [[ -z "$custom_dir" ]]; then
            code_dir="$default_dir"
        else
            code_dir="$custom_dir"
        fi
    fi
    
    # Create the agent
    create_project_agent "$selected_agent" "$code_dir"
    
    # Summary
    echo ""
    echo -e "${GREEN}=== Agent Added Successfully ===${NC}"
    echo ""
    echo "The $selected_agent agent has been configured for this project."
    echo ""
    echo "Next steps:"
    echo "1. Review the agent configuration in .claude/agents/$selected_agent.md"
    echo "2. Start using the agent with project-specific context"
    echo "3. The agent should begin by creating specs in coordination/specs/$selected_agent/"
}

# Run main
main "$@"