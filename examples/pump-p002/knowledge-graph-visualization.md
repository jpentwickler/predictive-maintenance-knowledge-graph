```mermaid
graph TD
    %% Equipment Hierarchy
    FAB2["🏭 Fab<br/>FAB2<br/>Dresden, Germany<br/>75,000 wafers/month"]
    CVD["🧪 FabArea<br/>CVD_DEPOSITION<br/>ISO4 Cleanroom<br/>22.5°C, 45.2% RH"]
    PECVD["⚙️ SemiconductorTool<br/>PECVD_05<br/>Applied Materials Producer GT<br/>87% Utilization"]
    CH2["🔬 ProcessChamber<br/>CH2<br/>2×10⁻⁷ Torr<br/>350°C Target"]
    P002["🔧 DryPump<br/>P002<br/>Pfeiffer HiPace 700<br/>Level5 Criticality<br/>285 days old"]

    %% Mathematical Models
    WEIBULL["📊 WeibullSurvivalFunction<br/>WEIBULL_P002_v2.1<br/>Shape: 1.68<br/>Scale: 612.35 days<br/>Confidence: 91%"]
    RUL["📈 RemainingUsefulLife<br/>RUL_P002_20250721<br/>142 days remaining<br/>Health Index: 0.28<br/>Degrading trend"]
    HAZARD["⚠️ BlendedHazardFunction<br/>HAZARD_P002_20250721<br/>Weibull: 0.062<br/>Condition: 0.211<br/>Blended: 0.146"]
    PRED["🎯 ThirtyDayFailureProbability<br/>PRED_P002_20250721<br/>13.6% Failure Risk<br/>Risk Class: D<br/>Medium Alert"]

    %% Process Integration
    PROCESS["🏭 SemiconductorProcess<br/>CVD_SILICON_NITRIDE<br/>7nm Technology<br/>High Criticality"]
    RECIPE["📋 ProcessRecipe<br/>CVD_SiN_V3.2<br/>Silicon Nitride Standard<br/>1×10⁻⁷ Torr Required"]
    REPORT["📊 MaintenanceReport<br/>RPT_20250721_002<br/>Daily Assessment<br/>Generated: 12:00 UTC"]

    %% Equipment Hierarchy Relationships
    FAB2 -->|CONTAINS| CVD
    CVD <--|LOCATED_IN| PECVD
    PECVD <--|PART_OF| CH2
    P002 -->|SERVES<br/>Primary Pump| CH2

    %% Mathematical Model Relationships
    P002 -->|HAS_SURVIVAL_MODEL<br/>v2.1 Active| WEIBULL
    P002 -->|HAS_RUL_ASSESSMENT<br/>Scheduled| RUL
    P002 -->|HAS_HAZARD_CALCULATION| HAZARD
    P002 -->|HAS_FAILURE_PREDICTION<br/>0.038s calc time| PRED

    %% Mathematical Calculation Chain
    HAZARD -->|CALCULATED_FROM_SURVIVAL<br/>60% weight| WEIBULL
    HAZARD -->|CALCULATED_FROM_RUL<br/>40% weight| RUL
    HAZARD -->|GENERATES_PREDICTION<br/>P = 1-exp(-H)| PRED

    %% Process Integration Relationships
    CH2 -->|EXECUTES| RECIPE
    RECIPE -->|PART_OF_PROCESS| PROCESS
    P002 -->|CRITICAL_FOR<br/>High Impact| PROCESS

    %% Reporting Relationships
    REPORT -->|INCLUDES_PUMP| P002
    REPORT -->|INCLUDES_PREDICTION| PRED

    %% Styling
    classDef equipmentNode fill:#e3f2fd,stroke:#1976d2,stroke-width:3px,color:#000
    classDef mathNode fill:#f3e5f5,stroke:#7b1fa2,stroke-width:3px,color:#000
    classDef processNode fill:#e8f5e8,stroke:#388e3c,stroke-width:3px,color:#000
    classDef reportNode fill:#fff3e0,stroke:#f57c00,stroke-width:3px,color:#000
    
    class FAB2,CVD,PECVD,CH2,P002 equipmentNode
    class WEIBULL,RUL,HAZARD,PRED mathNode
    class PROCESS,RECIPE processNode
    class REPORT reportNode
```

# P002 Knowledge Graph Visualization

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
