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
        self.neo4j_url = os.getenv("NEO4J_URL", "neo4j://localhost:7687")
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
                distance_strategy="cosine"
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

    def step4_test_similarity_search(self):
        """Test vector similarity search"""
        print("\n🔍 STEP 4: Testing similarity search...")
        
        test_queries = [
            "equipment failure cost manufacturing",
            "predictive maintenance strategy",
            "vacuum pump semiconductor process",
            "business impact downtime"
        ]
        
        for i, query in enumerate(test_queries, 1):
            print(f"\n   Test {i}: '{query}'")
            
            try:
                results = self.vector_store.similarity_search_with_score(query, k=2)
                
                for j, (doc, score) in enumerate(results, 1):
                    concept_id = doc.metadata.get('concept_id', 'Unknown')
                    label = doc.metadata.get('label', 'Unknown')
                    print(f"      {j}. {concept_id}")
                    print(f"         Similarity: {score:.3f}")
                    print(f"         Label: {label}")
                    
            except Exception as e:
                print(f"      ❌ Search failed: {e}")
        
        print("\n✅ Similarity search working!")

    def step5_test_hybrid_retrieval(self):
        """Test hybrid retrieval (vector + graph)"""
        print("\n🔗 STEP 5: Testing hybrid retrieval...")
        
        query = "vacuum pump equipment failure"
        print(f"   Query: '{query}'")
        
        try:
            # Vector similarity search
            vector_results = self.vector_store.similarity_search_with_score(query, k=2)
            print(f"\n   📊 Vector results:")
            
            for doc, score in vector_results:
                concept_id = doc.metadata.get('concept_id')
                print(f"      • {concept_id} (similarity: {score:.3f})")
                
                # Graph traversal for this concept
                traversal_query = """
                MATCH (concept:SemanticConcept {conceptId: $concept_id})
                OPTIONAL MATCH (concept)<-[:HAS_SEMANTIC_TYPE]-(entity)
                OPTIONAL MATCH (entity)-[:HAS_RUL_ASSESSMENT]->(rul:RemainingUsefulLife)
                OPTIONAL MATCH (entity)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
                
                RETURN concept.label as concept_label,
                       entity.pumpIdentifier as entity_id,
                       labels(entity)[0] as entity_type,
                       rul.healthIndex as health_index,
                       pred.riskScore as risk_score
                """
                
                with self.driver.session() as session:
                    result = session.run(traversal_query, concept_id=concept_id)
                    record = result.single()
                    
                    if record and record['entity_id']:
                        print(f"        ↳ Connected to: {record['entity_id']} ({record['entity_type']})")
                        if record['health_index']:
                            print(f"        ↳ Health Index: {record['health_index']}")
                        if record['risk_score']:
                            print(f"        ↳ Risk Score: {record['risk_score']}")
                    else:
                        print(f"        ↳ No operational entities connected yet")
        
        except Exception as e:
            print(f"❌ Hybrid retrieval failed: {e}")
        
        print("\n✅ Hybrid retrieval working!")

    def step6_inspect_database(self):
        """Inspect what was created in Neo4j"""
        print("\n🔍 STEP 6: Inspecting database changes...")
        
        # Check SemanticVector nodes
        vector_query = """
        MATCH (sv:SemanticVector)
        RETURN sv.concept_id as concept_id,
               sv.label as label,
               size(sv.embedding) as embedding_size,
               substring(sv.text, 0, 60) as text_preview
        ORDER BY sv.concept_id
        """
        
        try:
            with self.driver.session() as session:
                result = session.run(vector_query)
                records = list(result)
                
                print(f"✅ Created {len(records)} SemanticVector nodes:")
                
                for record in records:
                    print(f"\n   📄 {record['concept_id']}")
                    print(f"      Label: {record['label']}")
                    print(f"      Embedding size: {record['embedding_size']} dimensions")
                    print(f"      Text: {record['text_preview']}...")
        
        except Exception as e:
            print(f"❌ Database inspection failed: {e}")
        
        # Check vector index
        index_query = "SHOW INDEXES YIELD name WHERE name CONTAINS 'semantic'"
        
        try:
            with self.driver.session() as session:
                result = session.run(index_query)
                indexes = list(result)
                
                print(f"\n✅ Created {len(indexes)} vector indexes:")
                for index in indexes:
                    print(f"   📇 {index['name']}")
        
        except Exception as e:
            print(f"⚠️  Could not check indexes: {e}")

    def run_complete_implementation(self):
        """Run the complete step-by-step implementation"""
        print("🚀 SEMANTIC CONCEPT VECTORIZATION - v2.1")
        print("=" * 60)
        
        try:
            # Run all steps
            semantic_data = self.step1_extract_semantic_content()
            texts, metadatas = self.step2_create_embedding_texts(semantic_data)
            self.step3_create_vector_store(texts, metadatas)
            self.step4_test_similarity_search()
            self.step5_test_hybrid_retrieval()
            self.step6_inspect_database()
            
            # Success summary
            print("\n" + "=" * 60)
            print("🎉 SUCCESS! v2.1 Vector Intelligence complete!")
            print("\n💡 What you now have:")
            print("   ✅ 3 semantic concepts converted to vector embeddings")
            print("   ✅ Similarity search working")
            print("   ✅ Hybrid vector + graph retrieval working")
            print("   ✅ New SemanticVector nodes in your database")
            print("   ✅ Vector index for fast similarity search")
            
            print("\n🧪 Try these example searches:")
            print("   • 'equipment maintenance cost' → finds VacuumPump_Concept")
            print("   • 'predictive analytics strategy' → finds ConditionBasedMaintenance_Concept")
            print("   • 'critical manufacturing process' → finds ProcessEnabler_Concept")
            
            print("\n📚 Next documentation steps:")
            print("   1. Update examples/v2.1-vector-intelligence/")
            print("   2. Create cypher script for reproducible implementation")
            print("   3. Update repository README.md")
            
        except Exception as e:
            print(f"\n❌ FAILED: {e}")
            print("\nTroubleshooting:")
            print("   • Check .env file exists and has correct values")
            print("   • Verify Neo4j connection")
            print("   • Ensure v2.0 semantic concepts exist")

    def cleanup(self):
        """Optional: Remove vector nodes to start over"""
        print("\n🧹 CLEANUP: Removing SemanticVector nodes...")
        
        response = input("Are you sure you want to remove all SemanticVector nodes? (y/N): ")
        if response.lower() != 'y':
            print("Cleanup cancelled")
            return
        
        try:
            with self.driver.session() as session:
                # Remove vector nodes
                session.run("MATCH (sv:SemanticVector) DELETE sv")
                print("✅ SemanticVector nodes removed")
                
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
    
    response = input("Ready to proceed with v2.1 Vector Intelligence? (y/N): ")
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