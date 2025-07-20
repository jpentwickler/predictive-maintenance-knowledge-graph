# Step 6: Define Constraints - Data Quality for 30-Day Risk Reports 🔒

> **Methodology Reference**: Noy & McGuinness (2000) - Step 6 of the 7-step iterative ontology development process
> 
> **Focus**: Essential constraints to ensure reliable 30-day failure probability calculations and risk assessment reports

## Design Philosophy

**Report-Focused Constraints**: Every constraint ensures the AI agent can generate accurate, reliable 30-day failure probability reports for dry pumps.

**Mathematical Integrity**: Constraints guarantee the survival analysis calculations produce valid results:
```
P_30(t) = 1 - exp[-(λ_W(t) + k·λ_R(t))]
Where: λ_W(t) = ((t+30)^ρ - t^ρ)/β^ρ and λ_R(t) = 30/RUL(t)
```

**Data Quality Assurance**: Constraints prevent invalid data from corrupting risk assessments that guide maintenance decisions.

---

## Constraint Categories Overview

### 🎯 **Essential Constraints for Risk Reports**
1. **Mathematical Validation**: Ensure calculation parameters are mathematically valid
2. **Data Completeness**: Ensure required data exists for 30-day predictions
3. **Business Logic**: Ensure risk classifications align with failure probabilities
4. **Temporal Consistency**: Ensure time-related data makes logical sense
5. **Report Integrity**: Ensure generated reports are complete and actionable

---

## 1. Mathematical Validation Constraints 🧮

### **Weibull Parameter Constraints**

**Why These Matter**: Invalid Weibull parameters break the survival analysis calculation, making failure predictions meaningless.

#### **C1.1: Weibull Shape Parameter Validity**
```
CONSTRAINT: hasWeibullShape > 0
```
**Plain English**: The Weibull shape parameter (ρ) must be a positive number.

**Why**: A zero or negative shape parameter makes the survival function mathematically undefined. This would crash the calculation: `λ_W(t) = ((t+30)^ρ - t^ρ)/β^ρ`

**Business Impact**: Without valid shape parameters, we cannot predict when pumps will fail, making maintenance planning impossible.

#### **C1.2: Weibull Scale Parameter Validity**
```
CONSTRAINT: hasWeibullScale > 0
```
**Plain English**: The Weibull scale parameter (β) must be a positive number.

**Why**: A zero or negative scale parameter makes the survival function meaningless and would cause division by zero in the hazard calculation.

**Business Impact**: Invalid scale parameters lead to nonsensical failure predictions (infinite risk or negative risk).

#### **C1.3: Weibull Location Parameter Validity**
```
CONSTRAINT: hasWeibullLocation >= 0
```
**Plain English**: The Weibull location parameter (γ) must be zero or positive.

**Why**: Negative location parameters imply equipment can fail before it's installed, which is physically impossible.

**Business Impact**: Prevents unrealistic failure predictions that would trigger unnecessary maintenance actions.

### **Probability and Rate Constraints**

#### **C1.4: Blending Weight Bounds**
```
CONSTRAINT: hasBlendingWeight >= 0 AND hasBlendingWeight <= 1
```
**Plain English**: The condition monitoring weight (k) must be between 0 and 1 (inclusive).

**Why**: The blending weight represents how much we trust condition monitoring vs. historical data. Values outside [0,1] don't make mathematical sense.

**Business Impact**: Invalid blending weights could over-emphasize unreliable condition data or completely ignore current equipment health.

#### **C1.5: Failure Probability Bounds**
```
CONSTRAINT: hasFailureProbability >= 0 AND hasFailureProbability <= 1
```
**Plain English**: The 30-day failure probability must be between 0% and 100%.

**Why**: Probabilities outside [0,1] are mathematically impossible and indicate calculation errors.

**Business Impact**: Invalid probabilities would lead to incorrect risk classifications and inappropriate maintenance decisions.

#### **C1.6: Health Index Bounds**
```
CONSTRAINT: healthIndex >= 0 AND healthIndex <= 1
```
**Plain English**: Equipment health scores must be between 0 (nominal/baseline behavior) and 1 (extreme anomaly/maximal degradation).

**Why**: Health indices are normalized anomaly scores where 0 represents baseline healthy operation and 1 represents maximum deviation from normal behavior.

**Business Impact**: Invalid health scores lead to incorrect RUL estimates and poor failure predictions.

---

## 2. Data Completeness Constraints 📊

### **Required Data for Calculations**

**Why These Matter**: Missing critical data prevents the AI agent from calculating failure probabilities, resulting in incomplete or failed reports.

#### **C2.1: Essential Pump Data**
```
CONSTRAINT: Every DryPump MUST have pumpIdentifier AND currentAge
```
**Plain English**: Every pump must have a unique ID and we must know how old it is.

**Why**: 
- `pumpIdentifier` is needed to identify which pump the risk assessment applies to
- `currentAge` is required for the survival analysis calculation: `λ_W(t)` where `t = currentAge`

**Business Impact**: Without these, we can't generate pump-specific risk reports, making maintenance planning impossible.

#### **C2.2: Weibull Model Completeness**
```
CONSTRAINT: IF hasFailureProbability EXISTS 
            THEN hasWeibullShape AND hasWeibullScale MUST EXIST
```
**Plain English**: If we're predicting failure probability, we must have complete Weibull model parameters.

**Why**: The survival calculation requires both shape (ρ) and scale (β) parameters. Missing either makes the calculation impossible.

**Business Impact**: Incomplete models would result in failed calculations and missing risk assessments for critical equipment.

#### **C2.3: Condition Monitoring Data Requirements**
```
CONSTRAINT: IF hasBlendingWeight > 0 
            THEN remainingUsefulLife MUST EXIST AND remainingUsefulLife > 0
```
**Plain English**: If we're using condition monitoring data in our prediction, we must have a valid remaining useful life estimate.

**Why**: The condition hazard calculation requires RUL: `λ_R(t) = 30/RUL(t)`. Missing or zero RUL makes this impossible.

**Business Impact**: Without RUL data, we can't leverage current equipment condition, reducing prediction accuracy.

---

## 3. Business Logic Constraints 🏢

### **Risk Classification Alignment**

**Why These Matter**: Risk classifications guide maintenance decisions. They must accurately reflect the calculated failure probabilities to ensure appropriate actions.

#### **C3.1: Risk Classification Consistency**
```
CONSTRAINT: riskClassification MUST align with hasFailureProbability ranges:
- "A" (Critical) ↔ hasFailureProbability ≥ 0.80 (≥ 80%)
- "B" (High) ↔ 0.60 ≤ hasFailureProbability < 0.80 (60-80%)  
- "C" (Medium) ↔ 0.30 ≤ hasFailureProbability < 0.60 (30-60%)
- "D" (Low-Medium) ↔ 0.10 ≤ hasFailureProbability < 0.30 (10-30%)
- "E" (Low) ↔ hasFailureProbability < 0.10 (< 10%)
```
**Plain English**: The risk letter grade must match the calculated failure probability percentage, with A being the highest risk and E being the lowest risk.

**Why**: Inconsistent risk classifications confuse maintenance teams and could lead to inappropriate responses (ignoring critical equipment or over-maintaining healthy equipment).

**Business Impact**: Misaligned classifications waste maintenance resources and increase the risk of unexpected failures.

#### **C3.2: Criticality Level Validity**
```
CONSTRAINT: criticalityLevel MUST be one of {Level1, Level2, Level3, Level4, Level5}
```
**Plain English**: Equipment criticality must be assigned to one of five predefined business impact levels.

**Why**: Standardized criticality levels ensure consistent risk assessment and resource allocation across the organization.

**Business Impact**: Invalid criticality levels prevent proper maintenance prioritization and resource planning.

#### **C3.3: Service Role Validation**
```
CONSTRAINT: serviceRole MUST be one of {Primary, Backup, Roughing}
```
**Plain English**: Each pump must be assigned a specific role in the vacuum system.

**Why**: Pump role affects maintenance priority - primary pumps are more critical than backup pumps.

**Business Impact**: Undefined roles lead to inappropriate maintenance scheduling and potential process disruptions.

---

## 4. Temporal Consistency Constraints 🕒

### **Time Logic Validation**

**Why These Matter**: Illogical time relationships corrupt the mathematical models and make predictions unreliable.

#### **C4.1: Age Validity**
```
CONSTRAINT: currentAge >= 0
```
**Plain English**: Equipment age cannot be negative.

**Why**: Negative age is physically impossible and would break the survival analysis calculation.

**Business Impact**: Invalid ages lead to nonsensical failure predictions and poor maintenance decisions.

#### **C4.2: Prediction Window Logic**
```
CONSTRAINT: predictionWindowEnd > predictionWindowStart
AND predictionWindowEnd = predictionWindowStart + 30 days
```
**Plain English**: The prediction window must be exactly 30 days and end after it starts.

**Why**: The entire system is designed for 30-day predictions. Different windows would invalidate the mathematical models.

**Business Impact**: Wrong prediction windows make the risk assessments meaningless for maintenance planning.

#### **C4.3: Timestamp Ordering**
```
CONSTRAINT: lastTelemetryUpdate <= predictionTimestamp
```
**Plain English**: Health assessment data cannot be from the future relative to when the prediction was made.

**Why**: Using future data for current predictions is logically impossible and indicates data corruption.

**Business Impact**: Time inconsistencies undermine confidence in the prediction system.

#### **C4.4: RUL Temporal Logic**
```
CONSTRAINT: IF remainingUsefulLife > 0 
            THEN remainingUsefulLife >= 30
            OR hasFailureProbability > 0.99
```
**Plain English**: If RUL is less than 30 days, the failure probability should be very high (>99%).

**Why**: Equipment predicted to fail within 30 days should have very high failure probability for that same period.

**Business Impact**: Inconsistent RUL and probability data confuses maintenance planning and emergency response.

---

## 5. Report Integrity Constraints 📋

### **Complete Report Requirements**

**Why These Matter**: Incomplete reports cannot guide maintenance decisions effectively and waste stakeholder time.

#### **C5.1: Report Completeness**
```
CONSTRAINT: Every ReportGeneration MUST have:
- reportId (unique identifier)
- reportGenerationTime (when created)  
- At least one ThirtyDayFailureProbability assessment
```
**Plain English**: Every report must be uniquely identified, timestamped, and contain at least one pump risk assessment.

**Why**: Empty or unidentifiable reports provide no value to maintenance teams.

**Business Impact**: Incomplete reports delay maintenance decisions and reduce confidence in the prediction system.

#### **C5.2: Risk Assessment Completeness**
```
CONSTRAINT: Every ThirtyDayFailureProbability MUST have:
- hasFailureProbability (the calculated risk)
- riskClassification (A, B, C, D, or E)
- predictionTimestamp (when calculated)
```
**Plain English**: Every risk assessment must have a probability number, risk letter grade, and timestamp.

**Why**: Maintenance teams need all three pieces of information to make informed decisions.

**Business Impact**: Incomplete assessments force manual research and delay maintenance actions.

#### **C5.3: Calculation Traceability**
```
CONSTRAINT: Every ThirtyDayFailureProbability SHOULD have hasCalculationMethod
```
**Plain English**: We should track which algorithm version calculated each risk assessment.

**Why**: Traceability enables debugging, model validation, and continuous improvement.

**Business Impact**: Without traceability, we can't improve the prediction system or troubleshoot anomalies.

---

## 6. Data Quality Constraints 📈

### **Measurement Reliability**

**Why These Matter**: Poor quality input data leads to unreliable predictions and inappropriate maintenance decisions.

#### **C6.1: Data Freshness**
```
CONSTRAINT: (predictionTimestamp - lastTelemetryUpdate) <= 7 days
```
**Plain English**: Health assessment data used for predictions should be no more than 7 days old.

**Why**: Stale condition monitoring data may not reflect current equipment health, leading to inaccurate RUL estimates.

**Business Impact**: Old data could miss recent degradation, causing unexpected failures.

#### **C6.2: Data Quality Thresholds**
```
CONSTRAINT: IF dataQualityScore EXISTS THEN dataQualityScore >= 0.5
```
**Plain English**: If we're tracking data quality, it should meet minimum reliability standards (≥50%).

**Why**: Low-quality data produces unreliable predictions that could misguide maintenance decisions.

**Business Impact**: Poor quality predictions waste maintenance resources and increase failure risk.

#### **C6.3: Anomaly Flag Logic**
```
CONSTRAINT: IF hasAnomalyFlag = true 
            THEN actionRecommendation SHOULD include "Investigate anomaly"
```
**Plain English**: If we detect abnormal equipment behavior, the report should recommend investigation.

**Why**: Anomalies often indicate impending failures that require immediate attention.

**Business Impact**: Ignored anomalies can lead to unexpected failures and production disruptions.

---

## Neo4j Constraint Implementation

### **Database Constraints**

#### **Uniqueness Constraints**
```cypher
// Ensure pump identifiers are unique
CREATE CONSTRAINT pump_id_unique FOR (p:DryPump) REQUIRE p.pumpIdentifier IS UNIQUE;

// Ensure report identifiers are unique  
CREATE CONSTRAINT report_id_unique FOR (r:ReportGeneration) REQUIRE r.reportId IS UNIQUE;
```

#### **Existence Constraints**
```cypher
// Essential pump properties
CREATE CONSTRAINT pump_id_exists FOR (p:DryPump) REQUIRE p.pumpIdentifier IS NOT NULL;
CREATE CONSTRAINT pump_age_exists FOR (p:DryPump) REQUIRE p.currentAge IS NOT NULL;

// Essential prediction properties
CREATE CONSTRAINT prob_value_exists FOR (fp:ThirtyDayFailureProbability) 
REQUIRE fp.hasFailureProbability IS NOT NULL;

CREATE CONSTRAINT prob_timestamp_exists FOR (fp:ThirtyDayFailureProbability) 
REQUIRE fp.predictionTimestamp IS NOT NULL;
```

#### **Value Range Constraints**
```cypher
// Mathematical parameter bounds
CREATE CONSTRAINT weibull_shape_positive FOR (w:WeibullSurvivalFunction) 
REQUIRE w.hasWeibullShape > 0;

CREATE CONSTRAINT weibull_scale_positive FOR (w:WeibullSurvivalFunction) 
REQUIRE w.hasWeibullScale > 0;

// Probability bounds
CREATE CONSTRAINT probability_bounds FOR (fp:ThirtyDayFailureProbability) 
REQUIRE fp.hasFailureProbability >= 0 AND fp.hasFailureProbability <= 1;

// Age bounds
CREATE CONSTRAINT age_nonnegative FOR (p:DryPump) 
REQUIRE p.currentAge >= 0;
```

---

## Constraint Validation Examples

### **Valid Data Example**
```cypher
// This pump data satisfies all constraints
CREATE (pump:DryPump {
  pumpIdentifier: "P001",           // ✅ C2.1: Required identifier
  currentAge: 400,                  // ✅ C4.1: Non-negative age
  criticalityLevel: "Level4",       // ✅ C3.2: Valid criticality
  serviceRole: "Primary"            // ✅ C3.3: Valid service role
});

CREATE (prob:ThirtyDayFailureProbability {
  hasFailureProbability: 0.091,     // ✅ C1.5: Valid probability [0,1]
  riskClassification: "E",          // ✅ C3.1: Matches probability (9.1% = Low risk)
  predictionTimestamp: datetime("2025-07-20T10:30:00Z")  // ✅ C5.2: Required timestamp
});
```

### **Constraint Violation Examples**
```cypher
// ❌ This violates multiple constraints
CREATE (badPump:DryPump {
  // Missing pumpIdentifier - violates C2.1
  currentAge: -50,                  // ❌ C4.1: Negative age impossible
  criticalityLevel: "SuperCritical" // ❌ C3.2: Invalid criticality level
});

CREATE (badProb:ThirtyDayFailureProbability {
  hasFailureProbability: 1.5,      // ❌ C1.5: Probability > 1
  riskClassification: "E"          // ❌ C3.1: "E" doesn't match 150% probability
  // Missing predictionTimestamp - violates C5.2
});
```

---

## Constraint Priority Levels

### **Critical Constraints** (System Breaking)
- Mathematical parameter validity (C1.1, C1.2, C1.4, C1.5)
- Required data existence (C2.1, C2.2, C5.1, C5.2)
- Basic temporal logic (C4.1, C4.2)

**Impact**: Violations prevent calculation or report generation

### **Important Constraints** (Business Logic)
- Risk classification alignment (C3.1)
- Service role validation (C3.3)
- Criticality level validity (C3.2)
- Data freshness (C6.1)

**Impact**: Violations lead to poor maintenance decisions

### **Recommended Constraints** (Quality Assurance)
- Calculation traceability (C5.3)
- Data quality thresholds (C6.2)
- Anomaly flag logic (C6.3)

**Impact**: Violations reduce system reliability and improvement capability

---

## Implementation Strategy

### **Phase 1: Critical Constraints** (Week 1)
Implement mathematical and existence constraints to prevent system failures.

### **Phase 2: Business Logic Constraints** (Week 2)
Implement risk classification and validation constraints for reliable maintenance decisions.

### **Phase 3: Quality Assurance Constraints** (Week 3)
Implement data quality and traceability constraints for continuous improvement.

---

**Design Philosophy**: Constraints ensure the AI agent generates reliable, actionable 30-day failure risk reports

**Business Focus**: Every constraint directly supports better maintenance decision-making

**Implementation Ready**: Neo4j constraint syntax provided for immediate deployment

**Next Step**: [Step 7: Create Instances](07-instances.md) - Sample pump data and risk assessments

**Status**: ✅ Ready for Review - Essential Constraints for Risk Report Generation

**Last Updated**: July 20, 2025