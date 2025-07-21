# Pump P002 Knowledge Graph Instance Documentation

> **Purpose**: Complete documentation of the P002 pump instance demonstrating all nodes and relationships in the predictive maintenance knowledge graph
> 
> **Instance ID**: P002 (Pfeiffer HiPace 700)
> 
> **Date**: July 21, 2025
> 
> **Status**: Production Example

## Overview

This document describes the complete knowledge graph instance for vacuum dry pump P002, which serves as a comprehensive example of Step 7 (Create Instances) in the Ontology Development Process. The instance demonstrates all entity types, relationships, and mathematical models used for 30-day failure probability prediction.

## Business Context

**Pump P002** is a **Level5 criticality** Pfeiffer HiPace 700 turbo molecular pump serving silicon nitride CVD processes in FAB2 Dresden. The pump shows signs of degradation with a current **13.6% failure probability** (Risk Class D) and requires continuous monitoring.

### Key Metrics
- **Current Age**: 285 days since installation
- **Remaining Useful Life**: 142 days
- **Health Index**: 0.28 (degrading condition)
- **30-Day Failure Probability**: 13.6% (Risk Class D)
- **Business Impact**: High criticality for 7nm silicon nitride deposition

## Knowledge Graph Structure

### Node Inventory (12 Entities)

| Node Type | Count | Key Properties | Purpose |
|-----------|-------|----------------|---------|
| `Fab` | 1 | fabId: "FAB2" | Fabrication facility |
| `FabArea` | 1 | areaId: "CVD_DEPOSITION" | Cleanroom area |
| `SemiconductorTool` | 1 | toolId: "PECVD_05" | Manufacturing tool |
| `ProcessChamber` | 1 | chamberId: "CH2" | Process environment |
| `DryPump` | 1 | pumpIdentifier: "P002" | **Main entity** |
| `WeibullSurvivalFunction` | 1 | modelId: "WEIBULL_P002_v2.1" | Historical lifetime model |
| `RemainingUsefulLife` | 1 | rulId: "RUL_P002_20250721" | Condition assessment |
| `BlendedHazardFunction` | 1 | hazardId: "HAZARD_P002_20250721" | Hazard calculation |
| `ThirtyDayFailureProbability` | 1 | predictionId: "PRED_P002_20250721" | Final prediction |
| `SemiconductorProcess` | 1 | processId: "CVD_SILICON_NITRIDE" | Manufacturing process |
| `ProcessRecipe` | 1 | recipeId: "CVD_SiN_V3.2" | Process recipe |
| `MaintenanceReport` | 1 | reportId: "RPT_20250721_002" | AI agent output |

### Relationship Inventory (15 Relationships)

| Relationship | From → To | Properties | Purpose |
|--------------|-----------|------------|---------|
| `CONTAINS` | Fab → FabArea | containmentType | Physical hierarchy |
| `LOCATED_IN` | SemiconductorTool → FabArea | locationDate | Physical location |
| `PART_OF` | ProcessChamber → SemiconductorTool | installDate | Physical hierarchy |
| `SERVES` | DryPump → ProcessChamber | isPrimary, connectionType | Service relationship |
| `HAS_SURVIVAL_MODEL` | DryPump → WeibullSurvivalFunction | isActive, modelVersion | Mathematical model |
| `HAS_RUL_ASSESSMENT` | DryPump → RemainingUsefulLife | assessmentTimestamp | Condition monitoring |
| `HAS_HAZARD_CALCULATION` | DryPump → BlendedHazardFunction | calculationId | Hazard calculation |
| `HAS_FAILURE_PREDICTION` | DryPump → ThirtyDayFailureProbability | calculationDuration | Final prediction |
| `CALCULATED_FROM_SURVIVAL` | BlendedHazardFunction → WeibullSurvivalFunction | contributionWeight | Mathematical traceability |
| `CALCULATED_FROM_RUL` | BlendedHazardFunction → RemainingUsefulLife | contributionWeight | Mathematical traceability |
| `GENERATES_PREDICTION` | BlendedHazardFunction → ThirtyDayFailureProbability | conversionFormula | Mathematical traceability |
| `EXECUTES` | ProcessChamber → ProcessRecipe | - | Process execution |
| `PART_OF_PROCESS` | ProcessRecipe → SemiconductorProcess | - | Process hierarchy |
| `CRITICAL_FOR` | DryPump → SemiconductorProcess | impactLevel | Business criticality |
| `INCLUDES_PUMP` | MaintenanceReport → DryPump | - | Reporting |
| `INCLUDES_PREDICTION` | MaintenanceReport → ThirtyDayFailureProbability | - | Reporting |

## Detailed Node Descriptions

### 🏭 **Equipment Hierarchy Nodes**

#### **Fab (FAB2)**
```cypher
fabId: "FAB2"
fabLocation: "Dresden, Germany"
fabCapacity: 75000  // wafers per month
operationalStatus: "ACTIVE"
startupDate: datetime("2023-01-15T00:00:00Z")
```
**Purpose**: Represents the semiconductor fabrication facility in Dresden with 75,000 wafer monthly capacity.

#### **FabArea (CVD_DEPOSITION)**
```cypher
areaId: "CVD_DEPOSITION"
areaType: "WetProcessArea"
cleanClass: "ISO4"
temperature: 22.5      // °C
humidity: 45.2         // %
particleCount: 850     // particles/ft³
```
**Purpose**: ISO4 cleanroom area dedicated to chemical vapor deposition processes.

#### **SemiconductorTool (PECVD_05)**
```cypher
toolId: "PECVD_05"
toolType: "Deposition"
toolModel: "Applied Materials Producer GT"
toolState: "PRODUCTIVE"  // SEMI E10 state
manufacturer: "Applied Materials"
utilization: 0.87       // 87% utilization
toolCapacity: 150       // wafers per hour
```
**Purpose**: Applied Materials PECVD tool for plasma-enhanced chemical vapor deposition.

#### **ProcessChamber (CH2)**
```cypher
chamberId: "CH2"
chamberType: "Process"
processEnvironment: "Vacuum"
operatingPressure: 2e-7    // Torr
chamberVolume: 85.5        // liters
targetTemperature: 350.0   // °C
processingState: "READY"
```
**Purpose**: High-vacuum process chamber for CVD operations requiring 2×10⁻⁷ Torr base pressure.

#### **DryPump (P002) - Main Entity**
```cypher
pumpIdentifier: "P002"
pumpModel: "Pfeiffer HiPace 700"
manufacturer: "Pfeiffer Vacuum"
serialNumber: "PV700-2024-0892"
currentAge: 285                    // days since installation
criticalityLevel: "Level5"         // highest business criticality
serviceRole: "Primary"
isOperational: true
operatingHours: 6840.25
pumpingSpeed: 670.0               // L/s
ultimateVacuum: 1e-10             // Torr
compressionRatio: 2e9
powerConsumption: 1.85            // kW
coolingMethod: "Air"
costCenter: "CC-CVD-001"
```
**Purpose**: High-performance turbo molecular pump providing primary vacuum for critical CVD processes.

### 🧮 **Mathematical Model Nodes**

#### **WeibullSurvivalFunction (WEIBULL_P002_v2.1)**
```cypher
modelId: "WEIBULL_P002_v2.1"
weibullShape: 1.68              // β parameter
weibullScale: 612.35            // η parameter (days)
weibullLocation: 0.0            // γ parameter
parameterConfidence: 0.91       // 91% confidence
modelFitDate: datetime("2025-02-20T00:00:00Z")
fittingMethod: "MaximumLikelihood"
goodnesOfFit: 0.94
populationSize: 247             // pumps in training dataset
dataPoints: 189                 // failure observations
censoringRate: 0.23            // 23% censored data
```
**Purpose**: Weibull distribution fitted to historical failure data for calculating baseline hazard rate.
**Mathematical Foundation**: λ_W(t) = (β/η) × (t/η)^(β-1)

#### **RemainingUsefulLife (RUL_P002_20250721)**
```cypher
rulId: "RUL_P002_20250721"
remainingUsefulLife: 142        // days
healthIndex: 0.28              // 0=nominal, 1=degraded
dataQualityScore: 0.89         // telemetry reliability
assessmentMethod: "TelemetryBased"
trendDirection: "Degrading"
degradationRate: 0.0034        // health degradation per day
overallDegradation: 0.31       // cumulative degradation
anomalyCount: 7                // recent anomalies detected

// Telemetry component scores
vibrationScore: 0.72           // vibration anomaly level
temperatureScore: 0.85         // thermal performance
powerConsumptionScore: 0.76    // power consumption anomaly
vacuumPerformanceScore: 0.68   // pumping efficiency
sensorHealthScore: 0.94        // sensor reliability
```
**Purpose**: Real-time condition assessment based on telemetry data fusion and machine learning models.

#### **BlendedHazardFunction (HAZARD_P002_20250721)**
```cypher
hazardId: "HAZARD_P002_20250721"
blendingWeight: 0.4            // k parameter
weibullHazard: 0.062          // λ_W(t) cumulative hazard
conditionHazard: 0.211        // λ_R(t) condition hazard
blendedHazard: 0.146          // H_30(t) = λ_W + k×λ_R
pumpAge: 285                  // current age in days
targetDays: 30                // prediction horizon
operationalStressMultiplier: 1.12  // process stress factor
calibrationFactor: 1.05       // model calibration
```
**Purpose**: Combines Weibull survival hazard with condition monitoring hazard.
**Mathematical Formula**: H_30(t) = λ_W(t) + k × λ_R(t) = 0.062 + 0.4 × 0.211 = 0.146

#### **ThirtyDayFailureProbability (PRED_P002_20250721)**
```cypher
predictionId: "PRED_P002_20250721"
failureProbability: 0.136      // 13.6% failure probability
riskClassification: "D"        // Risk classes A-E
riskScore: 0.136              // numeric risk score
confidenceLevel: 0.83         // prediction confidence
predictionHorizon: 30         // days
uncertaintyBand: 0.025        // ±2.5% uncertainty
alertLevel: "Medium"
businessImpactScore: 0.78     // business impact if failure occurs
interventionRequired: false
maintenanceRecommendation: "MonitorContinuously"
```
**Purpose**: Final 30-day failure probability using survival analysis.
**Mathematical Formula**: P_30(t) = 1 - exp(-H_30(t)) = 1 - exp(-0.146) = 0.136

### 🏭 **Process Integration Nodes**

#### **SemiconductorProcess (CVD_SILICON_NITRIDE)**
```cypher
processId: "CVD_SILICON_NITRIDE"
processType: "CVDProcess"
processName: "Silicon Nitride Deposition"
criticalityLevel: "High"
processFamily: "Dielectric"
processNode: "7nm"           // technology node
cycleTime: 45.5             // minutes per wafer
throughputTarget: 120       // wafers per hour
yieldImpact: "Critical"     // impact on wafer yield
productionPriority: "High"
```
**Purpose**: Critical dielectric deposition process for 7nm technology node.

#### **ProcessRecipe (CVD_SiN_V3.2)**
```cypher
recipeId: "CVD_SiN_V3.2"
recipeName: "Silicon Nitride CVD Standard"
recipeVersion: "v3.2"
vacuumRequirement: 1e-7     // Required vacuum level (Torr)
```
**Purpose**: Specific recipe requiring high vacuum conditions that P002 must maintain.

#### **MaintenanceReport (RPT_20250721_002)**
```cypher
reportId: "RPT_20250721_002"
reportGenerationTime: datetime("2025-07-21T12:00:00Z")
calculationVersion: "v2.1.3"
reportType: "Daily"
totalPumpsAssessed: 1
```
**Purpose**: AI-generated maintenance report containing P002 assessment results.

## Mathematical Relationships and Formulas

### **Weibull Survival Analysis**
The historical lifetime model uses a 2-parameter Weibull distribution:
```
Survival Function: S(t) = exp[-(t/η)^β]
Hazard Function: λ(t) = (β/η) × (t/η)^(β-1)

Parameters for P002:
- Shape (β): 1.68
- Scale (η): 612.35 days
- Location (γ): 0.0
```

### **Condition Monitoring Hazard**
The condition-based hazard uses RUL assessment:
```
Condition Hazard: λ_R(t) = Horizon / RUL(t)
                 = 30 / 142 = 0.211
```

### **Blended Hazard Calculation**
Combines both hazard components:
```
Blended Hazard: H_30(t) = λ_W(t) + k × λ_R(t)
               = 0.062 + 0.4 × 0.211
               = 0.146

Where:
- λ_W(t): Weibull cumulative hazard over 30 days
- λ_R(t): Condition cumulative hazard over 30 days  
- k: Blending weight (0.4)
```

### **Failure Probability Conversion**
Converts hazard to probability:
```
P_30(t) = 1 - exp(-H_30(t))
        = 1 - exp(-0.146)
        = 0.136 (13.6%)
```

### **Risk Classification**
Maps probability to business risk levels:
```
Risk Classes:
- A: ≥80% (Immediate Action Required)
- B: 60-79% (High Risk)
- C: 30-59% (Medium Risk)
- D: 10-29% (Low-Medium Risk)  ← P002 current status
- E: <10% (Low Risk)
```

## Query Patterns for P002

### **Complete Instance Overview**
```cypher
MATCH path = (fab:Fab)-[:CONTAINS]->(area:FabArea)<-[:LOCATED_IN]-(tool:SemiconductorTool)
<-[:PART_OF]-(chamber:ProcessChamber)<-[:SERVES]-(pump:DryPump {pumpIdentifier: "P002"})
MATCH (pump)-[:HAS_SURVIVAL_MODEL]->(weibull:WeibullSurvivalFunction)
MATCH (pump)-[:HAS_RUL_ASSESSMENT]->(rul:RemainingUsefulLife)
MATCH (pump)-[:HAS_HAZARD_CALCULATION]->(hazard:BlendedHazardFunction)
MATCH (pump)-[:HAS_FAILURE_PREDICTION]->(prediction:ThirtyDayFailureProbability)
RETURN pump.pumpIdentifier, pump.criticalityLevel, pump.currentAge,
       fab.fabId + " → " + area.areaId + " → " + tool.toolId + " → " + chamber.chamberId as EquipmentHierarchy,
       weibull.weibullShape, weibull.weibullScale,
       rul.remainingUsefulLife, rul.healthIndex,
       hazard.blendedHazard, prediction.failureProbability, prediction.riskClassification
```

### **Mathematical Calculation Verification**
```cypher
MATCH (h:BlendedHazardFunction {hazardId: "HAZARD_P002_20250721"})
RETURN h.weibullHazard as WeibullHazard,
       h.conditionHazard as ConditionHazard,
       h.blendingWeight as BlendingWeight,
       h.blendedHazard as BlendedHazard,
       (h.weibullHazard + h.blendingWeight * h.conditionHazard) as CalculatedBlendedHazard,
       abs(h.blendedHazard - (h.weibullHazard + h.blendingWeight * h.conditionHazard)) as Error
```

### **Business Impact Assessment**
```cypher
MATCH (pump:DryPump {pumpIdentifier: "P002"})-[:CRITICAL_FOR]->(process:SemiconductorProcess)
MATCH (pump)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
MATCH (pump)-[:SERVES]->(chamber:ProcessChamber)-[:PART_OF]->(tool:SemiconductorTool)
RETURN pump.pumpIdentifier as PumpID,
       pump.criticalityLevel as Criticality,
       process.processName as CriticalProcess,
       process.yieldImpact as YieldImpact,
       tool.utilization as ToolUtilization,
       pred.failureProbability as FailureRisk,
       pred.businessImpactScore as BusinessImpact
```

## Deployment Instructions

### **Prerequisites**
- Neo4j 5.x database
- APOC plugin installed
- Sufficient memory allocation (min 4GB)

### **Deployment Steps**
1. **Execute Schema**: Run the schema creation script from `/docs/implementation/neo4j-schema.cypher`
2. **Create Instance**: Execute `/examples/pump-p002/create-p002-instance.cypher`
3. **Verify**: Run the verification query at the end of the script
4. **Test Queries**: Execute the query patterns above

### **Expected Results**
After successful deployment, the verification query should return:
```
PumpID: "P002"
Criticality: "Level5"
EquipmentHierarchy: "FAB2 → CVD_DEPOSITION → PECVD_05 → CH2"
WeibullShape: 1.68
WeibullScale: 612.35
RUL_Days: 142
HealthIndex: 0.28
BlendedHazard: 0.146
FailureProbability: 0.136
RiskClass: "D"
```

## Business Value Demonstration

This P002 instance demonstrates the complete value proposition of the predictive maintenance knowledge graph:

### **Predictive Insights**
- **Early Warning**: 13.6% failure probability detected 142 days before predicted failure
- **Mathematical Rigor**: Combines proven Weibull survival analysis with real-time condition monitoring
- **Risk Quantification**: Translates complex mathematical models into actionable business risk levels

### **Operational Integration** 
- **Equipment Hierarchy**: Full traceability from fab level to individual pump components
- **Process Impact**: Direct linkage to critical manufacturing processes and business impact
- **Maintenance Planning**: Actionable recommendations with confidence intervals

### **Data Lineage**
- **Complete Traceability**: Every prediction traces back to source models and telemetry data
- **Quality Metrics**: Data quality scores and confidence levels for decision support
- **Audit Trail**: Full mathematical calculation chain for regulatory compliance

This comprehensive example validates that the knowledge graph successfully supports the AI agent's primary mission: **generating accurate 30-day failure probability reports for vacuum dry pumps using survival analysis and condition monitoring**.

---

**Instance Created**: July 21, 2025  
**Model Version**: v1.0  
**Status**: Production Example  
**Next Review**: Model validation with historical failure data
