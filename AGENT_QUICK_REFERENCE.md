# Agent Quick Reference Guide

## When to Use Each Agent

### 🏗️ PM-Architecture
**Use for:** Project planning, task breakdown, technology selection, orchestration
```bash
Task(description="Plan e-commerce platform", prompt="Create task list from PRD", subagent_type="PM-Architecture")
```

### 💻 Backend-Developer
**Use for:** APIs, databases, server logic, integrations, microservices
```bash
Task(description="Build user API", prompt="Create RESTful API with JWT auth", subagent_type="Backend-Developer")
```

### 🎨 Frontend-Developer  
**Use for:** Web UIs, React/Vue/Angular, responsive design, web performance
```bash
Task(description="Build dashboard", prompt="Create admin dashboard with React", subagent_type="Frontend-Developer")
```

### 📱 Mobile-Developer
**Use for:** iOS/Android apps, React Native, Flutter, mobile optimization
```bash
Task(description="Build iOS app", prompt="Create Swift app with biometric auth", subagent_type="Mobile-Developer")
```

### 🎯 UI/UX
**Use for:** User research, wireframes, prototypes, design systems
```bash
Task(description="Design mobile app", prompt="Create user flow and mockups", subagent_type="UI/UX")
```

### 🤖 Data-Scientist
**Use for:** ML models, A/B testing, predictions, recommendations
```bash
Task(description="Build recommendation engine", prompt="Create collaborative filtering model", subagent_type="Data-Scientist")
```

### 🔧 Data-Engineer
**Use for:** Data pipelines, ETL, warehouses, real-time processing
```bash
Task(description="Build data pipeline", prompt="Create Kafka to Snowflake pipeline", subagent_type="Data-Engineer")
```

### 🚀 DevOps-SRE
**Use for:** CI/CD, infrastructure, monitoring, scaling, reliability
```bash
Task(description="Setup deployment", prompt="Create Kubernetes deployment with autoscaling", subagent_type="DevOps-SRE")
```

### 🔒 Security-Engineer
**Use for:** Security audits, threat modeling, compliance, hardening
```bash
Task(description="Security review", prompt="Audit API for OWASP vulnerabilities", subagent_type="Security-Engineer")
```

### 🧪 QA-Test-Engineer
**Use for:** Test strategies, automation, performance testing, quality gates
```bash
Task(description="Create test suite", prompt="Build E2E tests with Playwright", subagent_type="QA-Test-Engineer")
```

### 📝 PM-PRD
**Use for:** Writing product requirements documents
```bash
Task(description="Write PRD", prompt="Create PRD for social media app", subagent_type="PM-PRD")
```

### ✍️ content-writer
**Use for:** Blog posts, documentation, marketing content
```bash
Task(description="Write blog post", prompt="Explain microservices in simple terms", subagent_type="content-writer")
```

## Common Multi-Agent Patterns

### Full Stack Web App
```bash
PM-Architecture → UI/UX → Backend-Developer + Frontend-Developer → QA-Test-Engineer
```

### Mobile App with Backend
```bash
PM-Architecture → UI/UX → Mobile-Developer + Backend-Developer → QA-Test-Engineer
```

### ML-Powered Application
```bash
PM-Architecture → Data-Scientist → Data-Engineer + Backend-Developer → DevOps-SRE
```

### Security-Critical System
```bash
PM-Architecture → Security-Engineer → Backend-Developer → QA-Test-Engineer → DevOps-SRE
```

## Quick Commands

### Start a new project
```bash
/orchestrate "Build a [describe your project]"
```

### Get architecture help
```bash
Task(description="Architecture review", prompt="Review and improve current architecture", subagent_type="PM-Architecture")
```

### Security audit
```bash
Task(description="Security audit", prompt="Comprehensive security review of codebase", subagent_type="Security-Engineer")
```

### Performance optimization
```bash
Task(description="Optimize performance", prompt="Improve API response times", subagent_type="Backend-Developer")
```

## Tips for Effective Agent Use

1. **Be Specific**: Give agents clear, bounded tasks with defined outputs
2. **Provide Context**: Reference files, previous decisions, and constraints
3. **Use Coordination Files**: Share specs and interfaces between agents
4. **Start Small**: Begin with 2-3 agents, scale up as needed
5. **Monitor Progress**: Check coordination/progress/ regularly

## Agent Expertise Levels

All technical agents are **staff-level** with **15+ years of experience**, ensuring:
- Mature architectural decisions
- Production-ready code
- Industry best practices
- Cross-functional collaboration skills