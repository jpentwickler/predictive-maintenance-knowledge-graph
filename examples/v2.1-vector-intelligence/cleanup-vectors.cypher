// ============================================================================
// Predictive Maintenance Knowledge Graph v2.1 - Vector Layer Cleanup
// ============================================================================
//
// PURPOSE: Safely remove v2.1 vector intelligence enhancements
// SCOPE: Removes ONLY v2.1 additions, preserves v1.0 and v2.0 layers
// VERSION: v2.1.0
// DATE: August 08, 2025
//
// USAGE:
//   neo4j-cypher-shell -f cleanup-vectors.cypher
//
// WHAT THIS SCRIPT DOES:
//   1. Validates current vector layer status
//   2. Removes SemanticVector nodes
//   3. Drops vector indexes
//   4. Removes supporting indexes and constraints
//   5. Validates cleanup success
//   6. Confirms v2.0 layer remains intact
//
// SAFETY: This script ONLY removes v2.1 vector enhancements
//         All v1.0 operational and v2.0 semantic data remains unchanged
// ============================================================================

// ============================================================================
// STEP 1: PRE-CLEANUP VALIDATION
// ============================================================================

// Check current vector layer status
MATCH (sv:SemanticVector)
WITH count(sv) as vector_count, collect(DISTINCT sv.concept_id) as vector_concepts

// Check v2.0 semantic layer status (should remain after cleanup)
MATCH (sc:SemanticConcept)
WITH count(sc) as semantic_count, collect(DISTINCT sc.conceptId) as semantic_concepts,
     vector_count, vector_concepts

// Validation report
RETURN 
  vector_count as vector_nodes_to_remove,
  vector_concepts as vector_concept_ids,
  semantic_count as semantic_nodes_to_preserve,
  semantic_concepts as semantic_concept_ids,
  CASE 
    WHEN vector_count > 0 
    THEN "⚠️  CLEANUP READY: " + toString(vector_count) + " vector nodes will be removed"
    ELSE "ℹ️  NO ACTION: No vector nodes found"
  END as cleanup_status;

// ============================================================================
// STEP 2: REMOVE VECTOR NODES
// ============================================================================

// Remove all SemanticVector nodes
MATCH (sv:SemanticVector)
WITH count(sv) as nodes_to_delete
DELETE sv
RETURN 
  nodes_to_delete as semantic_vector_nodes_deleted,
  "✅ SemanticVector nodes removed" as status;

// ============================================================================
// STEP 3: DROP VECTOR INDEX
// ============================================================================

// Drop the vector index
DROP INDEX semantic_concepts_vector_index IF EXISTS;

// ============================================================================
// STEP 4: REMOVE SUPPORTING INDEXES
// ============================================================================

// Remove v2.1 specific indexes
DROP INDEX semantic_vector_concept_id IF EXISTS;
DROP INDEX semantic_vector_label IF EXISTS; 
DROP INDEX semantic_vector_domain IF EXISTS;
DROP INDEX semantic_vector_source IF EXISTS;

// ============================================================================
// STEP 5: REMOVE CONSTRAINTS
// ============================================================================

// Remove v2.1 specific constraints
DROP CONSTRAINT semantic_vector_concept_id_unique IF EXISTS;
DROP CONSTRAINT semantic_vector_concept_id_not_null IF EXISTS;
DROP CONSTRAINT semantic_vector_text_not_null IF EXISTS;

// ============================================================================
// STEP 6: POST-CLEANUP VALIDATION
// ============================================================================

// Verify vector layer removal
MATCH (sv:SemanticVector)
WITH count(sv) as remaining_vector_nodes

// Verify v2.0 semantic layer preservation
MATCH (sc:SemanticConcept)
WITH count(sc) as preserved_semantic_nodes, remaining_vector_nodes

// Verify v1.0 operational layer preservation  
MATCH (dp:DryPump)
WITH count(dp) as preserved_operational_nodes, preserved_semantic_nodes, remaining_vector_nodes

// Check remaining indexes
CALL db.indexes() YIELD name, type WHERE name CONTAINS 'semantic'
WITH collect(name) as remaining_semantic_indexes, 
     preserved_operational_nodes, preserved_semantic_nodes, remaining_vector_nodes

// Cleanup validation report
RETURN 
  remaining_vector_nodes as vector_nodes_remaining,
  preserved_semantic_nodes as semantic_nodes_preserved,
  preserved_operational_nodes as operational_nodes_preserved,
  remaining_semantic_indexes as semantic_indexes_remaining,
  CASE 
    WHEN remaining_vector_nodes = 0 AND preserved_semantic_nodes >= 3 AND preserved_operational_nodes >= 1
    THEN "✅ SUCCESS: v2.1 vector layer cleaned up, v1.0/v2.0 layers preserved"
    WHEN remaining_vector_nodes > 0
    THEN "❌ ERROR: " + toString(remaining_vector_nodes) + " vector nodes still remain"
    WHEN preserved_semantic_nodes = 0
    THEN "❌ ERROR: v2.0 semantic layer was accidentally removed"
    ELSE "⚠️  WARNING: Unexpected cleanup state"
  END as cleanup_validation;

// ============================================================================
// STEP 7: SYSTEM STATUS AFTER CLEANUP
// ============================================================================

// Show current knowledge graph status
CALL apoc.meta.stats() YIELD nodeCount, relCount, labelCount, propertyKeyCount

RETURN 
  nodeCount as total_nodes,
  relCount as total_relationships, 
  labelCount as node_types,
  propertyKeyCount as properties,
  "🔄 REVERTED: Knowledge graph returned to v2.0 semantic enhanced state" as final_status;

// ============================================================================
// STEP 8: VERIFICATION QUERIES
// ============================================================================

// Verify v2.0 semantic layer still works
MATCH (pump:DryPump)-[:HAS_SEMANTIC_TYPE]->(concept:SemanticConcept)
      -[ctx:HAS_MEANING_IN_CONTEXT]->(context:SemanticContext)
RETURN 
  pump.pumpIdentifier as pump_id,
  concept.label as semantic_concept,
  context.industry as industry_context,
  "✅ v2.0 semantic functionality verified" as verification_status
LIMIT 1;

// Show available node types after cleanup
CALL db.labels() YIELD label
WHERE NOT label = 'SemanticVector'
RETURN collect(label) as available_node_types;

// ============================================================================
// CLEANUP SUMMARY
// ============================================================================

/*
WHAT WAS REMOVED:
✅ All SemanticVector nodes
✅ semantic_concepts_vector_index
✅ Supporting indexes for vector operations
✅ Vector-specific constraints

WHAT WAS PRESERVED:
✅ All v1.0 operational entities (DryPump, WeibullSurvivalFunction, etc.)
✅ All v2.0 semantic entities (SemanticConcept, OntologyTerm, etc.)
✅ All relationships and business logic
✅ All mathematical models and calculations
✅ All semantic enhancement capabilities

SYSTEM STATUS:
- Knowledge graph reverted to v2.0 semantic enhanced state
- All v1.0 and v2.0 functionality fully preserved
- Ready for fresh v2.1 implementation if desired

TO RE-IMPLEMENT v2.1:
1. neo4j-cypher-shell -f create-vector-layer.cypher
2. python semantic-vectorization.py

VERIFICATION:
Run any existing v1.0 or v2.0 queries to confirm functionality preserved
*/