# Knowledge Graph Examples

> **Purpose**: Comprehensive examples demonstrating Step 7 (Create Instances) of the Ontology Development Process
> 
> **Status**: Production Ready
> 
> **Last Updated**: July 21, 2025

This directory contains complete, real-world examples of knowledge graph instances for the predictive maintenance system. Each example demonstrates all entities, relationships, and mathematical models working together to generate 30-day failure probability predictions for vacuum dry pumps.

## 📋 Available Examples

### [Pump P002 - Pfeiffer HiPace 700](./pump-p002/)
**Complete knowledge graph instance for a Level5 criticality pump**

| Attribute | Value | Description |
|-----------|-------|-------------|
| **Pump Model** | Pfeiffer HiPace 700 | High-performance turbo molecular pump |
| **Location** | FAB2 Dresden → CVD_DEPOSITION → PECVD_05 → CH2 | Complete equipment hierarchy |
| **Criticality** | Level5 | Highest business criticality |
| **Current Risk** | 13.6% (Class D) | Medium risk, continuous monitoring |
| **Process Impact** | Silicon Nitride CVD | Critical for 7nm technology node |
| **Mathematical Models** | Weibull + RUL + Blended Hazard | Complete survival analysis chain |

**Files Included:**
- 📄 [`README.md`](./pump-p002/README.md) - Comprehensive documentation of all nodes and relationships
- 💾 [`create-p002-instance.cypher`](./pump-p002/create-p002-instance.cypher) - Complete Cypher script to create the instance
- 📊 [`knowledge-graph-visualization.md`](./pump-p002/knowledge-graph-visualization.md) - Visual representation and mathematical flow

**Key Features Demonstrated:**
- ✅ Complete equipment hierarchy (5 levels: Fab → Area → Tool → Chamber → Pump)
- ✅ Mathematical model integration (Weibull survival analysis + condition monitoring)
- ✅ Process criticality mapping (CVD process impact assessment)
- ✅ Real-time telemetry integration (vibration, temperature, vacuum performance)
- ✅ AI agent reporting (automated maintenance recommendations)
- ✅ Mathematical consistency verification (blended hazard calculation)

## 🚀 Quick Start

### Prerequisites
- Neo4j 5.x database running
- APOC plugin installed
- Schema deployed from [`/docs/implementation/neo4j-schema.cypher`](../docs/implementation/neo4j-schema.cypher)

### Deployment Steps
1. **Deploy Schema First**
   ```bash
   # Execute the main schema file
   cat ../docs/implementation/neo4j-schema.cypher | cypher-shell
   ```

2. **Create P002 Instance**
   ```bash
   # Execute the P002 example
   cat pump-p002/create-p002-instance.cypher | cypher-shell
   ```

3. **Verify Deployment**
   ```cypher
   // Quick verification query
   MATCH (p:DryPump {pumpIdentifier: "P002"})-[:HAS_FAILURE_PREDICTION]->(pred)
   RETURN p.pumpIdentifier, pred.failureProbability, pred.riskClassification
   ```

## 🧮 Mathematical Foundation

All examples demonstrate the complete mathematical foundation for 30-day failure probability calculation:

### **Weibull Survival Analysis**
```
Historical lifetime modeling using 2-parameter Weibull distribution
Hazard Function: λ_W(t) = (β/η) × (t/η)^(β-1)
```

### **Condition Monitoring**
```
Real-time health assessment using telemetry fusion
Condition Hazard: λ_R(t) = PredictionHorizon / RUL(t)
```

### **Blended Hazard Calculation**
```
Combines both approaches for robust prediction
H_30(t) = λ_W(t) + k × λ_R(t)
```

### **Failure Probability Conversion**
```
Converts hazard to interpretable probability
P_30(t) = 1 - exp(-H_30(t))
```

## 🏭 Business Value Demonstration

Each example showcases key business value propositions:

### **Predictive Maintenance**
- **Early Warning**: Detect potential failures weeks in advance
- **Risk Quantification**: Convert complex analytics to actionable risk levels
- **Confidence Intervals**: Provide uncertainty bounds for decision making

### **Operational Excellence**
- **Equipment Hierarchy**: Full traceability from fab to component level
- **Process Integration**: Direct linkage to manufacturing process impact
- **Real-time Monitoring**: Continuous telemetry-based health assessment

### **Cost Optimization**
- **Condition-based Maintenance**: Replace calendar-based with data-driven schedules
- **Unplanned Downtime Prevention**: Avoid costly emergency repairs
- **Resource Optimization**: Focus maintenance efforts on highest-risk equipment

## 📊 Query Pattern Examples

### **Risk Assessment Dashboard**
```cypher
// Get current risk status for all pumps
MATCH (p:DryPump)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
WHERE pred.predictionTimestamp >= datetime() - duration('PT24H')
RETURN p.pumpIdentifier, p.criticalityLevel, 
       pred.failureProbability, pred.riskClassification
ORDER BY pred.failureProbability DESC
```

### **Mathematical Model Traceability**
```cypher
// Trace calculation components for specific pump
MATCH (p:DryPump {pumpIdentifier: "P002"})-[:HAS_HAZARD_CALCULATION]->(h:BlendedHazardFunction)
MATCH (h)-[:CALCULATED_FROM_SURVIVAL]->(w:WeibullSurvivalFunction)
MATCH (h)-[:CALCULATED_FROM_RUL]->(r:RemainingUsefulLife)
MATCH (h)-[:GENERATES_PREDICTION]->(pred:ThirtyDayFailureProbability)
RETURN w.weibullShape, w.weibullScale, w.parameterConfidence,
       r.remainingUsefulLife, r.healthIndex, r.dataQualityScore,
       h.blendingWeight, h.weibullHazard, h.conditionHazard, h.blendedHazard,
       pred.failureProbability, pred.confidenceLevel
```

### **Business Impact Analysis**
```cypher
// Assess business impact of pump failures
MATCH (p:DryPump)-[:CRITICAL_FOR]->(proc:SemiconductorProcess)
MATCH (p)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
MATCH (p)-[:SERVES]->(c:ProcessChamber)-[:PART_OF]->(t:SemiconductorTool)
WHERE pred.riskClassification IN ['A', 'B', 'C']
RETURN p.pumpIdentifier, proc.processName, proc.yieldImpact,
       t.utilization, pred.failureProbability, pred.businessImpactScore
ORDER BY pred.businessImpactScore DESC
```

## 🔧 Development Guidelines

### **Adding New Examples**
1. Create a new subdirectory: `examples/pump-{id}/`
2. Include the three core files:
   - `README.md` - Comprehensive documentation
   - `create-{id}-instance.cypher` - Complete creation script
   - `knowledge-graph-visualization.md` - Visual representation
3. Update this index README with the new example

### **Validation Requirements**
- ✅ Mathematical consistency (hazard calculation verification)
- ✅ Complete entity coverage (all 12 node types represented)
- ✅ Relationship completeness (all 15 relationship types included)
- ✅ Business context (realistic equipment hierarchy and process impact)
- ✅ Query pattern demonstration (at least 3 different query types)

### **Documentation Standards**
- Comprehensive property documentation with business context
- Mathematical formula explanations with example calculations
- Query pattern examples for common use cases
- Visual diagrams showing knowledge graph structure
- Deployment and verification instructions

## 📈 Future Examples

**Planned additions:**
- **High-Risk Pump**: Example with >80% failure probability (Risk Class A)
- **Backup Pump Configuration**: Multiple pumps serving single chamber
- **Multi-Chamber Tool**: Complex tool with multiple process chambers
- **Cross-Fab Analysis**: Pumps across multiple fabrication facilities
- **Historical Failure Case**: Post-mortem analysis of actual pump failure

## 📞 Support

For questions about these examples:
1. Review the comprehensive documentation in each example directory
2. Check the mathematical model validation queries
3. Verify Neo4j schema deployment is complete
4. Consult the main project documentation in `/docs/`

---

**Examples Status**: ✅ Production Ready  
**Last Validated**: July 21, 2025  
**Model Version**: v1.0  
**Total Examples**: 1 (P002)
