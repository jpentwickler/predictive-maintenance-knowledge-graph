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
│   │   ├── 01-domain-analysis.md ✅
│   │   ├── 02-reuse-analysis.md ✅
│   │   ├── 03-terminology.md ✅ (Survival Analysis Focus)
│   │   ├── 04-classes-hierarchy.md ✅ (Mathematical Foundation)
│   │   ├── 05-properties.md ✅ (Minimal Viable Properties)
│   │   ├── 06-constraints.md ✅ (Data Quality & Mathematical Constraints)
│   │   └── 07-instances.md (Next)
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
3. **Enumerate Terms** 📝 ✅ Complete - Survival Analysis & Condition Monitoring
4. **Define Classes** 🏢 ✅ Complete - Mathematical Foundation Classes
5. **Define Properties** 🏷️ ✅ Complete - Minimal Viable Properties
6. **Define Constraints** 🔒 ✅ **Complete - Data Quality & Mathematical Constraints**
7. **Create Instances** 📊 🚧 In Progress

## Current Focus: Step 6 Complete - Property Constraints

The ontology now has comprehensive constraint definitions ensuring reliable 30-day failure probability calculations:

### **Step 6 Achievements** ✅:
- **Mathematical Constraints**: Weibull parameter validation, probability bounds, blending weight limits
- **Data Quality Constraints**: RUL validation, health index bounds (0=nominal, 1=degraded), data freshness requirements
- **Business Logic Constraints**: Risk classification consistency (A=≥80%, E=<10%), criticality validation, service role enforcement
- **Temporal Constraints**: Age validation, prediction window logic, timestamp ordering
- **Report Integrity**: Complete report requirements, calculation traceability, assessment completeness
- **Neo4j Implementation**: Database constraints with Cypher syntax for immediate deployment

### **Risk Classification (Corrected)**:
- **A (Critical)**: P₃₀ ≥ 80% - Act now
- **B (High)**: 60-80% - Schedule ASAP
- **C (Medium)**: 30-60% - Intensify monitoring
- **D (Low-Medium)**: 10-30% - Routine checks
- **E (Low)**: <10% - Low risk

### **Health Index Interpretation (Corrected)**:
- **0**: Nominal/baseline behavior (healthy operation)
- **1**: Extreme anomaly/maximal degradation

### **Constraint Categories**:
- **25 specific constraints** covering mathematical validation, data completeness, business logic, temporal consistency, report integrity, and data quality
- **3 priority levels**: Critical (system breaking), Important (business logic), Recommended (quality assurance)
- **Phased implementation strategy** for systematic deployment

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
3. Study the [Survival Analysis Terminology](docs/ontology/03-terminology.md) for mathematical foundations
4. Examine the [Mathematical Class Hierarchies](docs/ontology/04-classes-hierarchy.md) for structural design
5. Review the [Essential Property Definitions](docs/ontology/05-properties.md) for minimal viable implementation
6. **NEW**: Study the [Property Constraints](docs/ontology/06-constraints.md) for data quality and mathematical validation
7. Check out the [Neo4j Implementation](docs/implementation/neo4j-schema.md) for technical details (coming soon)

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

### **Phase 1: Mathematical Foundation** ✅ Complete
- Weibull survival function classes
- Equipment hierarchy with ISA-95/SEMI compliance
- Mathematical computation classes for AI agent

### **Phase 2: Properties & Relationships** ✅ Complete
- Essential mathematical properties for survival analysis
- Temporal properties for 30-day prediction windows
- Equipment identity and condition monitoring properties

### **Phase 3: Constraints & Validation** ✅ Complete
- Mathematical constraints for model parameters
- Data quality constraints for telemetry
- Business logic constraints for criticality assessment

### **Phase 4: Instance Population** (Current)
- Real pump data ingestion
- Historical failure data modeling
- Live telemetry integration

## Contributing

This ontology is designed to be iterative and continuously improved. Please see our contribution guidelines for:
- Domain expert input on survival analysis modeling
- Technical implementation feedback on health index calculations
- Real-world validation results from semiconductor fabs

## Documentation

Comprehensive documentation is available in the `docs/` directory, following the structured ontology development methodology with emphasis on mathematical foundations.

---

**Status**: 🚧 In Development - Step 6 Complete (Property Constraints)

**Current Phase**: Constraint Definition Complete - Ready for Instance Creation

**Next Steps**: Step 7 - Create Instances (Sample pump data and risk assessments)

**Last Updated**: July 20, 2025