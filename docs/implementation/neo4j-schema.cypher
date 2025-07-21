# Neo4j Schema Implementation for Vacuum Dry Pump Predictive Maintenance

> **Purpose**: Complete Neo4j database schema for implementing the approved knowledge graph model
> 
> **Version**: v1.0 | **Date**: July 21, 2025 | **Status**: Production Ready

## Schema Deployment

Execute these Cypher statements in order to create the complete database schema:

### 1. Create Unique Constraints (Primary Keys)

```cypher
// Equipment entity constraints
CREATE CONSTRAINT pump_id_unique IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.pumpIdentifier IS UNIQUE;

CREATE CONSTRAINT chamber_id_unique IF NOT EXISTS 
FOR (c:ProcessChamber) REQUIRE c.chamberId IS UNIQUE;

CREATE CONSTRAINT tool_id_unique IF NOT EXISTS 
FOR (t:SemiconductorTool) REQUIRE t.toolId IS UNIQUE;

CREATE CONSTRAINT area_id_unique IF NOT EXISTS 
FOR (a:FabArea) REQUIRE a.areaId IS UNIQUE;

CREATE CONSTRAINT fab_id_unique IF NOT EXISTS 
FOR (f:Fab) REQUIRE f.fabId IS UNIQUE;

// Mathematical model constraints
CREATE CONSTRAINT weibull_model_id_unique IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) REQUIRE w.modelId IS UNIQUE;

CREATE CONSTRAINT rul_id_unique IF NOT EXISTS 
FOR (r:RemainingUsefulLife) REQUIRE r.rulId IS UNIQUE;

CREATE CONSTRAINT hazard_id_unique IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.hazardId IS UNIQUE;

CREATE CONSTRAINT prediction_id_unique IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.predictionId IS UNIQUE;

// Process and reporting constraints
CREATE CONSTRAINT process_id_unique IF NOT EXISTS 
FOR (p:SemiconductorProcess) REQUIRE p.processId IS UNIQUE;

CREATE CONSTRAINT recipe_id_unique IF NOT EXISTS 
FOR (r:ProcessRecipe) REQUIRE r.recipeId IS UNIQUE;

CREATE CONSTRAINT report_id_unique IF NOT EXISTS 
FOR (r:MaintenanceReport) REQUIRE r.reportId IS UNIQUE;
```

### 2. Create Existence Constraints (Required Properties)

```cypher
// Core equipment properties
CREATE CONSTRAINT pump_identifier_exists IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.pumpIdentifier IS NOT NULL;

CREATE CONSTRAINT pump_age_exists IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.currentAge IS NOT NULL;

CREATE CONSTRAINT pump_criticality_exists IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.criticalityLevel IS NOT NULL;

CREATE CONSTRAINT pump_role_exists IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.serviceRole IS NOT NULL;

CREATE CONSTRAINT pump_operational_exists IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.isOperational IS NOT NULL;

// Weibull model required parameters
CREATE CONSTRAINT weibull_shape_exists IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) REQUIRE w.weibullShape IS NOT NULL;

CREATE CONSTRAINT weibull_scale_exists IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) REQUIRE w.weibullScale IS NOT NULL;

// RUL assessment required properties
CREATE CONSTRAINT rul_value_exists IF NOT EXISTS 
FOR (r:RemainingUsefulLife) REQUIRE r.remainingUsefulLife IS NOT NULL;

CREATE CONSTRAINT health_index_exists IF NOT EXISTS 
FOR (r:RemainingUsefulLife) REQUIRE r.healthIndex IS NOT NULL;

// Blended hazard required properties
CREATE CONSTRAINT blending_weight_exists IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.blendingWeight IS NOT NULL;

CREATE CONSTRAINT weibull_hazard_exists IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.weibullHazard IS NOT NULL;

CREATE CONSTRAINT condition_hazard_exists IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.conditionHazard IS NOT NULL;

CREATE CONSTRAINT blended_hazard_exists IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.blendedHazard IS NOT NULL;

// Failure prediction required properties
CREATE CONSTRAINT failure_prob_exists IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.failureProbability IS NOT NULL;

CREATE CONSTRAINT risk_classification_exists IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.riskClassification IS NOT NULL;

CREATE CONSTRAINT prediction_timestamp_exists IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.predictionTimestamp IS NOT NULL;
```

### 3. Create Range Constraints (Mathematical Validation)

```cypher
// Mathematical parameter constraints
CREATE CONSTRAINT weibull_shape_positive IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) REQUIRE w.weibullShape > 0;

CREATE CONSTRAINT weibull_scale_positive IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) REQUIRE w.weibullScale > 0;

CREATE CONSTRAINT parameter_confidence_range IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) REQUIRE w.parameterConfidence >= 0 AND w.parameterConfidence <= 1;

// Health and RUL constraints
CREATE CONSTRAINT rul_non_negative IF NOT EXISTS 
FOR (r:RemainingUsefulLife) REQUIRE r.remainingUsefulLife >= 0;

CREATE CONSTRAINT health_index_range IF NOT EXISTS 
FOR (r:RemainingUsefulLife) REQUIRE r.healthIndex >= 0 AND r.healthIndex <= 1;

CREATE CONSTRAINT data_quality_range IF NOT EXISTS 
FOR (r:RemainingUsefulLife) REQUIRE r.dataQualityScore >= 0 AND r.dataQualityScore <= 1;

// Hazard calculation constraints
CREATE CONSTRAINT blending_weight_range IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.blendingWeight >= 0 AND h.blendingWeight <= 1;

CREATE CONSTRAINT weibull_hazard_non_negative IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.weibullHazard >= 0;

CREATE CONSTRAINT condition_hazard_non_negative IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.conditionHazard >= 0;

CREATE CONSTRAINT blended_hazard_non_negative IF NOT EXISTS 
FOR (h:BlendedHazardFunction) REQUIRE h.blendedHazard >= 0;

// Probability constraints
CREATE CONSTRAINT failure_prob_range IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.failureProbability >= 0 AND p.failureProbability <= 1;

CREATE CONSTRAINT risk_score_range IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.riskScore >= 0 AND p.riskScore <= 1;

CREATE CONSTRAINT confidence_level_range IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) REQUIRE p.confidenceLevel >= 0 AND p.confidenceLevel <= 1;

// Equipment age constraints
CREATE CONSTRAINT pump_age_non_negative IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.currentAge >= 0;

CREATE CONSTRAINT operating_hours_non_negative IF NOT EXISTS 
FOR (p:DryPump) REQUIRE p.operatingHours >= 0;
```

### 4. Create Performance Indexes

```cypher
// Primary lookup indexes
CREATE INDEX pump_identifier_idx IF NOT EXISTS 
FOR (p:DryPump) ON (p.pumpIdentifier);

CREATE INDEX chamber_id_idx IF NOT EXISTS 
FOR (c:ProcessChamber) ON (c.chamberId);

CREATE INDEX tool_id_idx IF NOT EXISTS 
FOR (t:SemiconductorTool) ON (t.toolId);

CREATE INDEX area_id_idx IF NOT EXISTS 
FOR (a:FabArea) ON (a.areaId);

CREATE INDEX fab_id_idx IF NOT EXISTS 
FOR (f:Fab) ON (f.fabId);

// Temporal indexes for time-series queries
CREATE INDEX prediction_timestamp_idx IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) ON (p.predictionTimestamp);

CREATE INDEX telemetry_update_idx IF NOT EXISTS 
FOR (r:RemainingUsefulLife) ON (r.lastTelemetryUpdate);

CREATE INDEX model_fit_date_idx IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) ON (w.modelFitDate);

CREATE INDEX hazard_calculation_timestamp_idx IF NOT EXISTS 
FOR (h:BlendedHazardFunction) ON (h.calculationTimestamp);

CREATE INDEX report_generation_time_idx IF NOT EXISTS 
FOR (r:MaintenanceReport) ON (r.reportGenerationTime);

// Risk assessment indexes
CREATE INDEX risk_classification_idx IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) ON (p.riskClassification);

CREATE INDEX failure_probability_idx IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) ON (p.failureProbability);

CREATE INDEX criticality_level_idx IF NOT EXISTS 
FOR (p:DryPump) ON (p.criticalityLevel);

CREATE INDEX service_role_idx IF NOT EXISTS 
FOR (p:DryPump) ON (p.serviceRole);

CREATE INDEX operational_status_idx IF NOT EXISTS 
FOR (p:DryPump) ON (p.isOperational);

// Mathematical model indexes
CREATE INDEX weibull_shape_idx IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) ON (w.weibullShape);

CREATE INDEX weibull_scale_idx IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) ON (w.weibullScale);

CREATE INDEX remaining_useful_life_idx IF NOT EXISTS 
FOR (r:RemainingUsefulLife) ON (r.remainingUsefulLife);

CREATE INDEX health_index_idx IF NOT EXISTS 
FOR (r:RemainingUsefulLife) ON (r.healthIndex);

// Process integration indexes
CREATE INDEX process_type_idx IF NOT EXISTS 
FOR (p:SemiconductorProcess) ON (p.processType);

CREATE INDEX tool_type_idx IF NOT EXISTS 
FOR (t:SemiconductorTool) ON (t.toolType);

CREATE INDEX tool_state_idx IF NOT EXISTS 
FOR (t:SemiconductorTool) ON (t.toolState);
```

### 5. Create Composite Indexes for Complex Queries

```cypher
// Time-series and risk combination indexes
CREATE INDEX failure_prob_time_idx IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) ON (p.failureProbability, p.predictionTimestamp);

CREATE INDEX risk_time_idx IF NOT EXISTS 
FOR (p:ThirtyDayFailureProbability) ON (p.riskClassification, p.predictionTimestamp);

// Equipment criticality and risk indexes
CREATE INDEX pump_criticality_risk_idx IF NOT EXISTS 
FOR (p:DryPump) ON (p.criticalityLevel, p.isOperational);

// Mathematical model performance indexes
CREATE INDEX weibull_confidence_idx IF NOT EXISTS 
FOR (w:WeibullSurvivalFunction) ON (w.parameterConfidence, w.modelFitDate);

CREATE INDEX rul_quality_idx IF NOT EXISTS 
FOR (r:RemainingUsefulLife) ON (r.dataQualityScore, r.lastTelemetryUpdate);
```

## Sample Data Creation (Development/Testing)

### Create Sample Equipment Hierarchy

```cypher
// Create sample fab and area
CREATE (fab1:Fab {
  fabId: "FAB1",
  fabLocation: "Austin, TX",
  fabCapacity: 50000
});

CREATE (dryEtchArea:FabArea {
  areaId: "DRY_ETCH",
  areaType: "DryProcessArea",
  cleanClass: "ISO5"
});

// Create sample tool
CREATE (etchTool:SemiconductorTool {
  toolId: "ETCH_02",
  toolType: "Etch",
  toolModel: "Applied Materials Centura",
  toolState: "PRODUCTIVE"
});

// Create sample chamber
CREATE (chamber1:ProcessChamber {
  chamberId: "CH1",
  chamberType: "Process",
  processEnvironment: "Vacuum",
  operatingPressure: 1e-6
});

// Create sample pump
CREATE (pump001:DryPump {
  pumpIdentifier: "P001",
  pumpModel: "Edwards nXDS20i",
  manufacturer: "Edwards Vacuum",
  currentAge: 400,
  criticalityLevel: "Level4",
  serviceRole: "Primary",
  isOperational: true,
  operatingHours: 9600.5,
  installationDate: datetime("2024-04-15T08:00:00Z")
});

// Create equipment hierarchy relationships
CREATE (fab1)-[:CONTAINS]->(dryEtchArea);
CREATE (dryEtchArea)<-[:LOCATED_IN]-(etchTool);
CREATE (etchTool)<-[:PART_OF]-(chamber1);
CREATE (pump001)-[:SERVES {
  serviceStartDate: datetime("2024-04-15T08:00:00Z"),
  isPrimary: true
}]->(chamber1);
```

### Create Sample Mathematical Models

```cypher
// Create Weibull survival model
CREATE (weibullModel:WeibullSurvivalFunction {
  modelId: "WEIBULL_P001_v1.2",
  weibullShape: 1.42,
  weibullScale: 527.44,
  weibullLocation: 0.0,
  parameterConfidence: 0.85,
  modelFitDate: datetime("2025-01-15T00:00:00Z")
});

// Create RUL assessment
CREATE (rulAssessment:RemainingUsefulLife {
  rulId: "RUL_P001_20250721",
  remainingUsefulLife: 180,
  healthIndex: 0.15,
  dataQualityScore: 0.92,
  lastTelemetryUpdate: datetime("2025-07-21T09:45:00Z"),
  assessmentMethod: "TelemetryBased"
});

// Create blended hazard calculation
CREATE (hazardCalc:BlendedHazardFunction {
  hazardId: "HAZARD_P001_20250721",
  blendingWeight: 0.3,
  weibullHazard: 0.045,
  conditionHazard: 0.167,
  blendedHazard: 0.095,
  calculationTimestamp: datetime("2025-07-21T10:30:00Z")
});

// Create failure probability prediction
CREATE (failurePred:ThirtyDayFailureProbability {
  predictionId: "PRED_P001_20250721",
  failureProbability: 0.091,
  riskClassification: "E",
  riskScore: 0.091,
  predictionTimestamp: datetime("2025-07-21T10:30:00Z"),
  confidenceLevel: 0.78,
  calculationMethod: "BlendedHazard_v1.2"
});

// Create mathematical relationships
CREATE (pump001)-[:HAS_SURVIVAL_MODEL {
  modelVersion: "v1.2",
  isActive: true
}]->(weibullModel);

CREATE (pump001)-[:HAS_RUL_ASSESSMENT {
  assessmentTimestamp: datetime("2025-07-21T09:45:00Z")
}]->(rulAssessment);

CREATE (pump001)-[:HAS_HAZARD_CALCULATION]->(hazardCalc);

CREATE (pump001)-[:HAS_FAILURE_PREDICTION {
  calculationDuration: 0.045
}]->(failurePred);

CREATE (hazardCalc)-[:CALCULATED_FROM_SURVIVAL]->(weibullModel);
CREATE (hazardCalc)-[:CALCULATED_FROM_RUL]->(rulAssessment);
CREATE (hazardCalc)-[:GENERATES_PREDICTION]->(failurePred);
```

### Create Sample Process Integration

```cypher
// Create semiconductor process
CREATE (oxideEtchProcess:SemiconductorProcess {
  processId: "OXIDE_ETCH",
  processType: "EtchProcess",
  processName: "Silicon Oxide Etch",
  criticalityLevel: "High"
});

// Create process recipe
CREATE (oxideEtchRecipe:ProcessRecipe {
  recipeId: "OXIDE_ETCH_V2.1",
  recipeName: "Oxide Etch Standard",
  recipeVersion: "v2.1",
  vacuumRequirement: 5e-6
});

// Create process relationships
CREATE (chamber1)-[:EXECUTES]->(oxideEtchRecipe);
CREATE (oxideEtchRecipe)-[:PART_OF_PROCESS]->(oxideEtchProcess);
CREATE (pump001)-[:CRITICAL_FOR {
  impactLevel: "High"
}]->(oxideEtchProcess);
```

### Create Sample Maintenance Report

```cypher
// Create maintenance report
CREATE (report001:MaintenanceReport {
  reportId: "RPT_20250721_001",
  reportGenerationTime: datetime("2025-07-21T11:00:00Z"),
  calculationVersion: "v1.2.1",
  reportType: "Daily",
  totalPumpsAssessed: 1
});

// Link report to pump and prediction
CREATE (report001)-[:INCLUDES_PUMP]->(pump001);
CREATE (report001)-[:INCLUDES_PREDICTION]->(failurePred);
```

## Data Validation Queries

### Mathematical Consistency Checks

```cypher
// Verify blended hazard calculation
MATCH (h:BlendedHazardFunction)
WHERE abs(h.blendedHazard - (h.weibullHazard + h.blendingWeight * h.conditionHazard)) > 0.001
RETURN h.hazardId, 
       h.blendedHazard as actual,
       (h.weibullHazard + h.blendingWeight * h.conditionHazard) as expected,
       abs(h.blendedHazard - (h.weibullHazard + h.blendingWeight * h.conditionHazard)) as error;
```

```cypher
// Verify risk classification consistency
MATCH (pred:ThirtyDayFailureProbability)
WHERE (pred.riskClassification = 'A' AND pred.failureProbability < 0.8) OR
      (pred.riskClassification = 'B' AND (pred.failureProbability < 0.6 OR pred.failureProbability >= 0.8)) OR
      (pred.riskClassification = 'C' AND (pred.failureProbability < 0.3 OR pred.failureProbability >= 0.6)) OR
      (pred.riskClassification = 'D' AND (pred.failureProbability < 0.1 OR pred.failureProbability >= 0.3)) OR
      (pred.riskClassification = 'E' AND pred.failureProbability >= 0.1)
RETURN pred.predictionId, pred.riskClassification, pred.failureProbability
ORDER BY pred.failureProbability DESC;
```

### Data Completeness Checks

```cypher
// Check for pumps missing survival models
MATCH (p:DryPump)
WHERE NOT EXISTS {
  (p)-[:HAS_SURVIVAL_MODEL]->(:WeibullSurvivalFunction)
}
RETURN p.pumpIdentifier, "Missing survival model" as issue;
```

```cypher
// Check for pumps missing RUL assessments
MATCH (p:DryPump)
WHERE NOT EXISTS {
  (p)-[:HAS_RUL_ASSESSMENT]->(:RemainingUsefulLife)
}
RETURN p.pumpIdentifier, "Missing RUL assessment" as issue;
```

```cypher
// Check for pumps missing failure predictions
MATCH (p:DryPump)
WHERE NOT EXISTS {
  (p)-[:HAS_FAILURE_PREDICTION]->(:ThirtyDayFailureProbability)
}
RETURN p.pumpIdentifier, "Missing failure prediction" as issue;
```

### Relationship Integrity Checks

```cypher
// Check for orphaned mathematical calculations
MATCH (h:BlendedHazardFunction)
WHERE NOT EXISTS {
  (h)<-[:HAS_HAZARD_CALCULATION]-(:DryPump)
}
RETURN h.hazardId, "Orphaned hazard calculation" as issue;
```

```cypher
// Check for incomplete calculation chains
MATCH (p:DryPump)-[:HAS_HAZARD_CALCULATION]->(h:BlendedHazardFunction)
WHERE NOT EXISTS {
  (h)-[:CALCULATED_FROM_SURVIVAL]->(:WeibullSurvivalFunction)
} OR NOT EXISTS {
  (h)-[:CALCULATED_FROM_RUL]->(:RemainingUsefulLife)
} OR NOT EXISTS {
  (h)-[:GENERATES_PREDICTION]->(:ThirtyDayFailureProbability)
}
RETURN p.pumpIdentifier, h.hazardId, "Incomplete calculation chain" as issue;
```

## Performance Monitoring Queries

### Database Statistics

```cypher
// Count entities by type
CALL apoc.meta.stats() YIELD labels
RETURN labels;
```

```cypher
// Relationship type distribution
CALL apoc.meta.stats() YIELD relTypesCount
RETURN relTypesCount;
```

### Query Performance Analysis

```cypher
// Most recent predictions per pump
PROFILE
MATCH (p:DryPump)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
WITH p, pred
ORDER BY pred.predictionTimestamp DESC
WITH p, collect(pred)[0] as latestPrediction
RETURN p.pumpIdentifier, latestPrediction.failureProbability, latestPrediction.predictionTimestamp;
```

```cypher
// High-risk pump identification
PROFILE
MATCH (p:DryPump)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
WHERE pred.riskClassification IN ['A', 'B']
  AND pred.predictionTimestamp >= datetime() - duration('PT24H')
RETURN p.pumpIdentifier, pred.failureProbability, pred.riskClassification;
```

## Backup and Maintenance

### Export Schema for Backup

```cypher
// Export all constraints
SHOW CONSTRAINTS;
```

```cypher
// Export all indexes
SHOW INDEXES;
```

### Regular Maintenance Tasks

```cypher
// Clean up old predictions (keep last 90 days)
MATCH (pred:ThirtyDayFailureProbability)
WHERE pred.predictionTimestamp < datetime() - duration('P90D')
DELETE pred;
```

```cypher
// Clean up old RUL assessments (keep last 30 days)
MATCH (rul:RemainingUsefulLife)
WHERE rul.lastTelemetryUpdate < datetime() - duration('P30D')
  AND NOT EXISTS {
    (rul)<-[:CALCULATED_FROM_RUL]-(:BlendedHazardFunction)
  }
DELETE rul;
```

---

## Deployment Checklist

### Pre-Deployment
- [ ] Neo4j 5.x installed and running
- [ ] APOC plugin installed (for metadata functions)
- [ ] Database memory configured appropriately
- [ ] Backup strategy in place

### Schema Deployment
- [ ] Execute unique constraints (Section 1)
- [ ] Execute existence constraints (Section 2)  
- [ ] Execute range constraints (Section 3)
- [ ] Execute performance indexes (Section 4)
- [ ] Execute composite indexes (Section 5)
- [ ] Verify all constraints with `SHOW CONSTRAINTS`
- [ ] Verify all indexes with `SHOW INDEXES`

### Data Loading
- [ ] Create sample data (optional, for testing)
- [ ] Validate data integrity with validation queries
- [ ] Run performance monitoring queries
- [ ] Establish data loading pipelines for production data

### Post-Deployment
- [ ] Configure regular maintenance tasks
- [ ] Set up monitoring and alerting
- [ ] Document operational procedures
- [ ] Train team on query patterns

---

**Schema Version**: v1.0
**Deployment Date**: July 21, 2025
**Status**: Production Ready
**Next Review**: Step 7 Instance Creation
