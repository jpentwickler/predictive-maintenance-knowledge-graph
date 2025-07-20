# Step 4: Define Classes and Class Hierarchies - Mathematical Foundation 🏢

> **Methodology Reference**: Noy & McGuinness (2000) - Step 4 of the 7-step iterative ontology development process
> 
> **Approach**: Middle-out modeling starting with core mathematical concepts for survival analysis and condition monitoring

## Modeling Strategy

**Starting Point**: Core mathematical concepts (Survival Functions, Health Indices, Failure Probabilities)

**Extension Direction**: 
- **Upward**: Abstract mathematical and computational concepts
- **Downward**: Specific pump implementations and concrete calculations

**Design Principle**: Computational efficiency for AI agent with mathematical rigor

## Core Class Hierarchy

### 🧮 **Mathematical Foundation Classes** (Top Level)

```
MathematicalFunction
├── ProbabilityFunction
│   ├── SurvivalFunction
│   │   ├── WeibullSurvivalFunction
│   │   ├── ExponentialSurvivalFunction (future extension)
│   │   └── LogNormalSurvivalFunction (future extension)
│   ├── HazardFunction
│   │   ├── WeibullHazardFunction
│   │   └── BlendedHazardFunction
│   └── ProbabilityDensityFunction
│       └── WeibullPDF
├── DistributionFunction
│   └── CumulativeDistributionFunction
│       └── WeibullCDF
└── ParametricFunction
    └── ParametricModel
        ├── SurvivalModel
        └── HealthModel
```

**Design Rationale**: 
- Mathematical functions as root provides extensibility to other distributions
- Separates survival functions from hazard functions for computational clarity
- Parametric models enable different algorithmic approaches

### ⚙️ **Equipment Hierarchy** (Standards-Based - ISA-95 + SEMI + MIMOSA)

```
PhysicalAsset (MIMOSA)
└── ManufacturingAsset (MIMOSA)
    └── Site (ISA-95)
        └── Fab
            └── Area (ISA-95) 
                └── FabArea
                    └── WorkUnit (ISA-95)
                        └── SemiconductorTool
                            └── Equipment (ISA-95)
                                └── ProcessChamber
                                    └── EquipmentModule (ISA-95)
                                        └── VacuumEquipment
                                            └── VacuumPump
                                                └── DryPump
```

**Standard Mapping**:
- **ISA-95 Hierarchy**: Site → Area → WorkUnit → Equipment → EquipmentModule
- **SEMI E10/E30**: SemiconductorTool, ProcessChamber, ToolState concepts
- **MIMOSA**: PhysicalAsset, ManufacturingAsset, condition monitoring integration

#### **Fab Level** (ISA-95 Site + Custom)
```
Fab (subclass of ISA-95:Site)
├── FabIdentifier: "Fab1", "Fab2" 
├── FabLocation: Geographic location
├── FabCapacity: Wafer processing capacity
└── OperatingSchedule: 24/7 continuous operation
```

#### **FabArea Level** (ISA-95 Area + SEMI)
```
FabArea (subclass of ISA-95:Area)
├── CleanroomArea: ISO class clean environment
├── WetProcessArea: Chemical processing
├── DryProcessArea: Plasma/vacuum processing  
├── MetrologyArea: Inspection and measurement
└── UtilityArea: Support equipment
```

#### **SemiconductorTool Level** (ISA-95 WorkUnit + SEMI E30)
```
SemiconductorTool (subclass of ISA-95:WorkUnit)
├── ToolIdentifier: "TOOL001", "ETCH_02"
├── ToolType: Etch, Deposition, Implant, Litho, etc.
├── ToolModel: Manufacturer model designation
├── ToolState: (SEMI E10 states)
│   ├── PRODUCTIVE: Running wafers
│   ├── STANDBY: Ready but not processing
│   ├── ENGINEERING: Under maintenance
│   └── DOWN: Not operational
└── ProcessCapability: Supported processes
```

#### **ProcessChamber Level** (ISA-95 Equipment + SEMI E40)
```
ProcessChamber (subclass of ISA-95:Equipment)
├── ChamberIdentifier: "CH1", "CH2", "LOADLOCK"
├── ChamberType: Process, LoadLock, Transfer
├── ProcessEnvironment: Vacuum, Atmospheric, Inert
├── OperatingPressure: Target vacuum level
└── ProcessRecipe: Chamber-specific process steps
```

#### **DryPump Level** (ISA-95 EquipmentModule + Custom)
```
DryPump (subclass of ISA-95:EquipmentModule)
├── PumpIdentifier: "P001", "P002" 
├── PumpType: Rotary, Scroll, Screw
├── PumpModel: "Edwards nXDS20i", "Pfeiffer HiPace 80"
├── PumpRole: Primary, Backing, Roughing
├── ServiceConnection: Which chamber(s) it serves
└── CriticalityLevel: Business impact if pump fails
```

### 🏭 **Manufacturing Process Hierarchy** (SEMI Standards + ISA-95)

```
ManufacturingProcess (ISA-95)
└── SemiconductorProcess (SEMI E40)
    ├── ProcessType
    │   ├── EtchProcess: Plasma etching
    │   ├── DepositionProcess: CVD, PVD, ALD  
    │   ├── ImplantProcess: Ion implantation
    │   ├── LithographyProcess: Photolithography
    │   └── CleanProcess: Chamber cleaning
    ├── ProcessRecipe (SEMI E30)
    │   ├── RecipeIdentifier: "ETCH_OXIDE_V2.1"
    │   ├── ProcessSteps: Sequence of operations
    │   ├── ProcessParameters: Temperature, pressure, time
    │   └── QualityTargets: Target outcomes
    └── ProcessRun (ISA-95)
        ├── RunIdentifier: Specific execution instance
        ├── StartTime: Process start timestamp
        ├── EndTime: Process completion timestamp  
        ├── ProcessedSubstrate: Wafers processed
        └── QualityResults: Actual vs target outcomes
```

### 🔗 **Equipment-Process Relationships** (Core Domain Innovation)

```
SemiconductorTool --runs--> SemiconductorProcess
SemiconductorTool --contains--> ProcessChamber  
SemiconductorTool --locatedIn--> FabArea
FabArea --partOf--> Fab

ProcessChamber --requires--> DryPump (vacuum generation)
ProcessChamber --executes--> ProcessRecipe
ProcessChamber --maintains--> ProcessEnvironment

DryPump --serves--> ProcessChamber
DryPump --criticalFor--> SemiconductorProcess  
DryPump --impacts--> ProcessQuality (when degraded)
DryPump --affects--> ToolAvailability (when failed)

ProcessRecipe --defines--> VacuumRequirements
VacuumRequirements --dependsOn--> DryPump
```

### 📊 **Equipment Criticality Modeling** (Business Impact Assessment)

```
EquipmentCriticality (Custom - Business Logic)
├── CriticalityLevel1: Low impact (backup systems available)
├── CriticalityLevel2: Medium impact (some process delay)
├── CriticalityLevel3: High impact (tool down, revenue loss)
├── CriticalityLevel4: Critical impact (multiple tools affected)
└── CriticalityLevel5: Severe impact (fab area shutdown)

BusinessImpact (Custom - OEE Integration)
├── QualityImpact: Wafer scrap rate increase
├── AvailabilityImpact: Tool downtime duration  
├── PerformanceImpact: Reduced throughput rate
└── RevenueImpact: Financial loss estimation
```

### 🎯 **Key Equipment Relationships for Risk Assessment**

```
DryPump --hasFailureProbability--> ThirtyDayFailureProbability
DryPump --hasCriticalityLevel--> EquipmentCriticality  
DryPump --impactsProcess--> SemiconductorProcess
DryPump --servesTools--> SemiconductorTool (may serve multiple)

Risk = f(FailureProbability, CriticalityLevel, ProcessImpact, ToolDependency)

Example:
pump_P001 serves chamber_CH1 in tool_ETCH_02 running critical_process_OXIDE_ETCH
→ High criticality due to process importance and single-point-of-failure
```

### 🎯 **Prediction and Decision Classes**

```
PredictiveAnalysis
├── FailurePrediction
│   ├── ThirtyDayFailureProbability
│   ├── PredictionWindow
│   └── PredictionConfidence
├── HazardAnalysis
│   ├── SurvivalHazard
│   ├── ConditionHazard
│   └── BlendedHazardRate
└── ModelManagement
    ├── SurvivalModel
    ├── HealthModel
    └── BlendingModel
```

**Design Rationale**:
- Prediction as core AI agent capability
- Hazard analysis bridges survival and condition monitoring
- Model management enables algorithmic flexibility

### 🕒 **Temporal Classes** (Minimal External)

```
TemporalEntity (from OWL-Time)
├── TimeInstant
├── TimeInterval
│   └── PredictionWindow (30 days)
└── TimeDuration
    ├── PumpAge
    ├── OperatingHours
    └── TimeToFailure
```

**Design Rationale**:
- Leverage OWL-Time standard for temporal reasoning
- Minimal custom temporal classes for domain specifics

### 📈 **Statistical and Parameter Classes**

```
StatisticalEntity
├── Parameter
│   ├── WeibullParameters
│   │   ├── WeibullShape (β)
│   │   ├── WeibullScale (η)
│   │   └── WeibullLocation (γ)
│   └── ModelParameters
│       ├── HazardWeighting
│       └── ConfidenceLevel
├── StatisticalMeasure
│   ├── Probability
│   │   ├── SurvivalProbability
│   │   └── FailureProbability
│   ├── Rate
│   │   ├── HazardRate
│   │   ├── FailureRate
│   │   └── DegradationRate
│   └── Lifetime
│       ├── MedianLifetime
│       ├── CharacteristicLifetime
│       └── MeanTimeToFailure
└── Uncertainty
    ├── ConfidenceInterval
    ├── PredictionConfidence
    └── ParameterUncertainty
```

**Design Rationale**:
- Statistical entities support mathematical rigor
- Parameter hierarchy enables different model types
- Uncertainty modeling for prediction reliability

### 🤖 **Computational Classes** (AI Agent Support)

```
ComputationalProcess
├── CalculationProcess
│   ├── SurvivalCalculation
│   ├── HealthCalculation
│   ├── HazardCalculation
│   └── ProbabilityCalculation
├── ModelingProcess
│   ├── ParameterEstimation
│   ├── ModelTraining
│   └── ModelValidation
└── ReportingProcess
    ├── ReportGeneration
    └── ReportCalculation
```

**Design Rationale**:
- Process classes enable workflow modeling
- Calculation processes map to AI agent algorithms
- Reporting processes for automated output generation

## Equipment Hierarchy Relationships

### **Physical Containment Hierarchy** (ISA-95 Standard):
```
Fab (Site) 
  └── FabArea (Area)
      └── SemiconductorTool (WorkUnit)
          └── ProcessChamber (Equipment)
              └── DryPump (EquipmentModule)
```

### **Process Execution Relationships**:
```
SemiconductorTool --runs--> SemiconductorProcess
ProcessChamber --executes--> ProcessRecipe  
ProcessRecipe --requires--> VacuumLevel
DryPump --provides--> VacuumLevel
```

### **Criticality Assessment Chain**:
```
SemiconductorProcess --hasBusinessValue--> RevenueImpact
ProcessChamber --criticalFor--> SemiconductorProcess
DryPump --enablesOperation--> ProcessChamber
→ DryPump failure criticality = f(Process value, Chamber dependency, Tool impact)
```

### **Mathematical Relationships for Risk Calculation**:
```
DryPump --hasWeibullParameters--> {ρ, β}
DryPump --hasCurrentAge--> t (days)
DryPump --hasRUL--> RemainingUsefulLife 
DryPump --hasBlendingWeight--> k ∈ [0,1]

WeibullCumulativeHazard: λ_W(t) = ((t+30)^ρ - t^ρ)/β^ρ
ConditionCumulativeHazard: λ_R(t) = 30/RUL(t)  
BlendedCumulativeHazard: H_30(t) = λ_W(t) + k·λ_R(t)
ThirtyDayFailureProbability: P_30(t) = 1 - exp[-H_30(t)]

DryPump --hasCriticalityLevel--> EquipmentCriticality
Risk = f(P_30(t), CriticalityLevel, ProcessImpact)
```

## Disjoint Class Declarations

### **Mathematical Function Types** (Mutually Exclusive):
```
SurvivalFunction ⊥ HazardFunction ⊥ ProbabilityDensityFunction
WeibullSurvivalFunction ⊥ ExponentialSurvivalFunction ⊥ LogNormalSurvivalFunction
```

### **Probability Types** (Mutually Exclusive):
```
SurvivalProbability ⊥ FailureProbability
(Note: SurvivalProbability = 1 - FailureProbability)
```

### **Hazard Types** (Can Overlap for Blending):
```
SurvivalHazard ≠ ConditionHazard (different sources, can be combined)
```

## Class Instantiation Strategy

### **Class vs Instance Modeling**:

**Classes for Types**:
- `DryPump` (class) - represents the category of dry pumps
- `WeibullSurvivalFunction` (class) - represents the type of survival function
- `HealthIndex` (class) - represents the type of health assessment

**Instances for Specific Items**:
- `pump_P001` (instance of DryPump) - specific pump P001
- `weibull_model_P001` (instance of WeibullSurvivalFunction) - P001's survival model
- `health_index_P001_2025_07_18` (instance of HealthIndex) - P001's health on specific date

### **Parameterization Approach** (Exact Notation):
```
pump_P001 rdf:type DryPump
pump_P001 hasWeibullShape 1.42        # ρ (shape parameter)
pump_P001 hasWeibullScale 527.44      # β (scale parameter, days)
pump_P001 hasCurrentAge 400           # t (current age, days)
pump_P001 hasRemainingUsefulLife 180  # RUL(t) (days from condition monitoring)
pump_P001 hasBlendingWeight 0.3       # k ∈ [0,1] (condition hazard weight)
pump_P001 hasFailureProbability 0.12  # P_30(t) ∈ [0,1] for next 30 days
```

## Validation Against Competency Questions

### **Validation Against Equipment Hierarchy Questions**:

1. ✅ "Which chamber does pump P001 serve?"
   - `pump_P001 serves chamber_CH1`
   - `chamber_CH1 rdf:type ProcessChamber`

2. ✅ "What tool contains the chamber that pump P001 serves?"
   - `chamber_CH1 partOf tool_ETCH_02`  
   - `tool_ETCH_02 rdf:type SemiconductorTool`

3. ✅ "What processes are affected if pump P001 fails?"
   - `pump_P001 serves chamber_CH1`
   - `chamber_CH1 executes recipe_OXIDE_ETCH`
   - `recipe_OXIDE_ETCH partOf process_ETCH`

4. ✅ "What is the criticality level of pump P001?"
   - `pump_P001 hasCriticalityLevel level_4`
   - `level_4 rdf:type CriticalityLevel4` (High impact)

5. ✅ "Which fab area would be affected by pump P001 failure?"
   - `pump_P001 serves chamber_CH1`
   - `chamber_CH1 partOf tool_ETCH_02`
   - `tool_ETCH_02 locatedIn area_DRY_ETCH`
   - `area_DRY_ETCH partOf fab_1`

### **Condition Monitoring Questions**:
1. ✅ "What is the current health index for pump P001?"
   - `pump_P001 hasHealthAssessment health_P001`
   - `health_P001 rdf:type HealthIndex`

2. ✅ "How has the health index trended over the past month?"
   - `health_P001 hasTimeSeries health_series_P001`
   - `health_series_P001 rdf:type HealthIndexTimeSeries`

### **30-Day Prediction Questions**:
1. ✅ "What is the 30-day failure probability for pump P001?"
   - `pump_P001 hasFailurePrediction prediction_P001`
   - `prediction_P001 rdf:type ThirtyDayFailureProbability`

2. ✅ "Which pumps have >20% failure probability in next 30 days?"
   - Query pumps where `hasFailureProbability > 0.20`

## Implementation Priorities

### **Phase 1: Core Mathematical Classes** (Week 1)
```
Classes: DryPump, WeibullSurvivalFunction, HealthIndex, ThirtyDayFailureProbability
Focus: Basic survival and health modeling
```

### **Phase 2: Parameter and Calculation Classes** (Week 2)
```
Classes: WeibullParameters, BlendedHazardRate, SurvivalCalculation, HealthCalculation
Focus: Mathematical computation support
```

### **Phase 3: Temporal and Process Classes** (Week 3)
```
Classes: TelemetryTimeSeries, PredictionWindow, CalculationProcess
Focus: Time-series data and workflow modeling
```

### **Phase 4: Advanced Analytics** (Week 4)
```
Classes: ModelValidation, ParameterUncertainty, PredictionConfidence
Focus: Model quality and uncertainty quantification
```

## Neo4j Implementation for Equipment Hierarchy

### **Primary Labels** (Core Entities):
```
:Fab, :FabArea, :SemiconductorTool, :ProcessChamber, :DryPump
:SemiconductorProcess, :ProcessRecipe, :EquipmentCriticality  
:WeibullSurvivalFunction, :RemainingUsefulLife
:ThirtyDayFailureProbability, :WeibullCumulativeHazard, :ConditionCumulativeHazard
```

### **Multiple Labels for Standards Compliance**:
```
Equipment Hierarchy (ISA-95 + SEMI + Custom):
(:Fab:Site:PhysicalAsset)
(:FabArea:Area:ManufacturingAsset) 
(:SemiconductorTool:WorkUnit:ManufacturingAsset)
(:ProcessChamber:Equipment:ManufacturingAsset)
(:DryPump:EquipmentModule:VacuumPump:ManufacturingAsset)

Process Hierarchy (SEMI + ISA-95):
(:SemiconductorProcess:ManufacturingProcess)
(:ProcessRecipe:Recipe:ManufacturingSpecification)
(:ProcessRun:ProductionRun:ManufacturingExecution)
```

### **Key Relationship Types**:
```
Equipment Containment:
[:PART_OF] - Physical containment (chamber partOf tool)
[:LOCATED_IN] - Location relationship (tool locatedIn area)
[:SERVES] - Service relationship (pump serves chamber)

Process Execution:  
[:RUNS] - Process execution (tool runs process)
[:EXECUTES] - Recipe execution (chamber executes recipe)
[:REQUIRES] - Dependency (recipe requires vacuum)

Risk Assessment:
[:HAS_SURVIVAL_MODEL], [:HAS_RUL], [:HAS_FAILURE_PROBABILITY]
[:HAS_CRITICALITY_LEVEL], [:IMPACTS_PROCESS], [:AFFECTS_TOOL]
[:CRITICAL_FOR] - Business criticality (pump criticalFor process)

Mathematical Calculation:
[:HAS_WEIBULL_HAZARD], [:HAS_CONDITION_HAZARD], [:HAS_BLENDED_HAZARD]
[:CALCULATED_FROM], [:BLENDED_INTO], [:GENERATES]
```

### **Example Neo4j Graph Structure**:
```
(fab1:Fab:Site {fabId: "FAB1", location: "Austin"})
  -[:CONTAINS]->
(dryEtchArea:FabArea:Area {areaId: "DRY_ETCH", cleanClass: "ISO5"})
  -[:CONTAINS]->
(etchTool:SemiconductorTool:WorkUnit {toolId: "ETCH_02", toolType: "PlasmaEtch"})
  -[:CONTAINS]->
(chamber1:ProcessChamber:Equipment {chamberId: "CH1", chamberType: "Process"})
  <-[:SERVES]-
(pump001:DryPump:EquipmentModule {pumpId: "P001", model: "Edwards nXDS20i"})

(pump001)-[:HAS_SURVIVAL_MODEL]->(weibullModel:WeibullSurvivalFunction {rho: 1.42, beta: 527.44})
(pump001)-[:HAS_RUL]->(rulAssessment:RemainingUsefulLife {rulDays: 180})
(pump001)-[:HAS_CRITICALITY_LEVEL]->(level4:CriticalityLevel4 {description: "High Impact"})
(pump001)-[:HAS_FAILURE_PROBABILITY]->(prob30:ThirtyDayFailureProbability {probability: 0.12})
```

## Extension Points for Equipment Hierarchy Growth

### **Additional Equipment Types**:
```
VacuumEquipment (Current)
├── VacuumPump 
│   ├── DryPump ✅ (Current focus)
│   ├── TurboPump (future)
│   └── RoughingPump (future)
├── VacuumChamber (future)
├── VacuumGauge (future)  
├── VacuumValve (future)
└── VacuumController (future)
```

### **Extended Tool Types**:
```
SemiconductorTool (Current foundation)
├── EtchTool ✅ (Implemented)
├── DepositionTool (future - CVD, PVD, ALD)
├── ImplantTool (future - Ion implantation)
├── LithographyTool (future - Photolithography)
├── MetrologyTool (future - Inspection)
└── CleanTool (future - Wet/dry cleaning)
```

### **Advanced Process Modeling**:
```
SemiconductorProcess (Current foundation)
├── ProcessFlow (future - multi-step sequences)
├── ProcessControl (future - advanced process control)
├── ProcessOptimization (future - yield optimization)
└── ProcessVariation (future - statistical process control)
```

### **Integration Points with External Systems**:
```
Manufacturing Execution System (MES)
├── ISA-95 Integration ✅ (Foundation ready)
├── SEMI Standards Compliance ✅ (Equipment states)
└── MIMOSA Integration ✅ (Asset management)

Enterprise Systems
├── ERP Integration (future - SAP, Oracle)
├── CMMS Integration (future - Maximo, Infor)
└── Quality Systems (future - SPC, yield management)
```

---

**Design Philosophy**: Mathematics-first hierarchy optimized for AI agent computational requirements

**Extensibility**: Clear extension points for additional distributions, equipment types, and health models

**Validation**: All competency questions from Step 3 are answerable with this hierarchy

**Implementation Ready**: Neo4j labels and relationships defined for immediate development

**Next Step**: [Step 5: Define Properties](05-properties.md) - Mathematical and temporal properties

**Status**: ✅ Complete - Mathematical Class Hierarchy for Survival Analysis

**Last Updated**: July 18, 2025