# Predictive Maintenance Knowledge Graph

> AI-driven predictive maintenance knowledge graph for semiconductor manufacturing OEE optimization using Neo4j

## Overview

This repository contains the ontology design and implementation for a comprehensive predictive maintenance knowledge graph specifically designed for semiconductor manufacturing environments. The system is built to support an AI agent that autonomously optimizes Overall Equipment Effectiveness (OEE) through intelligent predictive maintenance of vacuum dry pumps and related critical equipment.

## Key Features

- **AI Agent-Driven Decision Support** for autonomous predictive maintenance
- **OEE Optimization** targeting quality (wafer scrap reduction) and availability (downtime minimization)
- **Semiconductor Manufacturing Integration** with fab operations and production schedules
- **Automated Risk Assessment Reporting** with stakeholder-specific communication
- **Service Plan Management** for transparent maintenance planning and execution
- **Unscheduled Event Prevention** specifically targeting dry pump crashes

## Repository Structure

```
├── docs/
│   ├── ontology/
│   │   ├── 01-domain-analysis.md
│   │   ├── 02-reuse-analysis.md
│   │   ├── 03-terminology.md
│   │   ├── 04-classes-hierarchy.md
│   │   ├── 05-properties.md
│   │   ├── 06-constraints.md
│   │   └── 07-instances.md
│   ├── implementation/
│   │   ├── neo4j-schema.md
│   │   ├── cypher-queries.md
│   │   └── data-ingestion.md
│   └── ai-agent/
│       ├── decision-framework.md
│       ├── reasoning-rules.md
│       └── learning-mechanisms.md
├── src/
│   ├── ontology/
│   ├── neo4j/
│   └── ai-agent/
└── examples/
    ├── sample-data/
    └── use-cases/
```

## Methodology

This project follows the **7-step iterative ontology development process** based on Noy & McGuinness (2000):

1. **Determine Domain and Focus** 🎯
2. **Consider Reuse** ♻️
3. **Enumerate Terms** 📝
4. **Define Classes** 🏢
5. **Define Properties** 🏷️
6. **Define Constraints** 🔒
7. **Create Instances** 📊

## Quick Start

1. Review the [Domain Analysis](docs/ontology/01-domain-analysis.md) to understand the scope and objectives
2. Explore the [Neo4j Implementation](docs/implementation/neo4j-schema.md) for technical details
3. Check out the [AI Agent Framework](docs/ai-agent/decision-framework.md) for autonomous decision support

## Technology Stack

- **Knowledge Graph**: Neo4j
- **Ontology Modeling**: Based on Noy & McGuinness methodology
- **AI Agent**: Built on the knowledge graph foundation
- **Manufacturing Integration**: SEMI standards, ISA-95 compatibility
- **Reporting**: Automated stakeholder-specific communication

## Contributing

This ontology is designed to be iterative and continuously improved. Please see our contribution guidelines for:
- Domain expert input
- Technical implementation feedback
- Real-world validation results

## Documentation

Comprehensive documentation is available in the `docs/` directory, following the structured ontology development methodology.

---

**Status**: 🚧 In Development

**Current Phase**: Domain Analysis Complete

**Next Steps**: Reuse Analysis and Terminology Development