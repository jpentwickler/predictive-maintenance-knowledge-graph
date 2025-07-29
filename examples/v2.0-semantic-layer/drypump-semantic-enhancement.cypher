// DryPump Semantic Layer Enhancement - v2.0
// 
// This script creates a comprehensive semantic layer for DryPump entities
// in the predictive maintenance knowledge graph.
//
// Purpose: v2.0 Semantic Enhancement for DryPump Equipment Pilot
// Prerequisites: v1.0 core implementation must be complete
// Implementation Date: July 29, 2025
// Status: Production Ready

// ================================================================================
// SEMANTIC LAYER FOUNDATION
// ================================================================================

// Create constraints for semantic layer node types
CREATE CONSTRAINT semantic_concept_id_unique IF NOT EXISTS 
FOR (sc:SemanticConcept) REQUIRE sc.conceptId IS UNIQUE;

CREATE CONSTRAINT ontology_term_uri_unique IF NOT EXISTS 
FOR (ot:OntologyTerm) REQUIRE ot.uri IS UNIQUE;

CREATE CONSTRAINT semantic_context_id_unique IF NOT EXISTS 
FOR (sc:SemanticContext) REQUIRE sc.contextId IS UNIQUE;

// Create required property constraints
CREATE CONSTRAINT semantic_concept_label_exists IF NOT EXISTS 
FOR (sc:SemanticConcept) REQUIRE sc.label IS NOT NULL;

// Create performance indexes for semantic layer
CREATE INDEX semantic_concept_category_idx IF NOT EXISTS 
FOR (sc:SemanticConcept) ON (sc.semanticCategory);

CREATE INDEX semantic_concept_domain_idx IF NOT EXISTS 
FOR (sc:SemanticConcept) ON (sc.domain);

CREATE INDEX ontology_source_idx IF NOT EXISTS 
FOR (ot:OntologyTerm) ON (ot.ontologySource);

// ================================================================================
// SEMANTIC CONCEPT CREATION
// ================================================================================

// Create Equipment Type Classification Concept
CREATE (vacuumPumpConcept:SemanticConcept {
  conceptId: "VacuumPump_Concept",
  label: "Vacuum Pump Equipment",
  definition: "Mechanical device that removes gas molecules from enclosed spaces to create partial vacuum conditions required for manufacturing processes",
  semanticCategory: "EquipmentTypeClassification",
  domain: "Manufacturing Equipment",
  isProprietaryInnovation: false
});

// Create Business Function Classification Concept
CREATE (processEnablerConcept:SemanticConcept {
  conceptId: "ProcessEnabler_Concept", 
  label: "Process Enabling Equipment",
  definition: "Critical equipment whose operational state directly determines manufacturing process capability and whose failure immediately prevents process execution",
  semanticCategory: "BusinessFunctionClassification",
  domain: "Manufacturing Operations",
  isProprietaryInnovation: false
});

// Create Maintenance Strategy Classification Concept
CREATE (conditionBasedConcept:SemanticConcept {
  conceptId: "ConditionBasedMaintenance_Concept",
  label: "Condition-Based Predictive Maintenance",
  definition: "Advanced maintenance strategy that performs maintenance actions based on real-time equipment condition monitoring and predictive analytics rather than fixed time schedules",
  semanticCategory: "MaintenanceStrategyClassification",
  domain: "Maintenance Management",
  isProprietaryInnovation: false
});

// ================================================================================
// ONTOLOGY TERMS CREATION (INDUSTRY STANDARDS INTEGRATION)
// ================================================================================

// MIMOSA OSA-EAI Equipment Module Integration
CREATE (mimosaEquipment:OntologyTerm:MIMOSA {
  uri: "http://data.mimosa.org/osa-eai#EquipmentModule",
  ontologySource: "MIMOSA_OSA_EAI",
  standardVersion: "3.3.1",
  termLabel: "Equipment Module",
  formalDefinition: "Physical asset that performs specific manufacturing functions within enterprise operations and can be monitored for condition and performance"
});

// W3C SOSA Sensor System Integration
CREATE (sosaSensor:OntologyTerm:SOSA {
  uri: "http://www.w3.org/ns/sosa/System", 
  ontologySource: "W3C_SOSA",
  standardVersion: "2017",
  termLabel: "System",
  formalDefinition: "System composed of sensors, actuators, samplers, and other systems that can be deployed to implement procedures and produce data"
});

// ISA-95 Equipment Module Integration
CREATE (isa95Equipment:OntologyTerm:ISA95 {
  uri: "http://www.mesa.org/xml/B2MML#EquipmentModule",
  ontologySource: "ISA_95",
  standardVersion: "2013",
  termLabel: "Equipment Module", 
  formalDefinition: "Discrete equipment element within manufacturing operations hierarchy that performs specific manufacturing functions"
});

// ISA-95 Equipment Resource Integration
CREATE (isa95Resource:OntologyTerm:ISA95 {
  uri: "http://www.mesa.org/xml/B2MML#EquipmentResource",
  ontologySource: "ISA_95", 
  standardVersion: "2013",
  termLabel: "Equipment Resource",
  formalDefinition: "Manufacturing resource that provides equipment capabilities required for production operations"
});

// ================================================================================
// SEMANTIC CONTEXT CREATION
// ================================================================================

// Semiconductor Manufacturing Domain Context
CREATE (semiconductorContext:SemanticContext {
  contextId: "SemiconductorManufacturing_Context",
  industry: "Semiconductor",
  processDomain: "Wafer_Fabrication_CVD",
  regulatoryFramework: "SEMI_Standards_E10_E58",
  businessContext: "High-value precision manufacturing with zero-defect quality requirements and committed customer delivery schedules"
});

// ================================================================================
// ENTITY-TO-SEMANTIC RELATIONSHIPS
// ================================================================================

// Link DryPump to Equipment Type Concept
MATCH (pump:DryPump {pumpIdentifier: "P002"}),
      (vacuumPumpConcept:SemanticConcept {conceptId: "VacuumPump_Concept"})
CREATE (pump)-[:HAS_SEMANTIC_TYPE {
  semanticRelevance: "Primary equipment type classification per industry standards",
  confidenceLevel: 0.95,
  assignmentReasoning: "Direct classification as vacuum generation equipment"
}]->(vacuumPumpConcept);

// Link DryPump to Business Function Concept
MATCH (pump:DryPump {pumpIdentifier: "P002"}),
      (processEnablerConcept:SemanticConcept {conceptId: "ProcessEnabler_Concept"})
CREATE (pump)-[:HAS_SEMANTIC_TYPE {
  semanticRelevance: "Critical business function role in manufacturing operations",
  confidenceLevel: 0.90,
  assignmentReasoning: "Level5 criticality pump essential for CVD process execution"
}]->(processEnablerConcept);

// Link DryPump to Maintenance Strategy Concept
MATCH (pump:DryPump {pumpIdentifier: "P002"}),
      (conditionBasedConcept:SemanticConcept {conceptId: "ConditionBasedMaintenance_Concept"})
CREATE (pump)-[:HAS_SEMANTIC_TYPE {
  semanticRelevance: "Maintenance strategy implementation approach",
  confidenceLevel: 0.88,
  assignmentReasoning: "Uses BlendedHazardFunction and ThirtyDayFailureProbability for predictive maintenance"
}]->(conditionBasedConcept);

// ================================================================================
// STANDARDS ALIGNMENT RELATIONSHIPS
// ================================================================================

// Equipment Type Concept → MIMOSA Alignment
MATCH (vacuumPumpConcept:SemanticConcept {conceptId: "VacuumPump_Concept"}),
      (mimosaEquipment:OntologyTerm:MIMOSA)
CREATE (vacuumPumpConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Strong",
  mappingJustification: "Direct equipment classification mapping per MIMOSA OSA-EAI standard for manufacturing equipment modules",
  standardCompliance: "Full_Compliance"
}]->(mimosaEquipment);

// Equipment Type Concept → SOSA Alignment
MATCH (vacuumPumpConcept:SemanticConcept {conceptId: "VacuumPump_Concept"}),
      (sosaSensor:OntologyTerm:SOSA)
CREATE (vacuumPumpConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Strong", 
  mappingJustification: "Vacuum pump system with integrated sensors for condition monitoring per W3C SOSA ontology",
  standardCompliance: "Sensor_System_Compliance"
}]->(sosaSensor);

// Equipment Type Concept → ISA-95 Equipment Module Alignment
MATCH (vacuumPumpConcept:SemanticConcept {conceptId: "VacuumPump_Concept"}),
      (isa95Equipment:OntologyTerm:ISA95)
WHERE isa95Equipment.termLabel = "Equipment Module"
CREATE (vacuumPumpConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Strong",
  mappingJustification: "Manufacturing equipment hierarchy compliance per ISA-95 standard for discrete equipment modules",
  standardCompliance: "Level_2_Equipment_Module"
}]->(isa95Equipment);

// Equipment Type Concept → ISA-95 Resource Alignment
MATCH (vacuumPumpConcept:SemanticConcept {conceptId: "VacuumPump_Concept"}),
      (isa95Resource:OntologyTerm:ISA95)
WHERE isa95Resource.termLabel = "Equipment Resource"
CREATE (vacuumPumpConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Medium",
  mappingJustification: "Equipment resource providing vacuum generation capability for manufacturing operations",
  standardCompliance: "Resource_Definition_Compliance"
}]->(isa95Resource);

// Business Function Concept → MIMOSA Alignment
MATCH (processEnablerConcept:SemanticConcept {conceptId: "ProcessEnabler_Concept"}),
      (mimosaEquipment:OntologyTerm:MIMOSA)
CREATE (processEnablerConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Medium",
  mappingJustification: "Process-critical equipment function aligns with MIMOSA equipment module operational role",
  standardCompliance: "Functional_Role_Compliance"
}]->(mimosaEquipment);

// Business Function Concept → ISA-95 Alignment
MATCH (processEnablerConcept:SemanticConcept {conceptId: "ProcessEnabler_Concept"}),
      (isa95Equipment:OntologyTerm:ISA95)
WHERE isa95Equipment.termLabel = "Equipment Module"
CREATE (processEnablerConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Strong",
  mappingJustification: "Critical manufacturing function directly maps to ISA-95 equipment module process enabling role",
  standardCompliance: "Process_Function_Compliance"
}]->(isa95Equipment);

// Maintenance Strategy Concept → MIMOSA Alignment
MATCH (conditionBasedConcept:SemanticConcept {conceptId: "ConditionBasedMaintenance_Concept"}),
      (mimosaEquipment:OntologyTerm:MIMOSA)
CREATE (conditionBasedConcept)-[:ALIGNED_WITH {
  alignmentStrength: "Medium",
  mappingJustification: "Condition-based maintenance strategy aligns with MIMOSA asset management and monitoring capabilities",
  standardCompliance: "Asset_Management_Compliance"
}]->(mimosaEquipment);

// ================================================================================
// CONTEXTUAL SEMANTIC RELATIONSHIPS
// ================================================================================

// Equipment Type → Semiconductor Context
MATCH (vacuumPumpConcept:SemanticConcept {conceptId: "VacuumPump_Concept"}),
      (semiconductorContext:SemanticContext {contextId: "SemiconductorManufacturing_Context"})
CREATE (vacuumPumpConcept)-[:HAS_MEANING_IN_CONTEXT {
  contextualInterpretation: "Critical vacuum generation equipment enabling ultra-high vacuum conditions (1e-10 Torr) required for contamination-free wafer processing in CVD chambers",
  businessImplication: "Equipment failure causes immediate process shutdown with $50K-$200K production impact per incident plus potential wafer scrapping costs",
  domainSpecificRole: "Primary vacuum source for process chamber maintaining sub-1e-7 Torr base pressure"
}]->(semiconductorContext);

// Business Function → Semiconductor Context
MATCH (processEnablerConcept:SemanticConcept {conceptId: "ProcessEnabler_Concept"}),
      (semiconductorContext:SemanticContext {contextId: "SemiconductorManufacturing_Context"})
CREATE (processEnablerConcept)-[:HAS_MEANING_IN_CONTEXT {
  contextualInterpretation: "Process-critical equipment whose failure immediately prevents CVD silicon nitride deposition for 7nm technology node manufacturing",
  businessImplication: "Unscheduled downtime disrupts committed customer deliveries and negatively impacts fab OEE metrics with potential customer penalties",
  domainSpecificRole: "Essential infrastructure for high-volume semiconductor manufacturing operations"
}]->(semiconductorContext);

// Maintenance Strategy → Semiconductor Context
MATCH (conditionBasedConcept:SemanticConcept {conceptId: "ConditionBasedMaintenance_Concept"}),
      (semiconductorContext:SemanticContext {contextId: "SemiconductorManufacturing_Context"})
CREATE (conditionBasedConcept)-[:HAS_MEANING_IN_CONTEXT {
  contextualInterpretation: "Advanced predictive maintenance using BlendedHazardFunction methodology to prevent unscheduled downtime in high-cost semiconductor manufacturing environment",
  businessImplication: "Proactive maintenance prevents process interruptions that could cause multi-million dollar production losses and customer delivery delays",
  domainSpecificRole: "Enables just-in-time maintenance scheduling optimized for semiconductor fab operational constraints"
}]->(semiconductorContext);

// ================================================================================
// IMPLEMENTATION VERIFICATION
// ================================================================================

// Verify semantic coverage for P002
MATCH (pump:DryPump {pumpIdentifier: "P002"})-[:HAS_SEMANTIC_TYPE]->(concept:SemanticConcept)
RETURN pump.pumpIdentifier, count(concept) as SemanticConceptsLinked,
       collect(concept.semanticCategory) as CategoriesCovered;

// Verify standards compliance
MATCH (concept:SemanticConcept)-[:ALIGNED_WITH]->(term:OntologyTerm)
RETURN concept.label, count(term) as StandardsMapped,
       collect(term.ontologySource) as StandardsAligned;

// Test enhanced AI agent business impact query
MATCH (pump:DryPump {pumpIdentifier: "P002"})-[:HAS_SEMANTIC_TYPE]->(concept:SemanticConcept)
      -[context_rel:HAS_MEANING_IN_CONTEXT]->(context:SemanticContext)
WHERE context.industry = "Semiconductor"
RETURN pump.pumpIdentifier, pump.criticalityLevel, concept.label,
       context_rel.businessImplication as BusinessImpact;

// Verify core v1.0 operations unchanged
MATCH (pump:DryPump {pumpIdentifier: "P002"})-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
RETURN pump.criticalityLevel, pred.failureProbability, pred.riskClassification, pred.confidenceLevel;