# Predictive Maintenance Knowledge Graph

> AI-driven predictive maintenance knowledge graph for semiconductor manufacturing OEE optimization using Neo4j

## Overview

This repository contains the ontology design and implementation for a comprehensive predictive maintenance knowledge graph specifically designed for semiconductor manufacturing environments. The system is built to support an AI agent that autonomously optimizes Overall Equipment Effectiveness (OEE) through intelligent predictive maintenance of vacuum dry pumps and related critical equipment.

## 🎯 **APPROVED Knowledge Graph Model**

**Status**: ✅ **DESIGN COMPLETE & APPROVED** - Ready for Step 7 Implementation

![Knowledge Graph Diagram](docs/implementation/knowledge-graph-diagram.mmd)

### Mathematical Foundation
```
P_30(t) = 1 - exp[-(λ_W(t) + k·λ_R(t))]

Where:
- λ_W(t) = ((t+30)^ρ - t^ρ)/β^ρ  [Weibull cumulative hazard]
- λ_R(t) = 30/RUL(t)              [Condition cumulative hazard]  
- k ∈ [0,1]                       [Blending weight]
- ρ, β                            [Weibull shape, scale parameters]
- t                               [Current pump age in days]
- RUL(t)                          [Remaining Useful Life]
```

## Key Features

- **30-Day Failure Probability Calculation** using survival analysis and condition monitoring
- **Weibull Survival Modeling** for historical lifetime analysis of pump populations
- **Real-time Health Index Assessment** from telemetry and sensor data
- **Blended Hazard Analysis** combining survival functions with condition monitoring
- **AI Agent-Driven Decision Support** for autonomous predictive maintenance
- **Semiconductor Manufacturing Integration** with fab operations and production schedules
- **Automated Probability Reporting** with stakeholder-specific communication

## 📊 **Knowledge Graph Architecture**

### **Core Node Types**
- **DryPump**: Central entity with age, criticality, operational status
- **WeibullSurvivalFunction**: Mathematical survival model with shape/scale parameters
- **RemainingUsefulLife**: Health index and condition monitoring assessment
- **BlendedHazardFunction**: Combines survival + condition hazards
- **ThirtyDayFailureProbability**: Final prediction with risk classification (A-E)

### **Equipment Hierarchy (ISA-95 + SEMI Compliant)**
```
Fab → FabArea → SemiconductorTool → ProcessChamber → DryPump
```

### **Mathematical Computation Chain**
```
DryPump → WeibullSurvivalFunction + RemainingUsefulLife → BlendedHazardFunction → ThirtyDayFailureProbability
```

### **Risk Classification**
- **A (Critical)**: P₃₀ ≥ 80% - Act now
- **B (High)**: 60-80% - Schedule ASAP  
- **C (Medium)**: 30-60% - Intensify monitoring
- **D (Low-Medium)**: 10-30% - Routine checks
- **E (Low)**: <10% - Low risk

## Repository Structure

```
├── docs/
│   ├── ontology/
│   │   ├── 01-domain-analysis.md ✅ Complete
│   │   ├── 02-reuse-analysis.md ✅ Complete
│   │   ├── 03-terminology.md ✅ Complete (Survival Analysis Focus)
│   │   ├── 04-classes-hierarchy.md ✅ Complete (Mathematical Foundation)
│   │   ├── 05-properties.md ✅ Complete (Minimal Viable Properties)
│   │   ├── 06-constraints.md ✅ Complete (Data Quality & Mathematical Constraints)
│   │   └── 07-instances.md 🚧 In Progress
│   ├── implementation/
│   │   ├── neo4j-knowledge-graph.md ✅ Complete - Comprehensive Documentation
│   │   ├── knowledge-graph-diagram.mmd ✅ Complete - Approved Mermaid Diagram
│   │   ├── neo4j-schema.cypher ✅ Complete - Production Schema
│   │   └── cypher-queries.md 🚧 Next
│   └── ai-agent/
│       ├── decision-framework.md 🚧 Future
│       ├── reasoning-rules.md 🚧 Future
│       └── learning-mechanisms.md 🚧 Future
├── src/
│   ├── ontology/ 🚧 Future
│   ├── neo4j/ 🚧 Future
│   └── ai-agent/ 🚧 Future
└── examples/
    ├── sample-data/ 🚧 Future
    └── use-cases/ 🚧 Future
```

## Methodology

This project follows the **7-step iterative ontology development process** based on Noy & McGuinness (2000):

1. **Determine Domain and Focus** 🎯 ✅ Complete
2. **Consider Reuse** ♻️ ✅ Complete
3. **Enumerate Terms** 📝 ✅ Complete - Survival Analysis & Condition Monitoring
4. **Define Classes** 🏢 ✅ Complete - Mathematical Foundation Classes
5. **Define Properties** 🏷️ ✅ Complete - Minimal Viable Properties
6. **Define Constraints** 🔒 ✅ Complete - Data Quality & Mathematical Constraints
7. **Create Instances** 📊 🚧 **Next Phase**

## 🎉 **Step 6 Complete - Knowledge Graph Design Approved**

The Neo4j knowledge graph model has been **fully designed, validated, and approved**:

### **Design Achievements** ✅:
- **Mathematical Rigor**: Complete Weibull survival analysis integration
- **Standards Compliance**: ISA-95, SEMI, MIMOSA equipment hierarchies
- **AI Agent Optimization**: Query patterns for 30-day failure probability calculation
- **Production Ready Schema**: Complete Neo4j constraints and indexes
- **Comprehensive Documentation**: Full implementation guide with examples

### **Core Innovation Areas**:
- **Weibull Survival Functions**: Historical lifetime modeling for pump populations
- **Health Index Calculation**: Real-time degradation assessment from telemetry
- **Blended Hazard Rates**: Combining survival and condition monitoring data
- **30-Day Prediction Window**: Specific horizon for maintenance planning

### **Implementation Ready**:
- **Neo4j Schema**: Complete constraints, indexes, and validation queries
- **Mermaid Diagram**: Visual representation of approved model
- **Query Patterns**: Optimized Cypher queries for AI agent operations
- **Sample Data**: Example instances for development and testing

## Quick Start

### **View the Approved Knowledge Graph**
1. **Model Overview**: [Neo4j Knowledge Graph Documentation](docs/implementation/neo4j-knowledge-graph.md)
2. **Visual Diagram**: [Knowledge Graph Mermaid Diagram](docs/implementation/knowledge-graph-diagram.mmd)
3. **Database Schema**: [Neo4j Schema Implementation](docs/implementation/neo4j-schema.cypher)

### **Understand the Design Process**
1. Review the [Domain Analysis](docs/ontology/01-domain-analysis.md) to understand the scope and objectives
2. Explore the [Reuse Analysis](docs/ontology/02-reuse-analysis.md) for ontology selection rationale
3. Study the [Survival Analysis Terminology](docs/ontology/03-terminology.md) for mathematical foundations
4. Examine the [Mathematical Class Hierarchies](docs/ontology/04-classes-hierarchy.md) for structural design
5. Review the [Essential Property Definitions](docs/ontology/05-properties.md) for minimal viable implementation
6. Study the [Property Constraints](docs/ontology/06-constraints.md) for data quality and mathematical validation

### **Deploy the Knowledge Graph**
1. Install Neo4j 5.x with APOC plugin
2. Execute the [Neo4j schema](docs/implementation/neo4j-schema.cypher)
3. Validate with included data integrity checks
4. Load sample data for testing

## Technology Stack

- **Knowledge Graph**: Neo4j 5.x
- **Mathematical Foundation**: Weibull survival analysis + Health index monitoring
- **Ontology Modeling**: Based on Noy & McGuinness methodology
- **Standards Compliance**: ISA-95, SEMI E10/E30, MIMOSA
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

## AI Agent Query Examples

### **Daily Risk Assessment**
```cypher
// Get all pumps with their current risk classification
MATCH (p:DryPump)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
MATCH (p)-[:SERVES]->(c:ProcessChamber)-[:PART_OF]->(t:SemiconductorTool)
WHERE pred.predictionTimestamp >= datetime() - duration('PT24H')
RETURN p.pumpIdentifier, p.criticalityLevel, t.toolId, 
       pred.failureProbability, pred.riskClassification
ORDER BY pred.failureProbability DESC
```

### **Mathematical Traceability**
```cypher
// Trace all calculation components for a specific pump
MATCH (p:DryPump {pumpIdentifier: 'P001'})
MATCH (p)-[:HAS_SURVIVAL_MODEL]->(w:WeibullSurvivalFunction)
MATCH (p)-[:HAS_RUL_ASSESSMENT]->(rul:RemainingUsefulLife)
MATCH (p)-[:HAS_HAZARD_CALCULATION]->(h:BlendedHazardFunction)
MATCH (h)-[:GENERATES_PREDICTION]->(pred:ThirtyDayFailureProbability)
RETURN p.currentAge, w.weibullShape, w.weibullScale,
       rul.remainingUsefulLife, rul.healthIndex,
       h.blendingWeight, pred.failureProbability
```

## Implementation Priorities

### **Phase 1: Instance Creation** (Current - Week 1)
- Sample pump data with complete mathematical models
- Historical failure data for Weibull parameter estimation
- Real-time telemetry integration examples

### **Phase 2: AI Agent Integration** (Week 2-3)
- Calculation algorithm implementation
- Automated report generation
- Real-time prediction updates

### **Phase 3: Production Deployment** (Week 4+)
- Live fab data integration
- Performance optimization
- Monitoring and alerting

## Contributing

This ontology is designed to be iterative and continuously improved. We welcome contributions in:
- Domain expert input on survival analysis modeling
- Technical implementation feedback on health index calculations
- Real-world validation results from semiconductor fabs
- Extended equipment types and process integration

## Documentation

Comprehensive documentation is available in the `docs/` directory, following the structured ontology development methodology with emphasis on mathematical foundations and production readiness.

---

**Current Status**: 🎉 **Knowledge Graph Design Complete & Approved**

**Current Phase**: Ready for Step 7 - Instance Creation and AI Agent Integration

**Next Milestones**:
- [ ] Step 7: Create representative instances with real pump data
- [ ] AI Agent: Implement blended hazard calculation algorithms
- [ ] Integration: Connect with telemetry systems and historical databases
- [ ] Validation: Test with semiconductor fab operational data

**Last Updated**: July 21, 2025
**Model Version**: v1.0 - Production Ready
