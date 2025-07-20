# Step 5: Define Properties - Minimal Viable Knowledge Graph 🏷️

> **Methodology Reference**: Noy & McGuinness (2000) - Step 5 of the 7-step iterative ontology development process
> 
> **Focus**: Minimal viable properties for 30-day failure probability calculation and AI agent reporting

## Design Philosophy

**Minimal Viable Approach**: Include only properties essential for the core use case - AI agent generating 30-day failure probability reports for dry pumps.

**Mathematical Foundation**: Every property directly supports the blended hazard calculation:
```
P_30(t) = 1 - exp[-(λ_W(t) + k·λ_R(t))]
Where: λ_W(t) = ((t+30)^ρ - t^ρ)/β^ρ and λ_R(t) = 30/RUL(t)
```

**Growth Strategy**: Start with essential properties, extend systematically based on implementation needs.

## Property Categories Overview

### 🎯 **Core Properties for 30-Day Calculation**
1. **Mathematical Properties**: Weibull parameters, blending weights, probability results
2. **Equipment Identity Properties**: Minimal identification and context
3. **Temporal Properties**: Age, prediction windows, timestamps
4. **Condition Monitoring Properties**: RUL, health index, basic telemetry
5. **Output Properties**: Risk classification, report metadata

---

## 1. Mathematical Properties 🧮

### **WeibullSurvivalFunction Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `hasWeibullShape` | WeibullSurvivalFunction | xsd:float | ✅ | Shape parameter (ρ) | 1.42 |
| `hasWeibullScale` | WeibullSurvivalFunction | xsd:float | ✅ | Scale parameter (β) in days | 527.44 |
| `hasWeibullLocation` | WeibullSurvivalFunction | xsd:float | ❌ | Location parameter (γ) | 0.0 |
| `hasParameterConfidence` | WeibullSurvivalFunction | xsd:float | ❌ | Model confidence [0,1] | 0.85 |

### **BlendedHazardFunction Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `hasBlendingWeight` | BlendedHazardFunction | xsd:float | ✅ | Condition hazard weight (k) [0,1] | 0.3 |
| `hasWeibullHazard` | BlendedHazardFunction | xsd:float | ✅ | λ_W(t) cumulative hazard | 0.045 |
| `hasConditionHazard` | BlendedHazardFunction | xsd:float | ✅ | λ_R(t) cumulative hazard | 0.167 |
| `hasBlendedHazard` | BlendedHazardFunction | xsd:float | ✅ | H_30(t) total hazard | 0.095 |

### **ThirtyDayFailureProbability Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `hasFailureProbability` | ThirtyDayFailureProbability | xsd:float | ✅ | P_30(t) ∈ [0,1] | 0.091 |
| `hasConfidenceLevel` | ThirtyDayFailureProbability | xsd:float | ❌ | Prediction confidence | 0.78 |
| `hasCalculationMethod` | ThirtyDayFailureProbability | xsd:string | ❌ | Algorithm identifier | "BlendedHazard_v1.2" |

---

## 2. Equipment Identity Properties ⚙️

### **DryPump Properties** (Essential Only)

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `pumpIdentifier` | DryPump | xsd:string | ✅ | Unique pump ID | "P001" |
| `pumpModel` | DryPump | xsd:string | ✅ | Manufacturer model | "Edwards nXDS20i" |
| `manufacturer` | DryPump | xsd:string | ❌ | Equipment manufacturer | "Edwards Vacuum" |
| `serialNumber` | DryPump | xsd:string | ❌ | Serial number | "EN12345678" |
| `pumpType` | DryPump | xsd:string | ❌ | Technology type | "Scroll" |

### **Equipment Context Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `criticalityLevel` | DryPump | EquipmentCriticality | ✅ | Business impact level | CriticalityLevel4 |
| `serviceRole` | DryPump | xsd:string | ✅ | Pump function | "Primary" |
| `isOperational` | DryPump | xsd:boolean | ✅ | Current operational status | true |

---

## 3. Temporal Properties 🕒

### **Age and Lifetime Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `currentAge` | DryPump | xsd:integer | ✅ | Age in days since installation | 400 |
| `operatingHours` | DryPump | xsd:float | ❌ | Total operating hours | 9600.5 |
| `installationDate` | DryPump | xsd:dateTime | ❌ | Installation timestamp | "2024-04-15T08:00:00Z" |

### **Prediction Window Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `predictionTimestamp` | ThirtyDayFailureProbability | xsd:dateTime | ✅ | When prediction was made | "2025-07-20T10:30:00Z" |
| `predictionWindowStart` | PredictionWindow | xsd:dateTime | ✅ | Window start time | "2025-07-20T10:30:00Z" |
| `predictionWindowEnd` | PredictionWindow | xsd:dateTime | ✅ | Window end time (30 days) | "2025-08-19T10:30:00Z" |

---

## 4. Condition Monitoring Properties 📊

### **Health Assessment Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `remainingUsefulLife` | RemainingUsefulLife | xsd:integer | ✅ | RUL in days | 180 |
| `healthIndex` | HealthIndex | xsd:float | ✅ | Health score [0,1] | 0.67 |
| `degradationRate` | HealthIndex | xsd:float | ❌ | Health decline per day | -0.002 |

### **Data Quality Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `dataQualityScore` | RemainingUsefulLife | xsd:float | ❌ | Data reliability [0,1] | 0.92 |
| `lastTelemetryUpdate` | HealthIndex | xsd:dateTime | ❌ | Most recent data | "2025-07-20T09:45:00Z" |
| `hasAnomalyFlag` | HealthIndex | xsd:boolean | ❌ | Anomaly detection result | false |

---

## 5. Manufacturing Context Properties 🏭

### **Process Integration Properties** (Minimal)

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `chamberId` | ProcessChamber | xsd:string | ✅ | Chamber identifier | "CH1" |
| `toolId` | SemiconductorTool | xsd:string | ✅ | Tool identifier | "ETCH_02" |
| `fabAreaId` | FabArea | xsd:string | ❌ | Area identifier | "DRY_ETCH" |

---

## 6. Report Output Properties 📋

### **Risk Classification Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `riskClassification` | ThirtyDayFailureProbability | xsd:string | ✅ | Risk level A-E | "C" |
| `riskScore` | ThirtyDayFailureProbability | xsd:float | ✅ | Numeric risk [0,1] | 0.091 |
| `actionRecommendation` | ThirtyDayFailureProbability | xsd:string | ❌ | Maintenance action | "Monitor closely" |

### **Report Metadata Properties**

| Property | Domain | Range | Required | Description | Example |
|----------|---------|--------|----------|-------------|---------|
| `reportGenerationTime` | ReportGeneration | xsd:dateTime | ✅ | Report creation time | "2025-07-20T11:00:00Z" |
| `calculationVersion` | ReportGeneration | xsd:string | ❌ | Algorithm version | "v1.2.1" |
| `reportId` | ReportGeneration | xsd:string | ✅ | Unique report identifier | "RPT_20250720_001" |

---

## Property Relationships and Dependencies

### **Mathematical Calculation Chain**
```
DryPump 
  ├── hasWeibullShape → WeibullSurvivalFunction
  ├── hasWeibullScale → WeibullSurvivalFunction  
  ├── hasCurrentAge → used in λ_W(t) calculation
  ├── hasRemainingUsefulLife → used in λ_R(t) calculation
  ├── hasBlendingWeight → BlendedHazardFunction
  └── hasFailureProbability → ThirtyDayFailureProbability
```

### **Temporal Dependency Chain**
```
installationDate + currentAge = current_time
predictionTimestamp = calculation_time
predictionWindow = [predictionTimestamp, predictionTimestamp + 30 days]
```

### **Report Generation Chain**
```
Mathematical Properties → Calculation → Risk Classification → Report Output
```

---

## Neo4j Property Implementation

### **Node Properties by Label**

#### **:DryPump Node Properties**
```cypher
CREATE (pump:DryPump:EquipmentModule:VacuumPump {
  pumpIdentifier: "P001",
  pumpModel: "Edwards nXDS20i", 
  manufacturer: "Edwards Vacuum",
  currentAge: 400,
  criticalityLevel: "Level4",
  serviceRole: "Primary",
  isOperational: true,
  operatingHours: 9600.5,
  installationDate: datetime("2024-04-15T08:00:00Z")
})
```

#### **:WeibullSurvivalFunction Node Properties**
```cypher
CREATE (weibull:WeibullSurvivalFunction:SurvivalFunction {
  hasWeibullShape: 1.42,
  hasWeibullScale: 527.44,
  hasWeibullLocation: 0.0,
  hasParameterConfidence: 0.85
})
```

#### **:ThirtyDayFailureProbability Node Properties**
```cypher
CREATE (prob:ThirtyDayFailureProbability:FailureProbability {
  hasFailureProbability: 0.091,
  riskClassification: "C",
  riskScore: 0.091,
  predictionTimestamp: datetime("2025-07-20T10:30:00Z"),
  hasConfidenceLevel: 0.78,
  hasCalculationMethod: "BlendedHazard_v1.2"
})
```

#### **:RemainingUsefulLife Node Properties**
```cypher
CREATE (rul:RemainingUsefulLife:HealthModel {
  remainingUsefulLife: 180,
  dataQualityScore: 0.92,
  lastTelemetryUpdate: datetime("2025-07-20T09:45:00Z")
})
```

### **Relationship Properties**

#### **Calculation Relationships**
```cypher
// Pump to Survival Model
(pump)-[:HAS_SURVIVAL_MODEL {
  modelFitDate: datetime("2025-01-15T00:00:00Z"),
  modelVersion: "v1.2"
}]->(weibull)

// Pump to Failure Probability  
(pump)-[:HAS_FAILURE_PROBABILITY {
  calculationTimestamp: datetime("2025-07-20T10:30:00Z"),
  calculationDuration: 0.045
}]->(prob)

// Pump to RUL Assessment
(pump)-[:HAS_RUL {
  assessmentTimestamp: datetime("2025-07-20T09:45:00Z"),
  assessmentMethod: "TelemetryBased"
}]->(rul)
```

---

## Property Constraints and Validation

### **Value Constraints**

#### **Mathematical Constraints**
```
hasWeibullShape > 0                    // Shape parameter must be positive
hasWeibullScale > 0                    // Scale parameter must be positive  
hasBlendingWeight ∈ [0,1]             // Blending weight is bounded
hasFailureProbability ∈ [0,1]         // Probability is bounded
remainingUsefulLife ≥ 0               // RUL cannot be negative
healthIndex ∈ [0,1]                   // Health index is normalized
```

#### **Temporal Constraints**
```
currentAge ≥ 0                        // Age cannot be negative
predictionWindowEnd > predictionWindowStart  // Valid time window
lastTelemetryUpdate ≤ predictionTimestamp    // Data cannot be from future
```

#### **Business Logic Constraints**
```
criticalityLevel ∈ {Level1, Level2, Level3, Level4, Level5}
riskClassification ∈ {A, B, C, D, E}
serviceRole ∈ {Primary, Backup, Roughing}
pumpType ∈ {Rotary, Scroll, Screw}
```

### **Data Quality Constraints**

#### **Required Property Combinations**
```
IF hasFailureProbability EXISTS 
THEN hasWeibullShape AND hasWeibullScale AND currentAge MUST EXIST

IF riskClassification EXISTS 
THEN hasFailureProbability MUST EXIST

IF hasBlendedHazard EXISTS 
THEN hasWeibullHazard AND hasConditionHazard MUST EXIST
```

#### **Referential Integrity**
```
Every DryPump MUST have pumpIdentifier
Every WeibullSurvivalFunction MUST have hasWeibullShape AND hasWeibullScale  
Every ThirtyDayFailureProbability MUST have hasFailureProbability AND predictionTimestamp
```

---

## Property Inheritance Strategy

### **From Step 4 Class Hierarchy**

#### **DryPump Property Inheritance**
```
DryPump 
├── inherits from EquipmentModule (ISA-95)
│   ├── equipmentId, location, status
├── inherits from VacuumPump  
│   ├── vacuumCapacity, maxPressure
└── domain-specific properties
    ├── pumpIdentifier, currentAge, criticalityLevel
```

#### **Mathematical Function Property Inheritance**
```
WeibullSurvivalFunction
├── inherits from SurvivalFunction
│   ├── functionType, domain, range
├── inherits from ProbabilityFunction
│   ├── probabilitySpace, measureType
└── domain-specific properties
    ├── hasWeibullShape, hasWeibullScale, hasWeibullLocation
```

---

## Implementation Priorities

### **Phase 1: Core Calculation Properties** (Week 1)
```
Essential Properties:
- pumpIdentifier, currentAge
- hasWeibullShape, hasWeibullScale  
- remainingUsefulLife
- hasBlendingWeight, hasFailureProbability
- riskClassification, predictionTimestamp
```

### **Phase 2: Data Quality Properties** (Week 2)  
```
Quality Assurance Properties:
- dataQualityScore, hasParameterConfidence
- lastTelemetryUpdate, hasAnomalyFlag
- calculationVersion, reportGenerationTime
```

### **Phase 3: Context Properties** (Week 3)
```
Manufacturing Context Properties:
- criticalityLevel, serviceRole
- chamberId, toolId, fabAreaId
- actionRecommendation, reportId
```

### **Phase 4: Advanced Properties** (Week 4)
```
Extended Properties:
- operatingHours, installationDate
- degradationRate, healthIndex
- manufacturer, serialNumber, pumpType
```

---

## Example: Complete Property Instance

### **Pump P001 - Complete Property Set**
```turtle
@prefix : <http://example.org/pump-ontology#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

:pump_P001 a :DryPump ;
  :pumpIdentifier "P001" ;
  :pumpModel "Edwards nXDS20i" ;
  :manufacturer "Edwards Vacuum" ;
  :currentAge 400 ;
  :criticalityLevel :CriticalityLevel4 ;
  :serviceRole "Primary" ;
  :isOperational true ;
  :hasWeibullShape 1.42 ;
  :hasWeibullScale 527.44 ;
  :hasBlendingWeight 0.3 ;
  :remainingUsefulLife 180 ;
  :hasFailureProbability 0.091 ;
  :riskClassification "C" ;
  :predictionTimestamp "2025-07-20T10:30:00Z"^^xsd:dateTime .

:weibull_P001 a :WeibullSurvivalFunction ;
  :hasWeibullShape 1.42 ;
  :hasWeibullScale 527.44 ;
  :hasParameterConfidence 0.85 .

:prob_P001 a :ThirtyDayFailureProbability ;
  :hasFailureProbability 0.091 ;
  :riskClassification "C" ;
  :predictionTimestamp "2025-07-20T10:30:00Z"^^xsd:dateTime ;
  :hasConfidenceLevel 0.78 .

# Relationships
:pump_P001 :hasSurvivalModel :weibull_P001 .
:pump_P001 :hasFailurePrediction :prob_P001 .
```

---

## Validation Against Step 4 Classes

### **Property-Class Consistency Check**

#### **✅ Mathematical Properties Align with Step 4**
- WeibullSurvivalFunction properties → support survival calculation
- BlendedHazardFunction properties → support hazard blending  
- ThirtyDayFailureProbability properties → support risk assessment

#### **✅ Equipment Properties Align with ISA-95**
- DryPump properties → consistent with EquipmentModule
- Manufacturing context → consistent with WorkUnit/Equipment hierarchy

#### **✅ Temporal Properties Align with OWL-Time**
- Prediction windows → consistent with TimeInterval
- Age/duration properties → consistent with TimeDuration

#### **✅ Process Properties Align with SEMI Standards**
- Tool/chamber IDs → consistent with SemiconductorTool/ProcessChamber
- Process context → consistent with manufacturing process hierarchy

---

## Extension Strategy

### **Property Growth Path**
1. **Start**: 15 essential properties for MVP
2. **Grow**: Add quality/context properties based on deployment feedback
3. **Extend**: Add advanced analytics properties for model improvement
4. **Scale**: Add integration properties for enterprise systems

### **Property Categories for Future Extension**
- **Sensor Integration**: Individual sensor properties (temperature, vibration, current)
- **Maintenance History**: Maintenance events, spare parts, technician notes
- **Process Integration**: Recipe parameters, process conditions, yield impact
- **Business Intelligence**: Cost metrics, availability targets, performance KPIs

---

**Design Philosophy**: Essential properties for 30-day failure probability calculation

**Growth Strategy**: Minimal viable start, systematic extension based on implementation needs

**Validation**: All properties directly support the core mathematical calculation pipeline

**Implementation Ready**: Neo4j property definitions with constraints and examples

**Next Step**: [Step 6: Define Constraints](06-constraints.md) - Formal property constraints and validation rules

**Status**: ✅ Complete - Minimal Viable Property Set for Survival Analysis

**Last Updated**: July 20, 2025