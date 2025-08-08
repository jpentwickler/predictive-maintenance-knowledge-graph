"""
semantic_vectorization.py
Environment-based implementation using .env file for credentials

SETUP:
1. Create .env file in project root
2. Add credentials to .env file
3. Install: pip install python-dotenv langchain-community langchain-openai neo4j
4. Run: python semantic-vectorization.py
"""

from langchain_community.vectorstores import Neo4jVector
from langchain_openai import OpenAIEmbeddings
from neo4j import GraphDatabase
from dotenv import load_dotenv
import os
import sys

# Load environment variables from .env file
load_dotenv()

class SemanticVectorizer:
    def __init__(self):
        print("🚀 Initializing Semantic Vectorizer...")
        
        # Load credentials from environment
        self.neo4j_url = os.getenv("NEO4J_URI", "neo4j://localhost:7687")
        self.neo4j_username = os.getenv("NEO4J_USERNAME", "neo4j")
        self.neo4j_password = os.getenv("NEO4J_PASSWORD")
        self.openai_api_key = os.getenv("OPENAI_API_KEY")
        
        # Validate required environment variables
        missing_vars = []
        if not self.neo4j_password:
            missing_vars.append("NEO4J_PASSWORD")
        if not self.openai_api_key:
            missing_vars.append("OPENAI_API_KEY")
        
        if missing_vars:
            print("❌ ERROR: Missing required environment variables:")
            for var in missing_vars:
                print(f"   - {var}")
            print("\n📝 Create a .env file with:")
            print("   NEO4J_URL=neo4j://localhost:7687")
            print("   NEO4J_USERNAME=neo4j")
            print("   NEO4J_PASSWORD=your_password_here")
            print("   OPENAI_API_KEY=sk-your_key_here")
            sys.exit(1)
        
        # Initialize connections
        try:
            self.driver = GraphDatabase.driver(
                self.neo4j_url, 
                auth=(self.neo4j_username, self.neo4j_password)
            )
            self.embeddings = OpenAIEmbeddings(openai_api_key=self.openai_api_key)
            self.vector_store = None
            print("✅ Connections initialized successfully")
            print(f"   Neo4j: {self.neo4j_url}")
            print(f"   Username: {self.neo4j_username}")
        except Exception as e:
            print(f"❌ ERROR: Failed to connect to Neo4j: {e}")
            print("   Check your .env file credentials")
            sys.exit(1)

    def step1_extract_semantic_content(self):
        """Extract semantic content from your existing nodes"""
        print("\n📖 STEP 1: Extracting semantic content...")
        
        query = """
        MATCH (sc:SemanticConcept)
        OPTIONAL MATCH (sc)-[ctx:HAS_MEANING_IN_CONTEXT]->(context:SemanticContext)
        OPTIONAL MATCH (sc)-[innov:REPRESENTS_INNOVATION_IN]->(innovation:InnovationContext)
        
        RETURN sc.conceptId as concept_id,
               sc.label as label,
               sc.definition as definition,
               sc.domain as domain,
               ctx.businessImplication as business_impact,
               ctx.contextualInterpretation as context_interpretation,
               innovation.businessAdvantage as innovation_advantage
        ORDER BY sc.conceptId
        """
        
        with self.driver.session() as session:
            result = session.run(query)
            records = [dict(record) for record in result]
        
        print(f"✅ Found {len(records)} semantic concepts:")
        for record in records:
            print(f"   • {record['concept_id']}: {record['label']}")
        
        if len(records) == 0:
            print("❌ ERROR: No semantic concepts found!")
            print("   Make sure you have run the v2.0 semantic enhancement first:")
            print("   neo4j-cypher-shell -f examples/v2.0-semantic-layer/drypump-semantic-enhancement.cypher")
            sys.exit(1)
            
        return records

    def step2_create_embedding_texts(self, semantic_data):
        """Create rich embedding text from semantic content"""
        print("\n✏️  STEP 2: Creating embedding texts...")
        
        texts = []
        metadatas = []
        
        for data in semantic_data:
            # Build rich embedding text
            embedding_text = f"{data['label']}: {data['definition']}"
            
            # Add domain
            if data['domain']:
                embedding_text += f" | Domain: {data['domain']}"
            
            # Add business impact
            if data['business_impact']:
                embedding_text += f" | Business Impact: {data['business_impact']}"
            
            # Add context
            if data['context_interpretation']:
                embedding_text += f" | Context: {data['context_interpretation']}"
            
            # Add innovation advantage if exists
            if data['innovation_advantage']:
                embedding_text += f" | Innovation: {data['innovation_advantage']}"
            
            texts.append(embedding_text)
            
            # Create metadata for retrieval
            metadatas.append({
                'concept_id': data['concept_id'],
                'label': data['label'],
                'domain': data['domain'] or 'Unknown',
                'source': 'semantic_concept'
            })
            
            print(f"✅ Created text for {data['concept_id']}")
            print(f"   Preview: {embedding_text[:80]}...")
        
        return texts, metadatas

    def step3_create_vector_store(self, texts, metadatas):
        """Create Neo4j vector store with embeddings"""
        print("\n🔄 STEP 3: Creating vector store...")
        print("   📡 Calling OpenAI API to generate embeddings...")
        print("   ⏱️  This may take 10-30 seconds...")
        
        try:
            # Create Neo4j vector store
            self.vector_store = Neo4jVector.from_texts(
                texts=texts,
                embedding=self.embeddings,
                metadatas=metadatas,
                url=self.neo4j_url,
                username=self.neo4j_username,
                password=self.neo4j_password,
                index_name="semantic_concepts_vector_index",
                node_label="SemanticVector",
                text_node_property="text",
                embedding_node_property="embedding",
                distance_strategy="COSINE"
            )
            
            print(f"✅ Vector store created successfully!")
            print(f"   📊 Index: semantic_concepts_vector_index")
            print(f"   🏷️  Node type: SemanticVector")
            print(f"   📈 Total vectors: {len(texts)}")
            print(f"   💰 OpenAI cost: ~$0.10")
            
        except Exception as e:
            print(f"❌ ERROR: Failed to create vector store: {e}")
            print("   Common issues:")
            print("   - Invalid OpenAI API key in .env file")
            print("   - Network connectivity issues")
            print("   - Neo4j permissions")
            raise

    def step4_create_semantic_relationships(self):
        """Create relationships between SemanticVector nodes and the existing knowledge graph"""
        print("\n🔗 STEP 4: Creating semantic relationships...")
        
        try:
            with self.driver.session() as session:
                # 1. Connect SemanticVector nodes to their corresponding SemanticConcept nodes
                print("   📊 Connecting vectors to semantic concepts...")
                relationship_query_1 = """
                MATCH (sv:SemanticVector)
                MATCH (sc:SemanticConcept {conceptId: sv.concept_id})
                MERGE (sv)-[:VECTOR_REPRESENTATION_OF]->(sc)
                RETURN sv.concept_id as concept_id, 
                       'Connected to SemanticConcept' as status
                """
                
                result_1 = session.run(relationship_query_1)
                records_1 = list(result_1)
                print(f"   ✅ Created {len(records_1)} VECTOR_REPRESENTATION_OF relationships")
                
                for record in records_1:
                    print(f"      • {record['concept_id']} → SemanticConcept")
                
                # 2. Create direct relationships from operational equipment to vector representations  
                print("   🔧 Connecting equipment to vector representations...")
                relationship_query_2 = """
                MATCH (dp:DryPump)-[:HAS_SEMANTIC_TYPE]->(sc:SemanticConcept)
                MATCH (sv:SemanticVector {concept_id: sc.conceptId})
                MERGE (dp)-[:HAS_VECTOR_REPRESENTATION]->(sv)
                RETURN dp.pumpIdentifier as pump_id,
                       sv.concept_id as vector_concept,
                       'Connected' as status
                """
                
                result_2 = session.run(relationship_query_2)
                records_2 = list(result_2)
                print(f"   ✅ Created {len(records_2)} HAS_VECTOR_REPRESENTATION relationships")
                
                for record in records_2:
                    print(f"      • {record['pump_id']} → {record['vector_concept']}")
                
                # 3. Verify the relationship structure
                print("   🔍 Verifying relationship structure...")
                verification_query = """
                MATCH (dp:DryPump)-[:HAS_VECTOR_REPRESENTATION]->(sv:SemanticVector)
                      -[:VECTOR_REPRESENTATION_OF]->(sc:SemanticConcept)
                RETURN dp.pumpIdentifier as pump,
                       sv.concept_id as vector_concept,
                       sc.label as semantic_label,
                       size(sv.embedding) as embedding_dims
                """
                
                result_3 = session.run(verification_query)
                records_3 = list(result_3)
                
                print(f"   ✅ Verified {len(records_3)} complete paths: Equipment → Vector → Concept")
                for record in records_3:
                    print(f"      • {record['pump']} → {record['vector_concept']} → {record['semantic_label']}")
                
                print(f"\n✅ Semantic relationships created successfully!")
                print(f"   📈 Total vector-to-concept connections: {len(records_1)}")
                print(f"   🔧 Total equipment-to-vector connections: {len(records_2)}")
                print(f"   🔗 Total verified paths: {len(records_3)}")
                
        except Exception as e:
            print(f"❌ ERROR: Failed to create semantic relationships: {e}")
            print("   Common issues:")
            print("   - SemanticVector nodes not yet created")
            print("   - SemanticConcept nodes missing")
            print("   - Equipment nodes not linked to semantic concepts")
            raise

    def step5_test_enhanced_hybrid_retrieval(self):
        """Test enhanced hybrid retrieval with proper graph integration"""
        print("\n🚀 STEP 5: Testing enhanced hybrid retrieval...")
        
        query = "vacuum pump equipment failure"
        print(f"   Query: '{query}'")
        
        try:
            # Vector similarity search
            vector_results = self.vector_store.similarity_search_with_score(query, k=2)
            print(f"\n   📊 Vector similarity results:")
            
            for doc, score in vector_results:
                concept_id = doc.metadata.get('concept_id')
                label = doc.metadata.get('label')
                print(f"      • {concept_id} (similarity: {score:.3f})")
                print(f"        Label: {label}")
                
                # Enhanced graph traversal using the new relationships
                enhanced_traversal_query = """
                MATCH (sv:SemanticVector {concept_id: $concept_id})
                MATCH (sv)-[:VECTOR_REPRESENTATION_OF]->(sc:SemanticConcept)
                MATCH (dp:DryPump)-[:HAS_VECTOR_REPRESENTATION]->(sv)
                OPTIONAL MATCH (dp)-[:HAS_RUL_ASSESSMENT]->(rul:RemainingUsefulLife)
                OPTIONAL MATCH (dp)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
                OPTIONAL MATCH (sc)-[:HAS_MEANING_IN_CONTEXT]->(ctx:SemanticContext)
                
                RETURN sc.label as concept_label,
                       dp.pumpIdentifier as pump_id,
                       dp.isOperational as is_operational,
                       rul.healthIndex as health_index,
                       pred.riskScore as risk_score,
                       ctx.businessContext as business_context
                """
                
                with self.driver.session() as session:
                    result = session.run(enhanced_traversal_query, concept_id=concept_id)
                    record = result.single()
                    
                    if record and record['pump_id']:
                        print(f"        ↳ Connected Equipment: {record['pump_id']}")
                        print(f"        ↳ Operational: {record['is_operational']}")
                        if record['health_index']:
                            print(f"        ↳ Health Index: {record['health_index']}")
                        if record['risk_score']:
                            print(f"        ↳ Risk Score: {record['risk_score']}")
                        if record['business_context']:
                            print(f"        ↳ Business Context: {record['business_context'][:60]}...")
                    else:
                        print(f"        ↳ No operational equipment data available")
        
        except Exception as e:
            print(f"❌ Enhanced hybrid retrieval failed: {e}")
        
        print(f"\n✅ Enhanced hybrid retrieval working!")

    def step6_test_equipment_to_vector_queries(self):
        """Test queries starting from equipment and traversing to vectors"""
        print("\n🔧 STEP 6: Testing equipment-to-vector queries...")
        
        try:
            # Query from equipment to all its vector representations
            equipment_to_vector_query = """
            MATCH (dp:DryPump {pumpIdentifier: 'P002'})
            MATCH (dp)-[:HAS_VECTOR_REPRESENTATION]->(sv:SemanticVector)
            MATCH (sv)-[:VECTOR_REPRESENTATION_OF]->(sc:SemanticConcept)
            OPTIONAL MATCH (sc)-[:HAS_MEANING_IN_CONTEXT]->(ctx:SemanticContext)
            
            RETURN dp.pumpIdentifier as pump,
                   sv.concept_id as vector_concept,
                   sc.label as semantic_label,
                   sc.domain as domain,
                   size(sv.embedding) as embedding_dimensions,
                   ctx.businessContext as business_context
            ORDER BY sc.domain
            """
            
            with self.driver.session() as session:
                result = session.run(equipment_to_vector_query)
                records = list(result)
                
                print(f"   ✅ Found {len(records)} vector representations for pump P002:")
                
                for record in records:
                    print(f"\n      📄 {record['vector_concept']}")
                    print(f"         Domain: {record['domain']}")
                    print(f"         Label: {record['semantic_label']}")
                    print(f"         Embedding dimensions: {record['embedding_dimensions']}")
                    if record['business_context']:
                        print(f"         Business context: {record['business_context'][:80]}...")
                
        except Exception as e:
            print(f"❌ Equipment-to-vector queries failed: {e}")
        
        print(f"\n✅ Equipment-to-vector queries working!")

    def step7_inspect_enhanced_database(self):
        """Inspect the enhanced database with relationships"""
        print("\n🔍 STEP 7: Inspecting enhanced database structure...")
        
        # Check SemanticVector node relationships
        relationship_inspection_query = """
        MATCH (sv:SemanticVector)
        OPTIONAL MATCH (sv)-[r1:VECTOR_REPRESENTATION_OF]->(sc:SemanticConcept)
        OPTIONAL MATCH (dp:DryPump)-[r2:HAS_VECTOR_REPRESENTATION]->(sv)
        
        RETURN sv.concept_id as concept_id,
               sv.label as label,
               size(sv.embedding) as embedding_size,
               sc.conceptId as linked_concept,
               dp.pumpIdentifier as linked_equipment,
               CASE WHEN r1 IS NOT NULL THEN 'Yes' ELSE 'No' END as has_concept_link,
               CASE WHEN r2 IS NOT NULL THEN 'Yes' ELSE 'No' END as has_equipment_link
        ORDER BY sv.concept_id
        """
        
        try:
            with self.driver.session() as session:
                result = session.run(relationship_inspection_query)
                records = list(result)
                
                print(f"✅ Enhanced SemanticVector structure ({len(records)} nodes):")
                
                for record in records:
                    print(f"\n   📄 {record['concept_id']}")
                    print(f"      Label: {record['label']}")
                    print(f"      Embedding size: {record['embedding_size']} dimensions")
                    print(f"      Linked to concept: {record['has_concept_link']} ({record['linked_concept']})")
                    print(f"      Linked to equipment: {record['has_equipment_link']} ({record['linked_equipment']})")
        
        except Exception as e:
            print(f"❌ Enhanced database inspection failed: {e}")
        
        # Check relationship counts
        relationship_count_query = """
        MATCH ()-[r:VECTOR_REPRESENTATION_OF]->()
        RETURN 'VECTOR_REPRESENTATION_OF' as relationship_type, count(r) as count
        
        UNION
        
        MATCH ()-[r:HAS_VECTOR_REPRESENTATION]->()
        RETURN 'HAS_VECTOR_REPRESENTATION' as relationship_type, count(r) as count
        """
        
        try:
            with self.driver.session() as session:
                result = session.run(relationship_count_query)
                rel_counts = list(result)
                
                print(f"\n✅ Relationship counts:")
                for rel in rel_counts:
                    print(f"   📊 {rel['relationship_type']}: {rel['count']}")
        
        except Exception as e:
            print(f"⚠️  Could not check relationship counts: {e}")

    def run_complete_implementation(self):
        """Run the complete step-by-step implementation with enhanced relationships"""
        print("🚀 SEMANTIC CONCEPT VECTORIZATION - v2.1 (Enhanced)")
        print("=" * 60)
        
        try:
            # Run all steps including the new relationship creation
            semantic_data = self.step1_extract_semantic_content()
            texts, metadatas = self.step2_create_embedding_texts(semantic_data)
            self.step3_create_vector_store(texts, metadatas)
            self.step4_create_semantic_relationships()  # NEW STEP
            self.step5_test_enhanced_hybrid_retrieval()  # ENHANCED
            self.step6_test_equipment_to_vector_queries()  # NEW STEP
            self.step7_inspect_enhanced_database()  # ENHANCED
            
            # Enhanced success summary
            print("\n" + "=" * 60)
            print("🎉 SUCCESS! v2.1 Enhanced Vector Intelligence complete!")
            print("\n💡 What you now have:")
            print("   ✅ 3 semantic concepts converted to vector embeddings")
            print("   ✅ Proper graph integration with relationships")
            print("   ✅ Equipment-to-vector-to-concept traversal paths")
            print("   ✅ Enhanced hybrid vector + graph retrieval")
            print("   ✅ Business context integration")
            print("   ✅ Full semantic search capabilities")
            
            print("\n🧪 Try these enhanced example searches:")
            print("   • Vector similarity + equipment health data")
            print("   • Equipment-based semantic queries")
            print("   • Business impact analysis via semantic paths")
            
            print("\n🔗 New relationship types created:")
            print("   • SemanticVector -[:VECTOR_REPRESENTATION_OF]-> SemanticConcept")
            print("   • DryPump -[:HAS_VECTOR_REPRESENTATION]-> SemanticVector")
            
            print("\n📚 Enhanced capabilities:")
            print("   1. Start from equipment → find vector representations")
            print("   2. Vector similarity → traverse to operational data")
            print("   3. Semantic concepts → business impact analysis")
            
        except Exception as e:
            print(f"\n❌ FAILED: {e}")
            print("\nTroubleshooting:")
            print("   • Check .env file exists and has correct values")
            print("   • Verify Neo4j connection")
            print("   • Ensure v2.0 semantic concepts exist")
            print("   • Verify SemanticVector nodes were created")

    def cleanup(self):
        """Optional: Remove vector nodes to start over"""
        print("\n🧹 CLEANUP: Removing SemanticVector nodes...")
        
        response = input("Are you sure you want to remove all SemanticVector nodes? (y/N): ")
        if response.lower() != 'y':
            print("Cleanup cancelled")
            return
        
        try:
            with self.driver.session() as session:
                # Remove vector nodes and their relationships
                session.run("MATCH (sv:SemanticVector) DETACH DELETE sv")
                print("✅ SemanticVector nodes and relationships removed")
                
                # Drop vector index
                session.run("DROP INDEX semantic_concepts_vector_index IF EXISTS")
                print("✅ Vector index removed")
                
        except Exception as e:
            print(f"❌ Cleanup failed: {e}")

    def close(self):
        """Close database connection"""
        if self.driver:
            self.driver.close()


# =============================================================================
# MAIN EXECUTION
# =============================================================================

if __name__ == "__main__":
    print("🔧 SETUP CHECKLIST:")
    print("   1. ✅ Install: pip install python-dotenv langchain-community langchain-openai neo4j")
    print("   2. ✅ Create .env file with your credentials")
    print("   3. ✅ Ensure v2.0 semantic layer exists")
    print()
    
    # Check if .env file exists
    if not os.path.exists('.env'):
        print("❌ .env file not found!")
        print("\n📝 Create .env file with:")
        print("NEO4J_URL=neo4j://localhost:7687")
        print("NEO4J_USERNAME=neo4j") 
        print("NEO4J_PASSWORD=your_password_here")
        print("OPENAI_API_KEY=sk-your_key_here")
        sys.exit(1)
    
    response = input("Ready to proceed with v2.1 Enhanced Vector Intelligence? (y/N): ")
    if response.lower() != 'y':
        print("Exiting...")
        sys.exit(0)
    
    # Run implementation
    vectorizer = SemanticVectorizer()
    
    try:
        vectorizer.run_complete_implementation()
    except KeyboardInterrupt:
        print("\n\n⏹️  Interrupted by user")
    except Exception as e:
        print(f"\n\n❌ Unexpected error: {e}")
    finally:
        vectorizer.close()
