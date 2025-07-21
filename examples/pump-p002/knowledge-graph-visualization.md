```mermaid
graph TD
%% Nodes
Fab["Fab<br/>fabId: STRING | KEY<br/>fabLocation: STRING<br/>fabCapacity: INTEGER"]
FabArea["FabArea<br/>areaId: STRING | KEY<br/>areaType: STRING<br/>cleanClass: STRING"]
SemiconductorTool["SemiconductorTool<br/>toolId: STRING | KEY<br/>toolType: STRING<br/>toolModel: STRING"]
ProcessChamber["ProcessChamber<br/>chamberId: STRING | KEY<br/>chamberType: STRING<br/>operatingPressure: FLOAT"]
DryPump["DryPump<br/>pumpIdentifier: STRING | KEY<br/>pumpModel: STRING<br/>criticalityLevel: STRING<br/>currentAge: INTEGER"]
WeibullSurvivalFunction["WeibullSurvivalFunction<br/>modelId: STRING | KEY<br/>weibullShape: FLOAT<br/>weibullScale: FLOAT"]
RemainingUsefulLife["RemainingUsefulLife<br/>rulId: STRING | KEY<br/>remainingUsefulLife: INTEGER<br/>healthIndex: FLOAT"]
BlendedHazardFunction["BlendedHazardFunction<br/>hazardId: STRING | KEY<br/>blendedHazard: FLOAT<br/>blendingWeight: FLOAT"]
ThirtyDayFailureProbability["ThirtyDayFailureProbability<br/>predictionId: STRING | KEY<br/>failureProbability: FLOAT<br/>riskClassification: STRING"]
SemiconductorProcess["SemiconductorProcess<br/>processId: STRING | KEY<br/>processName: STRING<br/>criticalityLevel: STRING"]
ProcessRecipe["ProcessRecipe<br/>recipeId: STRING | KEY<br/>recipeName: STRING<br/>recipeVersion: STRING"]
MaintenanceReport["MaintenanceReport<br/>reportId: STRING | KEY<br/>reportType: STRING<br/>totalPumpsAssessed: INTEGER"]

%% Relationships
Fab -->|CONTAINS| FabArea
SemiconductorTool -->|LOCATED_IN| FabArea
ProcessChamber -->|PART_OF| SemiconductorTool
DryPump -->|SERVES| ProcessChamber
DryPump -->|HAS_SURVIVAL_MODEL| WeibullSurvivalFunction
DryPump -->|HAS_RUL_ASSESSMENT| RemainingUsefulLife
DryPump -->|HAS_HAZARD_CALCULATION| BlendedHazardFunction
DryPump -->|HAS_FAILURE_PREDICTION| ThirtyDayFailureProbability
BlendedHazardFunction -->|CALCULATED_FROM_SURVIVAL| WeibullSurvivalFunction
BlendedHazardFunction -->|CALCULATED_FROM_RUL| RemainingUsefulLife
BlendedHazardFunction -->|GENERATES_PREDICTION| ThirtyDayFailureProbability
ProcessChamber -->|EXECUTES| ProcessRecipe
ProcessRecipe -->|PART_OF_PROCESS| SemiconductorProcess
DryPump -->|CRITICAL_FOR| SemiconductorProcess
MaintenanceReport -->|INCLUDES_PUMP| DryPump
MaintenanceReport -->|INCLUDES_PREDICTION| ThirtyDayFailureProbability

%% Styling 
classDef node_0_color fill:#e3f2fd,stroke:#1976d2,stroke-width:3px,color:#000,font-size:12px
class Fab node_0_color

classDef node_1_color fill:#f3e5f5,stroke:#7b1fa2,stroke-width:3px,color:#000,font-size:12px
class FabArea node_1_color

classDef node_2_color fill:#e8f5e8,stroke:#388e3c,stroke-width:3px,color:#000,font-size:12px
class SemiconductorTool node_2_color

classDef node_3_color fill:#fff3e0,stroke:#f57c00,stroke-width:3px,color:#000,font-size:12px
class ProcessChamber node_3_color

classDef node_4_color fill:#fce4ec,stroke:#c2185b,stroke-width:3px,color:#000,font-size:12px
class DryPump node_4_color

classDef node_5_color fill:#e0f2f1,stroke:#00695c,stroke-width:3px,color:#000,font-size:12px
class WeibullSurvivalFunction node_5_color

classDef node_6_color fill:#f1f8e9,stroke:#689f38,stroke-width:3px,color:#000,font-size:12px
class RemainingUsefulLife node_6_color

classDef node_7_color fill:#fff8e1,stroke:#ffa000,stroke-width:3px,color:#000,font-size:12px
class BlendedHazardFunction node_7_color

classDef node_8_color fill:#e8eaf6,stroke:#3f51b5,stroke-width:3px,color:#000,font-size:12px
class ThirtyDayFailureProbability node_8_color

classDef node_9_color fill:#efebe9,stroke:#5d4037,stroke-width:3px,color:#000,font-size:12px
class SemiconductorProcess node_9_color

classDef node_10_color fill:#fafafa,stroke:#424242,stroke-width:3px,color:#000,font-size:12px
class ProcessRecipe node_10_color

classDef node_11_color fill:#e1f5fe,stroke:#0277bd,stroke-width:3px,color:#000,font-size:12px
class MaintenanceReport node_11_color
```

# P002 Knowledge Graph Visualization

## Knowledge Graph Structure Overview

The diagram above shows the complete knowledge graph structure for pump P002, demonstrating all entity types and their relationships in the predictive maintenance system.

## P002 Instance - Specific Values

For the actual P002 pump instance, here are the specific values:

### 🏭 Equipment Hierarchy
- **Fab**: FAB2 (Dresden, Germany, 75,000 wafers/month)
- **FabArea**: CVD_DEPOSITION (ISO4 cleanroom, 22.5°C)
- **SemiconductorTool**: PECVD_05 (Applied Materials Producer GT, 87% utilization)
- **ProcessChamber**: CH2 (2×10⁻⁷ Torr, 350°C target)
- **DryPump**: P002 (Pfeiffer HiPace 700, Level5 criticality, 285 days old)

### 🧮 Mathematical Models
- **WeibullSurvivalFunction**: Shape=1.68, Scale=612.35 days, 91% confidence
- **RemainingUsefulLife**: 142 days remaining, Health Index=0.28 (degrading)
- **BlendedHazardFunction**: 0.146 total hazard (40% blending weight)
- **ThirtyDayFailureProbability**: 13.6% failure risk (Class D)

### 🏭 Process Integration
- **SemiconductorProcess**: Silicon Nitride CVD (7nm technology, high criticality)
- **ProcessRecipe**: CVD_SiN_V3.2 (1×10⁻⁷ Torr requirement)
- **MaintenanceReport**: RPT_20250721_002 (daily assessment)

## Mathematical Calculation Flow

```
📊 Historical Data (247 pumps, 189 failures)
    ↓ Maximum Likelihood Fitting
📈 Weibull Model (β=1.68, η=612.35)
    ↓ Hazard Calculation: λ_W(t)
⚠️  Weibull Hazard = 0.062

📡 Real-time Telemetry (300s frequency)
    ↓ ML Condition Assessment  
📊 RUL Assessment (142 days, health=0.28)
    ↓ Hazard Calculation: λ_R(t) = 30/RUL
⚠️  Condition Hazard = 0.211

🔄 Blended Hazard Calculation
    H_30(t) = λ_W(t) + k × λ_R(t)
    H_30(t) = 0.062 + 0.4 × 0.211 = 0.146

🎯 Failure Probability Conversion
    P_30(t) = 1 - exp(-H_30(t))
    P_30(t) = 1 - exp(-0.146) = 0.136 (13.6%)

📊 Risk Classification
    13.6% → Risk Class D (Low-Medium Risk)
    Recommendation: Monitor Continuously
```

## Business Impact Summary

| Metric | Value | Impact |
|--------|-------|--------|
| **Pump Criticality** | Level5 | Highest business priority |
| **Process Impact** | Silicon Nitride CVD | Critical for 7nm technology |
| **Tool Utilization** | 87% | High productivity impact |
| **Failure Probability** | 13.6% | Medium risk, monitor closely |
| **Remaining Life** | 142 days | Plan replacement/maintenance |
| **Business Impact Score** | 0.78 | High financial impact if failure |

## Key Insights

### 🔍 **Predictive Analytics**
- **Early Detection**: Mathematical model predicts potential failure 142 days in advance
- **Multi-modal Assessment**: Combines historical reliability with real-time condition monitoring
- **Confidence Tracking**: 83% prediction confidence with ±2.5% uncertainty band

### ⚙️ **Operational Excellence**
- **Complete Traceability**: Full equipment hierarchy from fab to individual pump
- **Process Integration**: Direct linkage to critical manufacturing processes
- **Real-time Monitoring**: 5-minute telemetry updates with anomaly detection

### 📈 **Business Value**
- **Risk Quantification**: Converts complex analytics into actionable risk classifications
- **Maintenance Optimization**: Enables condition-based rather than calendar-based maintenance
- **Cost Avoidance**: Prevents unplanned downtime for high-value CVD processes

---

**Generated**: July 21, 2025  
**Model**: Blended Hazard v2.1.3  
**Status**: Production Example
