# Step 3: Enumerate Terms - Risk Assessment Report for Dry Pumps 📝

> **Methodology Reference**: Noy & McGuinness (2000) - Step 3 of the 7-step iterative ontology development process

## Use Case Focus

**Primary Use Case**: Creating risk assessment reports for dry pumps in semiconductor manufacturing

**Risk Definition**: Risk = Likelihood of Failure × Criticality of Asset

**Scope**: Minimal viable terminology to support this specific use case, with growth potential

## Core Risk Assessment Formula

```
Risk Level = f(Failure Probability, Asset Criticality)
where:
- Failure Probability ∈ [0.0, 1.0] (from predictive models)
- Asset Criticality ∈ {1, 2, 3, 4, 5} (business-defined stages)
- Risk Level ∈ {A, B, C, D, E} (actionable classifications)
```

## Terminology Enumeration

### 🎯 **Core Risk Assessment Terms**

#### **Risk Concepts** (Custom - Core Innovation)
- **Risk**: Combination of failure likelihood and asset criticality
- **RiskLevel**: Categorical classification {A, B, C, D, E}
- **FailureProbability**: Quantitative likelihood of equipment failure [0.0-1.0]
- **AssetCriticality**: Business importance ranking {1, 2, 3, 4, 5}
- **RiskAssessment**: Evaluation process and results
- **RiskAssessmentReport**: Document containing risk analysis results

#### **Risk Level Classifications** (Custom)
- **RiskLevelA**: ≥80% failure probability - "Almost certain – act now"
- **RiskLevelB**: 60-79% failure probability - "Likely – schedule ASAP"  
- **RiskLevelC**: 30-59% failure probability - "Possible – monitor closely"
- **RiskLevelD**: 10-29% failure probability - "Unlikely – routine checks"
- **RiskLevelE**: <10% failure probability - "Rare – very low risk"

#### **Asset Criticality Levels** (Custom)
- **CriticalityLevel1**: Lowest business impact
- **CriticalityLevel2**: Low business impact
- **CriticalityLevel3**: Medium business impact  
- **CriticalityLevel4**: High business impact
- **CriticalityLevel5**: Critical business impact

### 🔧 **Equipment Terms** (Leveraging ISA-95 + SEMI + MIMOSA)

#### **Equipment Hierarchy** (Adopted from ISA-95)
- **Site**: Manufacturing facility location
- **Area**: Fab or production area within site
- **WorkUnit**: Production line or tool cluster
- **Equipment**: Individual manufacturing tool
- **EquipmentModule**: Subsystem within equipment (e.g., pump)

#### **Dry Pump Specific** (Custom + SEMI vocabulary)
- **DryPump**: Vacuum pump without oil lubrication (subclass of Equipment)
- **VacuumDryPump**: Specific type for semiconductor applications
- **PumpIdentifier**: Unique identifier for specific pump instance
- **PumpModel**: Manufacturer model designation
- **PumpSerialNumber**: Unique serial number from manufacturer

#### **Equipment Properties** (Leveraging MIMOSA + Custom)
- **EquipmentAge**: Time since installation (from MIMOSA concepts)
- **OperatingHours**: Cumulative runtime hours
- **InstallationDate**: Date equipment was commissioned
- **Manufacturer**: Equipment supplier organization
- **Location**: Physical installation position

### 📊 **Measurement and Units** (Leveraging QUDT)

#### **Probability and Statistics** (QUDT + Custom)
- **Probability**: Dimensionless value [0.0, 1.0] (QUDT:Dimensionless)
- **Percentage**: Probability expressed as percentage [0%, 100%] (QUDT:Percent)
- **Days**: Time unit for failure prediction windows (QUDT:Day)
- **Hours**: Time unit for operating duration (QUDT:Hour)

#### **Time Concepts** (Leveraging Schema.org + Custom)
- **AssessmentDate**: When risk assessment was performed (schema:Date)
- **ReportDate**: When report was generated (schema:Date)
- **PredictionWindow**: Time period for failure probability (e.g., 30 days)
- **NextAssessmentDate**: Scheduled date for next evaluation

### 📋 **Reporting Terms** (Leveraging Schema.org + Custom)

#### **Report Structure** (Schema.org foundation)
- **Report**: Structured document containing information (schema:Report)
- **RiskAssessmentReport**: Specific report type for risk analysis
- **ReportTitle**: Descriptive title of the report (schema:name)
- **ReportAuthor**: Person or system generating report (schema:author)
- **ReportDate**: Date of report creation (schema:dateCreated)

#### **Report Content** (Custom)
- **ExecutiveSummary**: High-level overview for management
- **TechnicalDetails**: Detailed analysis for engineering teams
- **ActionItems**: Recommended actions based on risk levels
- **RiskMatrix**: Visual representation of risk across assets

#### **Stakeholders** (Leveraging FOAF)
- **Person**: Individual stakeholder (foaf:Person)
- **Organization**: Company or department (foaf:Organization)
- **MaintenanceManager**: Person responsible for maintenance decisions
- **ProcessEngineer**: Person responsible for equipment operation
- **ExecutiveLeader**: Person receiving executive summaries

### 🤖 **AI Agent Terms** (Custom - Core Innovation)

#### **Assessment Process** (Custom)
- **RiskCalculation**: Process of computing risk from inputs
- **FailurePrediction**: AI process for estimating failure probability
- **CriticalityMapping**: Process of assigning business criticality
- **ReportGeneration**: Process of creating formatted reports

#### **Decision Support** (Custom)
- **RecommendedAction**: AI-suggested response to risk level
- **ActionPriority**: Urgency ranking for recommended actions
- **EscalationRequired**: Boolean flag for human expert involvement
- **ConfidenceLevel**: AI assessment of prediction reliability

## Ontology Mapping Strategy

### ✅ **Adopted Standard Terms**

| Concept | Source Ontology | Specific Term | Justification |
|---------|----------------|---------------|---------------|
| Equipment Hierarchy | ISA-95 | Site, Area, WorkUnit, Equipment | Industry standard manufacturing structure |
| Probability Units | QUDT | Dimensionless, Percent | Standard measurement representation |
| Date/Time | Schema.org | Date, dateCreated | Web-standard temporal concepts |
| People/Organizations | FOAF | Person, Organization | Standard stakeholder modeling |
| Reports | Schema.org | Report, name, author | Standard document structure |
| Asset Management | MIMOSA | Equipment age, operating hours | Proven maintenance concepts |

### 🚀 **Custom Innovation Terms**

| Concept | Rationale | Growth Potential |
|---------|-----------|-----------------|
| Risk Level (A-E) | Domain-specific classification system | Can extend to more granular levels |
| Failure Probability Calculation | Core AI/ML innovation | Can add multiple prediction methods |
| Asset Criticality Levels | Business-specific importance ranking | Can become industry standard |
| Dry Pump Specific Terms | Equipment-focused vocabulary | Can extend to other pump types |
| AI Agent Decision Terms | Autonomous decision support | Foundation for broader AI capabilities |

## Minimal Viable Vocabulary

For the **initial implementation**, focus on these essential terms:

### **Core Set (Week 1)**
```
Classes: DryPump, RiskAssessment, RiskLevel, FailureProbability, AssetCriticality
Properties: hasRiskLevel, hasProbability, hasCriticality, assessmentDate
Individuals: RiskLevelA, RiskLevelB, RiskLevelC, RiskLevelD, RiskLevelE
```

### **Reporting Extension (Week 2)**
```
Classes: RiskAssessmentReport, ActionItem, RecommendedAction
Properties: hasReport, hasActionItem, reportDate, recommendedBy
```

### **Stakeholder Extension (Week 3)**
```
Classes: MaintenanceManager, ProcessEngineer (subclasses of foaf:Person)
Properties: reportedTo, responsibleFor, notificationRequired
```

## Growth Strategy

### **Phase 1: Core Risk Assessment** (Current)
- Basic risk calculation (probability × criticality)
- Simple A-E classification
- Dry pump equipment modeling

### **Phase 2: Enhanced Reporting** (Next)
- Stakeholder-specific report content
- Action item tracking
- Historical trend analysis

### **Phase 3: Advanced Analytics** (Future)
- Multiple failure prediction methods
- Dynamic criticality assessment
- Cross-equipment risk correlation

## Validation Questions

This terminology should enable answering:

1. **Basic Risk Assessment**:
   - What is the current risk level for pump P001?
   - Which pumps have risk level A or B?
   - How was the risk level calculated?

2. **Risk Components**:
   - What is the failure probability for pump P001?
   - What is the criticality level of pump P001?
   - When was this assessment performed?

3. **Reporting**:
   - Generate risk assessment report for all dry pumps
   - Who should receive risk level A notifications?
   - What actions are recommended for risk level B pumps?

4. **Equipment Context**:
   - Which equipment area contains the highest risk pumps?
   - How many high-risk pumps are in Area A?
   - What are the details of pump P001 (model, age, location)?

## Term Relationships Preview

```
DryPump --hasRiskAssessment--> RiskAssessment
RiskAssessment --hasRiskLevel--> RiskLevel
RiskAssessment --hasFailureProbability--> FailureProbability  
RiskAssessment --considersCriticality--> AssetCriticality
RiskAssessment --generatesReport--> RiskAssessmentReport
RiskAssessmentReport --sentTo--> Person
Person --hasRole--> MaintenanceManager | ProcessEngineer
```

## Implementation Notes

### **Reuse Decisions Made**:
- ✅ Use ISA-95 equipment hierarchy (proven standard)
- ✅ Use QUDT for probability units (avoid unit confusion)
- ✅ Use Schema.org for basic report structure (web compatibility)
- ✅ Use FOAF for stakeholder modeling (standard approach)

### **Custom Decisions Made**:
- 🚀 Custom A-E risk classification (matches business needs)
- 🚀 Custom failure probability calculation (core IP)
- 🚀 Custom criticality levels (business-specific)
- 🚀 Custom AI agent decision terms (competitive advantage)

### **Growth Points Identified**:
- Additional equipment types (beyond dry pumps)
- Multiple prediction algorithms
- Real-time risk monitoring
- Predictive maintenance scheduling

---

**Next Step**: [Step 4: Define Classes](04-classes-hierarchy.md) - Create class hierarchy for risk assessment report use case

**Status**: ✅ Complete - Minimal Viable Terminology

**Scope**: Risk assessment reports for dry pumps with growth potential

**Last Updated**: July 18, 2025

---

## Quick Reference: Essential Terms

**Risk**: FailureProbability × AssetCriticality → RiskLevel {A,B,C,D,E}

**Equipment**: DryPump (ISA-95 Equipment hierarchy)

**Report**: RiskAssessmentReport → Stakeholders (FOAF Person/Organization)

**AI Support**: RecommendedAction, ConfidenceLevel, EscalationRequired
