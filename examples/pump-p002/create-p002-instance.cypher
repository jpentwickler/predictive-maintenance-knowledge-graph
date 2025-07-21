// Pump P002 Knowledge Graph Instance Creation
// 
// This script creates a complete example instance demonstrating all entities and relationships
// in the predictive maintenance knowledge graph for vacuum dry pump P002.
//
// Purpose: Step 7 of Ontology Development Process - Create Instances
// Model Version: v1.0
// Date: July 21, 2025

// ================================================================================
// EQUIPMENT HIERARCHY CREATION
// ================================================================================

// Create Fab (Fabrication Facility)
CREATE (fab2:Fab {
  fabId: "FAB2",
  fabLocation: "Dresden, Germany",
  fabCapacity: 75000,
  operationalStatus: "ACTIVE",
  startupDate: datetime("2023-01-15T00:00:00Z")
});

// Create FabArea (Cleanroom Area)
CREATE (cvdArea:FabArea {
  areaId: "CVD_DEPOSITION",
  areaType: "WetProcessArea", 
  cleanClass: "ISO4",
  temperature: 22.5,
  humidity: 45.2,
  particleCount: 850
});

// Create SemiconductorTool (Manufacturing Equipment)
CREATE (pecvdTool:SemiconductorTool {
  toolId: "PECVD_05",
  toolType: "Deposition",
  toolModel: "Applied Materials Producer GT",
  toolState: "PRODUCTIVE",
  manufacturer: "Applied Materials",
  installationDate: datetime("2023-08-20T10:00:00Z"),
  utilization: 0.87,
  toolCapacity: 150,
  lastPMDate: datetime("2025-07-15T14:30:00Z")
});

// Create ProcessChamber (Process Environment)
CREATE (chamber2:ProcessChamber {
  chamberId: "CH2",
  chamberType: "Process",
  processEnvironment: "Vacuum",
  operatingPressure: 2e-7,
  chamberVolume: 85.5,
  targetTemperature: 350.0,
  processingState: "READY",
  lastCleanDate: datetime("2025-07-18T08:00:00Z")
});

// Create DryPump (Main Entity - P002)
CREATE (pump002:DryPump {
  pumpIdentifier: "P002",
  pumpModel: "Pfeiffer HiPace 700",
  manufacturer: "Pfeiffer Vacuum",
  serialNumber: "PV700-2024-0892",
  currentAge: 285,
  criticalityLevel: "Level5",
  serviceRole: "Primary",
  isOperational: true,
  operatingHours: 6840.25,
  installationDate: datetime("2024-10-12T09:30:00Z"),
  lastMaintenanceDate: datetime("2025-06-25T13:45:00Z"),
  nextScheduledMaintenance: datetime("2025-09-25T09:00:00Z"),
  pumpingSpeed: 670.0,
  ultimateVacuum: 1e-10,
  compressionRatio: 2e9,
  powerConsumption: 1.85,
  operatingTemperatureMin: 15.0,
  operatingTemperatureMax: 80.0,
  inletPressureRating: 1000.0,
  coolingMethod: "Air",
  costCenter: "CC-CVD-001",
  warrantyExpiryDate: datetime("2027-10-12T00:00:00Z")
});

// ================================================================================
// MATHEMATICAL MODELS CREATION
// ================================================================================

// Create WeibullSurvivalFunction (Historical Lifetime Model)
CREATE (weibullModel2:WeibullSurvivalFunction {
  modelId: "WEIBULL_P002_v2.1",
  weibullShape: 1.68,
  weibullScale: 612.35,
  weibullLocation: 0.0,
  parameterConfidence: 0.91,
  modelFitDate: datetime("2025-02-20T00:00:00Z"),
  modelVersion: "v2.1",
  fittingMethod: "MaximumLikelihood",
  goodnesOfFit: 0.94,
  populationSize: 247,
  dataPoints: 189,
  censoringRate: 0.23,
  trainingDataStartDate: datetime("2020-01-01T00:00:00Z"),
  trainingDataEndDate: datetime("2025-01-31T23:59:59Z")
});

// Create RemainingUsefulLife (Condition Monitoring Assessment)
CREATE (rulAssessment2:RemainingUsefulLife {
  rulId: "RUL_P002_20250721",
  remainingUsefulLife: 142,
  healthIndex: 0.28,
  dataQualityScore: 0.89,
  lastTelemetryUpdate: datetime("2025-07-21T11:15:00Z"),
  assessmentMethod: "TelemetryBased",
  trendDirection: "Degrading",
  degradationRate: 0.0034,
  predictionHorizon: 180,
  overallDegradation: 0.31,
  anomalyCount: 7,
  vibrationScore: 0.72,
  temperatureScore: 0.85,
  powerConsumptionScore: 0.76,
  vacuumPerformanceScore: 0.68,
  sensorHealthScore: 0.94,
  telemetryFrequency: 300
});

// Create BlendedHazardFunction (Hazard Calculation)
// Formula: BlendedHazard = WeibullHazard + BlendingWeight × ConditionHazard
CREATE (hazardCalc2:BlendedHazardFunction {
  hazardId: "HAZARD_P002_20250721",
  blendingWeight: 0.4,
  weibullHazard: 0.062,
  conditionHazard: 0.211,
  blendedHazard: 0.146,
  calculationTimestamp: datetime("2025-07-21T11:30:00Z"),
  algorithmVersion: "v2.1.3",
  targetDays: 30,
  pumpAge: 285,
  operationalStressMultiplier: 1.12,
  weatheringAdjustment: 0.98,
  calibrationFactor: 1.05,
  calculationDuration: 0.038
});

// Create ThirtyDayFailureProbability (Final Prediction)
// Formula: P_30(t) = 1 - exp(-BlendedHazard)
CREATE (failurePred2:ThirtyDayFailureProbability {
  predictionId: "PRED_P002_20250721",
  failureProbability: 0.136,
  riskClassification: "D",
  riskScore: 0.136,
  predictionTimestamp: datetime("2025-07-21T11:30:00Z"),
  confidenceLevel: 0.83,
  calculationMethod: "BlendedHazard_v2.1.3",
  predictionHorizon: 30,
  uncertaintyBand: 0.025,
  riskThreshold: 0.15,
  alertLevel: "Medium",
  businessImpactScore: 0.78,
  probabilityTrend: "Increasing",
  interventionRequired: false,
  maintenanceRecommendation: "MonitorContinuously",
  nextAssessmentDate: datetime("2025-07-22T11:30:00Z")
});

// ================================================================================
// PROCESS INTEGRATION
// ================================================================================

// Create SemiconductorProcess (Manufacturing Process)
CREATE (cvdProcess:SemiconductorProcess {
  processId: "CVD_SILICON_NITRIDE",
  processType: "CVDProcess",
  processName: "Silicon Nitride Deposition",
  criticalityLevel: "High",
  processFamily: "Dielectric",
  processNode: "7nm",
  processRevision: "Rev_C",
  processOwner: "ProcessEngineering",
  qualificationStatus: "Qualified",
  cycleTime: 45.5,
  throughputTarget: 120,
  yieldImpact: "Critical",
  productionPriority: "High"
});

// Create ProcessRecipe (Specific Recipe)
CREATE (cvdRecipe:ProcessRecipe {
  recipeId: "CVD_SiN_V3.2",
  recipeName: "Silicon Nitride CVD Standard",
  recipeVersion: "v3.2",
  vacuumRequirement: 1e-7
});

// Create MaintenanceReport (AI Agent Output)
CREATE (report002:MaintenanceReport {
  reportId: "RPT_20250721_002",
  reportGenerationTime: datetime("2025-07-21T12:00:00Z"),
  calculationVersion: "v2.1.3",
  reportType: "Daily",
  totalPumpsAssessed: 1
});

// ================================================================================
// EQUIPMENT HIERARCHY RELATIONSHIPS
// ================================================================================

// Link Fab → FabArea
MATCH (fab2:Fab {fabId: "FAB2"})
MATCH (cvdArea:FabArea {areaId: "CVD_DEPOSITION"})
CREATE (fab2)-[:CONTAINS {containmentType: "FabricationArea"}]->(cvdArea);

// Link SemiconductorTool → FabArea  
MATCH (cvdArea:FabArea {areaId: "CVD_DEPOSITION"})
MATCH (pecvdTool:SemiconductorTool {toolId: "PECVD_05"})
CREATE (pecvdTool)-[:LOCATED_IN {locationDate: datetime("2023-08-20T10:00:00Z")}]->(cvdArea);

// Link ProcessChamber → SemiconductorTool
MATCH (pecvdTool:SemiconductorTool {toolId: "PECVD_05"})
MATCH (chamber2:ProcessChamber {chamberId: "CH2"})
CREATE (chamber2)-[:PART_OF {installDate: datetime("2023-08-22T15:30:00Z")}]->(pecvdTool);

// Link DryPump → ProcessChamber
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
MATCH (chamber2:ProcessChamber {chamberId: "CH2"})
CREATE (pump002)-[:SERVES {
  serviceStartDate: datetime("2024-10-12T09:30:00Z"),
  isPrimary: true,
  connectionType: "DirectLine",
  pumpingLine: "MainVacuum"
}]->(chamber2);

// ================================================================================
// MATHEMATICAL MODEL RELATIONSHIPS
// ================================================================================

// Link DryPump → WeibullSurvivalFunction
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
MATCH (weibullModel2:WeibullSurvivalFunction {modelId: "WEIBULL_P002_v2.1"})
CREATE (pump002)-[:HAS_SURVIVAL_MODEL {
  modelVersion: "v2.1",
  isActive: true,
  activationDate: datetime("2025-02-20T00:00:00Z"),
  confidence: 0.91
}]->(weibullModel2);

// Link DryPump → RemainingUsefulLife
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
MATCH (rulAssessment2:RemainingUsefulLife {rulId: "RUL_P002_20250721"})
CREATE (pump002)-[:HAS_RUL_ASSESSMENT {
  assessmentTimestamp: datetime("2025-07-21T11:15:00Z"),
  assessmentConfidence: 0.89,
  triggerType: "Scheduled"
}]->(rulAssessment2);

// Link DryPump → BlendedHazardFunction
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
MATCH (hazardCalc2:BlendedHazardFunction {hazardId: "HAZARD_P002_20250721"})
CREATE (pump002)-[:HAS_HAZARD_CALCULATION {
  calculationId: "CALC_P002_20250721",
  calculationTrigger: "ScheduledAssessment"
}]->(hazardCalc2);

// Link DryPump → ThirtyDayFailureProbability
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
MATCH (failurePred2:ThirtyDayFailureProbability {predictionId: "PRED_P002_20250721"})
CREATE (pump002)-[:HAS_FAILURE_PREDICTION {
  calculationDuration: 0.038,
  predictionAccuracy: 0.83,
  modelUncertainty: 0.025
}]->(failurePred2);

// Link BlendedHazardFunction → WeibullSurvivalFunction
MATCH (hazardCalc2:BlendedHazardFunction {hazardId: "HAZARD_P002_20250721"})
MATCH (weibullModel2:WeibullSurvivalFunction {modelId: "WEIBULL_P002_v2.1"})
CREATE (hazardCalc2)-[:CALCULATED_FROM_SURVIVAL {
  hazardComponent: "WeibullHazard",
  contributionWeight: 0.6
}]->(weibullModel2);

// Link BlendedHazardFunction → RemainingUsefulLife
MATCH (hazardCalc2:BlendedHazardFunction {hazardId: "HAZARD_P002_20250721"})
MATCH (rulAssessment2:RemainingUsefulLife {rulId: "RUL_P002_20250721"})
CREATE (hazardCalc2)-[:CALCULATED_FROM_RUL {
  hazardComponent: "ConditionHazard",
  contributionWeight: 0.4
}]->(rulAssessment2);

// Link BlendedHazardFunction → ThirtyDayFailureProbability
MATCH (hazardCalc2:BlendedHazardFunction {hazardId: "HAZARD_P002_20250721"})
MATCH (failurePred2:ThirtyDayFailureProbability {predictionId: "PRED_P002_20250721"})
CREATE (hazardCalc2)-[:GENERATES_PREDICTION {
  transformationType: "HazardToProbability",
  conversionFormula: "P_30(t) = 1 - exp(-H_30(t))"
}]->(failurePred2);

// ================================================================================
// PROCESS INTEGRATION RELATIONSHIPS
// ================================================================================

// Link ProcessChamber → ProcessRecipe
MATCH (chamber2:ProcessChamber {chamberId: "CH2"})
MATCH (cvdRecipe:ProcessRecipe {recipeId: "CVD_SiN_V3.2"})
CREATE (chamber2)-[:EXECUTES]->(cvdRecipe);

// Link ProcessRecipe → SemiconductorProcess
MATCH (cvdRecipe:ProcessRecipe {recipeId: "CVD_SiN_V3.2"})
MATCH (cvdProcess:SemiconductorProcess {processId: "CVD_SILICON_NITRIDE"})
CREATE (cvdRecipe)-[:PART_OF_PROCESS]->(cvdProcess);

// Link DryPump → SemiconductorProcess (Business Criticality)
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
MATCH (cvdProcess:SemiconductorProcess {processId: "CVD_SILICON_NITRIDE"})
CREATE (pump002)-[:CRITICAL_FOR {
  impactLevel: "High"
}]->(cvdProcess);

// ================================================================================
// REPORTING RELATIONSHIPS
// ================================================================================

// Link MaintenanceReport → DryPump
MATCH (report002:MaintenanceReport {reportId: "RPT_20250721_002"})
MATCH (pump002:DryPump {pumpIdentifier: "P002"})
CREATE (report002)-[:INCLUDES_PUMP]->(pump002);

// Link MaintenanceReport → ThirtyDayFailureProbability
MATCH (report002:MaintenanceReport {reportId: "RPT_20250721_002"})
MATCH (failurePred2:ThirtyDayFailureProbability {predictionId: "PRED_P002_20250721"})
CREATE (report002)-[:INCLUDES_PREDICTION]->(failurePred2);

// ================================================================================
// VERIFICATION QUERY
// ================================================================================

// Verify the complete instance was created successfully
MATCH path = (fab:Fab)-[:CONTAINS]->(area:FabArea)<-[:LOCATED_IN]-(tool:SemiconductorTool)
<-[:PART_OF]-(chamber:ProcessChamber)<-[:SERVES]-(pump:DryPump {pumpIdentifier: "P002"})
MATCH (pump)-[:HAS_SURVIVAL_MODEL]->(weibull:WeibullSurvivalFunction)
MATCH (pump)-[:HAS_RUL_ASSESSMENT]->(rul:RemainingUsefulLife)
MATCH (pump)-[:HAS_HAZARD_CALCULATION]->(hazard:BlendedHazardFunction)
MATCH (pump)-[:HAS_FAILURE_PREDICTION]->(prediction:ThirtyDayFailureProbability)
RETURN 
  pump.pumpIdentifier as PumpID,
  pump.criticalityLevel as Criticality,
  fab.fabId + " → " + area.areaId + " → " + tool.toolId + " → " + chamber.chamberId as EquipmentHierarchy,
  weibull.weibullShape as WeibullShape,
  weibull.weibullScale as WeibullScale,
  rul.remainingUsefulLife as RUL_Days,
  rul.healthIndex as HealthIndex,
  hazard.blendedHazard as BlendedHazard,
  prediction.failureProbability as FailureProbability,
  prediction.riskClassification as RiskClass;
