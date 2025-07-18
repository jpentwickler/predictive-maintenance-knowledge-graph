# Predictive Maintenance Knowledge Graph

> AI-driven predictive maintenance knowledge graph for semiconductor manufacturing OEE optimization using Neo4j

## Overview

This repository contains the ontology design and implementation for a comprehensive predictive maintenance knowledge graph specifically designed for semiconductor manufacturing environments. The system is built to support an AI agent that autonomously optimizes Overall Equipment Effectiveness (OEE) through intelligent predictive maintenance of vacuum dry pumps and related critical equipment.

## Key Features

- **30-Day Failure Probability Calculation** using survival analysis and condition monitoring
- **Weibull Survival Modeling** for historical lifetime analysis of pump populations
- **Real-time Health Index Assessment** from telemetry and sensor data
- **Blended Hazard Analysis** combining survival functions with condition monitoring
- **AI Agent-Driven Decision Support** for autonomous predictive maintenance
- **Semiconductor Manufacturing Integration** with fab operations and production schedules
- **Automated Probability Reporting** with stakeholder-specific communication

## Mathematical Foundation

The system combines two complementary approaches for optimal prediction accuracy:

```
30-Day Failure Probability = f(Survival_Function(t), Health_Index(t), Hazard_Rate(t))

Where:
- Survival_Function(t): Weibull-based historical lifetime model
- Health_Index(t): Real-time telemetry degradation assessment  
- Hazard_Rate(t): Instantaneous failure rate at time t
- t = current pump age + 30 days
```

## Repository Structure

```
├── docs/
│   ├── ontology/
│   │   ├── 01-domain-analysis.md
│   │   ├── 02-reuse-analysis.md
│   │   ├── 03-terminology.md ✅ (Updated - Survival Analysis Focus)
│   │   ├── 04-classes-hierarchy.md (Next)
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

1. **Determine Domain and Focus** 🎯 ✅ Complete
2. **Consider Reuse** ♻️ ✅ Complete
3. **Enumerate Terms** 📝 ✅ **Updated - Survival Analysis & Condition Monitoring**
4. **Define Classes** 🏢 🚧 In Progress
5. **Define Properties** 🏷️
6. **Define Constraints** 🔒
7. **Create Instances** 📊

## Current Focus: Survival Analysis & Condition Monitoring

The ontology has been redesigned to prioritize mathematical foundations for 30-day failure probability calculation:

### **Core Innovation Areas**:
- **Weibull Survival Functions**: Historical lifetime modeling for pump populations
- **Health Index Calculation**: Real-time degradation assessment from telemetry
- **Blended Hazard Rates**: Combining survival and condition monitoring data
- **30-Day Prediction Window**: Specific horizon for maintenance planning

### **Minimal External Dependencies**:
- 80% custom domain terminology
- 20% essential standards (SOSA/SSN sensors, OWL-Time, QUDT units)

## Quick Start

1. Review the [Domain Analysis](docs/ontology/01-domain-analysis.md) to understand the scope and objectives
2. Explore the [Reuse Analysis](docs/ontology/02-reuse-analysis.md) for ontology selection rationale
3. **NEW**: Study the [Survival Analysis Terminology](docs/ontology/03-terminology.md) for mathematical foundations
4. Check out the [Neo4j Implementation](docs/implementation/neo4j-schema.md) for technical details (coming soon)

## Technology Stack

- **Knowledge Graph**: Neo4j
- **Mathematical Foundation**: Weibull survival analysis + Health index monitoring
- **Ontology Modeling**: Based on Noy & McGuinness methodology
- **AI Agent**: Built on survival analysis and condition monitoring calculations
- **Manufacturing Integration**: SEMI standards, ISA-95 compatibility
- **Reporting**: Automated 30-day failure probability reports

## Core Use Case

**Target Output**: The AI agent generates regular reports showing every dry pump and its corresponding probability of failure in the next 30 days.

**Mathematical Approach**: 
1. Estimate Weibull parameters from historical failure data
2. Calculate current health index from real-time telemetry
3. Blend survival hazard with condition hazard  
4. Compute 30-day failure probability for each pump
5. Generate actionable maintenance recommendations

## Implementation Priorities

### **Phase 1: Survival Foundation** (Current)
- Weibull parameter estimation from historical data
- Basic survival function calculation
- Pump-specific lifetime modeling

### **Phase 2: Condition Integration** (Next)
- Health index calculation from telemetry
- Real-time condition assessment
- Trend analysis and degradation detection

### **Phase 3: Blended Prediction** (Core Goal)
- Combine survival and condition hazards
- 30-day failure probability calculation
- Automated report generation for AI agent

## Contributing

This ontology is designed to be iterative and continuously improved. Please see our contribution guidelines for:
- Domain expert input on survival analysis modeling
- Technical implementation feedback on health index calculations
- Real-world validation results from semiconductor fabs

## Documentation

Comprehensive documentation is available in the `docs/` directory, following the structured ontology development methodology with emphasis on mathematical foundations.

---

**Status**: 🚧 In Development - Step 3 Complete (Survival Analysis Terminology)

**Current Phase**: Terminology Development Complete - Mathematical Foundation Established

**Next Steps**: Step 4 - Define Classes (Mathematical Class Hierarchy)

**Last Updated**: July 18, 2025