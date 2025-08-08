// ============================================================================
// Predictive Maintenance Knowledge Graph v2.1 - Vector Intelligence Layer
// ============================================================================
// 
// PURPOSE: Create vector embeddings for semantic concepts to enable similarity search
// DEPENDENCIES: v2.0 semantic layer must be implemented first
// VERSION: v2.1.0
// DATE: August 08, 2025
//
// USAGE:
//   neo4j-cypher-shell -f create-vector-layer.cypher
//
// WHAT THIS SCRIPT DOES:
//   1. Validates v2.0 semantic layer prerequisites
//   2. Creates vector nodes with rich embedding text 
//   3. Sets up vector index for similarity search
//   4. Validates implementation success
//   5. Provides usage examples
//
// NOTE: This script creates the vector layer structure but does NOT generate
//       the actual OpenAI embeddings. Use semantic-vectorization.py for 
//       complete implementation with embeddings.
// ============================================================================

// ============================================================================
// STEP 1: PREREQUISITES VALIDATION
// ============================================================================

// Check that v2.0 semantic layer exists
MATCH (sc:SemanticConcept)
WITH count(sc) as concept_count
WHERE concept_count > 0
WITH concept_count

// Validate semantic concepts have required properties
MATCH (sc:SemanticConcept)
WHERE sc.conceptId IS NOT NULL 
  AND sc.label IS NOT NULL 
  AND sc.definition IS NOT NULL
WITH count(sc) as valid_concepts, concept_count

// Check business context exists
MATCH (sc:SemanticConcept)-[:HAS_MEANING_IN_CONTEXT]->(ctx:SemanticContext)
WITH count(DISTINCT sc) as concepts_with_context, valid_concepts, concept_count

// Validation summary
RETURN 
  concept_count as total_semantic_concepts,
  valid_concepts as concepts_with_required_properties,
  concepts_with_context as concepts_with_business_context,
  CASE 
    WHEN concept_count >= 3 AND valid_concepts = concept_count AND concepts_with_context >= 1
    THEN "✅ READY: v2.0 semantic layer validated"
    ELSE "❌ ERROR: v2.0 semantic layer incomplete - run v2.0 enhancement first"
  END as validation_status;

// ============================================================================
// STEP 2: CREATE VECTOR NODE STRUCTURE
// ============================================================================

// Create SemanticVector nodes with rich embedding text
// Note: This creates the structure but embeddings must be added via Python/OpenAI

MATCH (sc:SemanticConcept)
OPTIONAL MATCH (sc)-[ctx:HAS_MEANING_IN_CONTEXT]->(context:SemanticContext)
OPTIONAL MATCH (sc)-[innov:REPRESENTS_INNOVATION_IN]->(innovation:InnovationContext)

// Build rich embedding text
WITH sc, ctx, context, innovation,
     sc.label + ": " + sc.definition + 
     CASE WHEN sc.domain IS NOT NULL 
       THEN " | Domain: " + sc.domain 
       ELSE "" 
     END +
     CASE WHEN ctx.businessImplication IS NOT NULL 
       THEN " | Business Impact: " + ctx.businessImplication 
       ELSE "" 
     END +
     CASE WHEN ctx.contextualInterpretation IS NOT NULL 
       THEN " | Context: " + ctx.contextualInterpretation 
       ELSE "" 
     END +
     CASE WHEN innovation.businessAdvantage IS NOT NULL 
       THEN " | Innovation: " + innovation.businessAdvantage 
       ELSE "" 
     END as embedding_text

// Create SemanticVector nodes
CREATE (sv:SemanticVector {
  concept_id: sc.conceptId,
  label: sc.label,
  domain: coalesce(sc.domain, "Unknown"),
  text: embedding_text,
  source: "semantic_concept",
  created_at: datetime(),
  version: "v2.1.0",
  // Placeholder for embedding - will be populated by Python script
  embedding: null,
  embedding_model: "text-embedding-ada-002",
  embedding_dimensions: 1536
})

RETURN 
  count(sv) as semantic_vector_nodes_created,
  collect(DISTINCT sv.concept_id) as concept_ids_vectorized,
  "✅ SemanticVector nodes created (embeddings pending)" as status;

// ============================================================================
// STEP 3: CREATE VECTOR INDEX
// ============================================================================

// Create vector index for similarity search
// Note: This will be activated once embeddings are populated

CREATE VECTOR INDEX semantic_concepts_vector_index IF NOT EXISTS
FOR (sv:SemanticVector) ON (sv.embedding)
OPTIONS {
  indexConfig: {
    `vector.dimensions`: 1536,
    `vector.similarity_function`: 'cosine'
  }
};

// ============================================================================
// STEP 4: CREATE SUPPORTING INDEXES
// ============================================================================

// Performance indexes for vector operations
CREATE INDEX semantic_vector_concept_id IF NOT EXISTS FOR (sv:SemanticVector) ON (sv.concept_id);
CREATE INDEX semantic_vector_label IF NOT EXISTS FOR (sv:SemanticVector) ON (sv.label);
CREATE INDEX semantic_vector_domain IF NOT EXISTS FOR (sv:SemanticVector) ON (sv.domain);
CREATE INDEX semantic_vector_source IF NOT EXISTS FOR (sv:SemanticVector) ON (sv.source);

// ============================================================================
// STEP 5: CREATE CONSTRAINTS
// ============================================================================

// Ensure data quality for vector nodes
CREATE CONSTRAINT semantic_vector_concept_id_unique IF NOT EXISTS FOR (sv:SemanticVector) REQUIRE sv.concept_id IS UNIQUE;
CREATE CONSTRAINT semantic_vector_concept_id_not_null IF NOT EXISTS FOR (sv:SemanticVector) REQUIRE sv.concept_id IS NOT NULL;
CREATE CONSTRAINT semantic_vector_text_not_null IF NOT EXISTS FOR (sv:SemanticVector) REQUIRE sv.text IS NOT NULL;

// ============================================================================
// STEP 6: IMPLEMENTATION VALIDATION
// ============================================================================

// Verify vector layer creation
MATCH (sv:SemanticVector)
WITH count(sv) as vector_count, 
     count(CASE WHEN sv.text IS NOT NULL THEN 1 END) as vectors_with_text,
     count(CASE WHEN sv.embedding IS NOT NULL THEN 1 END) as vectors_with_embeddings

// Check index creation
CALL db.indexes() YIELD name, type, state
WHERE name = 'semantic_concepts_vector_index'
WITH count(*) as vector_index_count, vector_count, vectors_with_text, vectors_with_embeddings

// Validation report
RETURN 
  vector_count as semantic_vector_nodes,
  vectors_with_text as nodes_with_embedding_text, 
  vectors_with_embeddings as nodes_with_embeddings,
  vector_index_count as vector_indexes_created,
  CASE 
    WHEN vector_count >= 3 AND vectors_with_text = vector_count AND vector_index_count = 1
    THEN "✅ SUCCESS: Vector layer structure created"
    ELSE "❌ ERROR: Vector layer creation incomplete"
  END as implementation_status,
  CASE
    WHEN vectors_with_embeddings = 0
    THEN "⚠️  NEXT: Run semantic-vectorization.py to generate embeddings"
    ELSE "✅ COMPLETE: Embeddings generated"
  END as next_steps;

// ============================================================================
// STEP 7: SAMPLE VECTOR NODES INSPECTION
// ============================================================================

// Show created vector nodes with their rich text content
MATCH (sv:SemanticVector)
RETURN 
  sv.concept_id as concept_id,
  sv.label as concept_label,
  sv.domain as domain,
  substring(sv.text, 0, 100) + "..." as embedding_text_preview,
  sv.created_at as created_timestamp,
  CASE WHEN sv.embedding IS NOT NULL 
    THEN "✅ Embedded" 
    ELSE "⏳ Pending" 
  END as embedding_status
ORDER BY sv.concept_id;

// ============================================================================
// USAGE EXAMPLES (FOR REFERENCE)
// ============================================================================

// Example 1: Find vector nodes by concept
// MATCH (sv:SemanticVector {concept_id: "VacuumPump_Concept"})
// RETURN sv.label, sv.text;

// Example 2: Check vector index status  
// SHOW VECTOR INDEXES YIELD name, state WHERE name = 'semantic_concepts_vector_index';

// Example 3: Future hybrid traversal pattern (after embeddings generated)
// MATCH (sv:SemanticVector)
// WHERE sv.embedding IS NOT NULL
// MATCH (sc:SemanticConcept {conceptId: sv.concept_id})
// OPTIONAL MATCH (sc)<-[:HAS_SEMANTIC_TYPE]-(entity)
// RETURN sv.concept_id, sc.label, entity.pumpIdentifier;

// ============================================================================
// IMPLEMENTATION NOTES
// ============================================================================

/*
WHAT THIS SCRIPT ACCOMPLISHES:
✅ Creates SemanticVector nodes with rich text ready for embedding
✅ Sets up vector index infrastructure  
✅ Creates supporting indexes and constraints
✅ Validates implementation success
✅ Provides clear next steps

WHAT STILL NEEDS TO BE DONE:
⏳ Generate actual OpenAI embeddings (requires Python script)
⏳ Populate embedding property on SemanticVector nodes
⏳ Test similarity search functionality
⏳ Validate hybrid retrieval patterns

NEXT STEPS:
1. Run: python semantic-vectorization.py
   - This will generate OpenAI embeddings and populate the embedding property
2. Test similarity search functionality
3. Validate hybrid vector + graph traversal
4. Monitor performance and optimize as needed

ROLLBACK:
If you need to remove the vector layer:
neo4j-cypher-shell -f cleanup-vectors.cypher
*/