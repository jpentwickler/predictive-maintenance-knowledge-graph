# Predictive Maintenance Knowledge Graph

> AI-driven predictive maintenance knowledge graph for semiconductor manufacturing OEE optimization using Neo4j with semantic layer enhancement and vector intelligence

## Overview

This repository contains the complete ontology design and implementation for a comprehensive predictive maintenance knowledge graph specifically designed for semiconductor manufacturing environments. The system combines mathematical precision (v1.0), semantic intelligence (v2.0), and vector search capabilities (v2.1) to support an AI agent that autonomously optimizes Overall Equipment Effectiveness (OEE) through intelligent predictive maintenance of vacuum dry pumps and related critical equipment.

## 🎯 **Production Ready Knowledge Graph**

**Status**: ✅ **v2.1 VECTOR INTELLIGENCE** - Complete Implementation with Enhanced AI Agent Capabilities

![Knowledge Graph Diagram](docs/implementation/semantic-layer/semantic-enhanced-diagram.mmd)

### **Triple-Layer Architecture**
- **v1.0 Core**: Mathematical precision with survival analysis and condition monitoring
- **v2.0 Semantic**: Industry standards integration, business context, and enhanced AI reasoning
- **v2.1 Vector**: Semantic vector search with hybrid retrieval and enhanced agent capabilities

### Mathematical Foundation
```
P_30(t) = 1 - exp[-(λ_W(t) + k·λ_R(t))]

Where:
- λ_W(t) = ((t+30)^ρ - t^ρ)/β^ρ  [Weibull cumulative hazard]
- λ_R(t) = 30/RUL(t)              [Condition cumulative hazard]  
- k ∈ [0,1]                       [Blending weight]
- ρ, β                            [Weibull shape, scale parameters]
- t                               [Current pump age in days]
- RUL(t)                          [Remaining Useful Life]
```

## Key Features

### **v1.0 Core Capabilities**
- **30-Day Failure Probability Calculation** using survival analysis and condition monitoring
- **Weibull Survival Modeling** for historical lifetime analysis of pump populations
- **Real-time Health Index Assessment** from telemetry and sensor data
- **Blended Hazard Analysis** combining survival functions with condition monitoring
- **Mathematical Traceability** with complete calculation chain validation

### **v2.0 Semantic Enhancements**
- **Industry Standards Integration** (MIMOSA OSA-EAI, W3C SOSA, ISA-95)
- **Business Context Intelligence** with financial impact quantification
- **Semiconductor Domain Expertise** embedded in semantic layer
- **Enhanced AI Agent Reasoning** with rich contextual understanding
- **Enterprise System Integration** through standards compliance

### **v2.1 Vector Intelligence** ✨ NEW
- **Semantic Vector Search** using OpenAI embeddings with 1536 dimensions
- **Hybrid Retrieval** combining vector similarity with graph traversal
- **Enhanced LangGraph Agent** with intelligent tool selection
- **2-Hop Graph Integration** for comprehensive operational data retrieval
- **Similarity Score Analysis** with business context integration
- **Natural Language Queries** for equipment discovery and maintenance insights

### **AI Agent Capabilities**
- **Autonomous Decision Support** for predictive maintenance optimization
- **Business Impact Analysis** with $50K-$200K failure cost awareness
- **Standards Compliance Verification** for enterprise integration
- **Contextual Equipment Understanding** with domain-specific knowledge
- **Automated Probability Reporting** with stakeholder-specific communication
- **Semantic Equipment Discovery** through natural language queries
- **Hybrid Intelligence** combining traditional Cypher with vector similarity

## 📊 **Knowledge Graph Architecture**

### **Core Node Types (v1.0)**
- **DryPump**: Central entity with age, criticality, operational status
- **WeibullSurvivalFunction**: Mathematical survival model with shape/scale parameters
- **RemainingUsefulLife**: Health index and condition monitoring assessment
- **BlendedHazardFunction**: Combines survival + condition hazards
- **ThirtyDayFailureProbability**: Final prediction with risk classification (A-E)

### **Semantic Layer Types (v2.0)**
- **SemanticConcept**: Rich semantic descriptions and classifications
- **OntologyTerm**: Industry standards integration (MIMOSA, SOSA, ISA-95)
- **SemanticContext**: Business and domain-specific interpretations
- **InnovationContext**: Proprietary competitive advantage documentation
- **DomainConcept**: Academic and scientific foundation integration

### **Vector Intelligence Types (v2.1)** ✨ NEW
- **SemanticVector**: 1536D OpenAI embeddings with metadata
- **Vector Index**: `semantic_concepts_vector_index` for fast similarity search
- **Hybrid Relationships**: Connected graph paths for comprehensive retrieval

### **Equipment Hierarchy (ISA-95 + SEMI Compliant)**
```
Fab → FabArea → SemiconductorTool → ProcessChamber → DryPump
```

### **Mathematical Computation Chain**
```
DryPump → WeibullSurvivalFunction + RemainingUsefulLife → BlendedHazardFunction → ThirtyDayFailureProbability
```

### **Semantic Enhancement Chain**
```
DryPump → SemanticConcept → OntologyTerm (Standards)
                         → SemanticContext (Business Impact)
                         → InnovationContext (Competitive Advantage)
```

### **Vector Intelligence Chain** ✨ NEW
```
Natural Language Query → Vector Similarity Search → SemanticVector
                                                  → SemanticConcept
                                                  → Connected Equipment
                                                  → Operational Data (2-hop)
```

### **Risk Classification**
- **A (Critical)**: P₃₀ ≥ 80% - Act now
- **B (High)**: 60-80% - Schedule ASAP  
- **C (Medium)**: 30-60% - Intensify monitoring
- **D (Low-Medium)**: 10-30% - Routine checks
- **E (Low)**: <10% - Low risk

## Repository Structure

```
├── docs/
│   ├── ontology/                           # Ontology Development Process
│   │   ├── 01-domain-analysis.md          ✅ Complete
│   │   ├── 02-reuse-analysis.md           ✅ Complete
│   │   ├── 03-terminology.md              ✅ Complete (Survival Analysis Focus)
│   │   ├── 04-classes-hierarchy.md        ✅ Complete (Mathematical Foundation)
│   │   ├── 05-properties.md               ✅ Complete (Minimal Viable Properties)
│   │   ├── 06-constraints.md              ✅ Complete (Data Quality & Mathematical Constraints)
│   │   └── 07-instances.md                ✅ Complete
│   ├── implementation/                     # Technical Implementation
│   │   ├── neo4j-knowledge-graph.md       ✅ Complete - v1.0 Core Documentation
│   │   ├── knowledge-graph-diagram.mmd    ✅ Complete - v1.0 Core Diagram
│   │   ├── neo4j-schema.cypher            ✅ Complete - v1.0 Production Schema
│   │   ├── cypher-queries.md              ✅ Complete - Query Patterns
│   │   └── semantic-layer/                # v2.0 Semantic Layer
│   │       ├── README.md                  ✅ Complete - Semantic Architecture Overview
│   │       ├── semantic-layer-architecture.md ✅ Complete - Technical Architecture
│   │       ├── migration-guide.md         ✅ Complete - v1.0 to v2.0 Migration
│   │       └── semantic-enhanced-diagram.mmd ✅ Complete - v2.0 Visual Model
│   └── ai-agent/                          # AI Agent Framework
│       ├── decision-framework.md          🚧 Future
│       ├── reasoning-rules.md             🚧 Future
│       └── learning-mechanisms.md         🚧 Future
├── examples/                              # Implementation Examples
│   ├── v1.0-core/                        ✅ Complete - Mathematical Foundation
│   │   ├── README.md                     ✅ Complete - P002 Instance Documentation
│   │   ├── create-p002-instance.cypher   ✅ Complete - Complete Implementation Script
│   │   └── knowledge-graph-visualization.md ✅ Complete - Visual Analysis
│   ├── v2.0-semantic-layer/              ✅ Complete - Semantic Enhancement
│   │   ├── README.md                     ✅ Complete - Implementation Guide
│   │   ├── drypump-pilot-implementation.md ✅ Complete - Pilot Results
│   │   ├── drypump-semantic-enhancement.cypher ✅ Complete - Enhancement Script
│   │   └── semantic-validation.cypher    ✅ Complete - Validation Queries
│   ├── v2.1-vector-intelligence/         ✅ Complete - Vector Search Integration ✨ NEW
│   │   ├── README.md                     ✅ Complete - Vector Intelligence Guide
│   │   ├── semantic-vectorization.py     ✅ Complete - Enhanced Script with Relationships
│   │   └── vector-search-examples.md     ✅ Complete - Usage Examples
│   ├── competency-questions-validation.md ✅ Complete - Validation Framework
│   └── pump-p002/                        ✅ Complete - Specific Instance Examples
├── agents/                               ✅ Complete - AI Agent Implementation ✨ NEW
│   └── agent_v_1_0/                     ✅ Complete - Enhanced LangGraph Agent
│       ├── README.md                     ✅ Complete - Agent Architecture Guide
│       └── JupyterNotebook/             ✅ Complete - Interactive Implementation
│           └── GraphRaG_Neo4j.ipynb     ✅ Complete - Enhanced with Vector Search
├── src/                                   # Source Code (Future)
│   ├── ontology/                         🚧 Future
│   ├── neo4j/                            🚧 Future
│   └── ai-agent/                         🚧 Future
```

## Implementation Versions

### **v1.0 Core Implementation** ✅ Complete
**Mathematical Foundation with Production-Ready P002 Instance**

- **Complete Ontology**: 7-step methodology fully implemented
- **Mathematical Models**: Weibull survival analysis + condition monitoring
- **P002 Pump Instance**: Real operational example with 13.6% failure probability
- **Production Schema**: Full Neo4j constraints, indexes, and validation
- **Query Patterns**: Optimized Cypher for AI agent operations

**Key Achievements**:
- Blended hazard analysis combining historical + real-time data
- 30-day failure probability prediction with 83% confidence
- Complete mathematical traceability and validation
- ISA-95 compliant equipment hierarchy

### **v2.0 Semantic Enhancement** ✅ Complete
**Industry Standards Integration with Enhanced AI Capabilities**

- **Semantic Overlay**: Non-breaking enhancement preserving v1.0 functionality
- **Industry Standards**: MIMOSA OSA-EAI, W3C SOSA, ISA-95 integration
- **Business Context**: Semiconductor manufacturing domain expertise
- **AI Enhancement**: Richer reasoning context for autonomous decisions
- **DryPump Pilot**: Complete semantic coverage for equipment entities

**Key Achievements**:
- 4 industry standards successfully integrated
- $50K-$200K business impact quantification
- Enhanced AI agent reasoning with contextual understanding
- Enterprise integration readiness through standards compliance

### **v2.1 Vector Intelligence** ✅ Complete ✨ NEW
**Semantic Vector Search with Enhanced AI Agent Capabilities**

- **Vector Integration**: Non-breaking enhancement preserving v1.0 + v2.0 functionality
- **OpenAI Embeddings**: 1536-dimensional semantic vectors with cosine similarity
- **Hybrid Retrieval**: Vector similarity + 2-hop graph traversal
- **Enhanced Agent**: LangGraph-based AI with intelligent tool selection
- **Relationship Fix**: Proper graph integration eliminating isolated vector nodes

**Key Achievements**:
- Semantic vector search with similarity scores
- Hybrid intelligence combining vectors + graph relationships
- Enhanced LangGraph agent with natural language query capabilities
- 2-hop operational data integration (Equipment → Health → Business Context)
- Real-time similarity-based equipment discovery

## Quick Start

### **Option 1: Complete v2.1 Enhanced Implementation (Recommended)** ✨ NEW
```bash
# Build complete knowledge graph with vector intelligence
git clone https://github.com/jpentwickler/predictive-maintenance-knowledge-graph.git
cd predictive-maintenance-knowledge-graph

# Step 1: Create v1.0 mathematical foundation
neo4j-cypher-shell -f examples/v1.0-core/create-p002-instance.cypher

# Step 2: Add v2.0 semantic layer
neo4j-cypher-shell -f examples/v2.0-semantic-layer/drypump-semantic-enhancement.cypher

# Step 3: Add v2.1 vector intelligence with proper relationships
python examples/v2.1-vector-intelligence/semantic-vectorization.py

# Step 4: Test enhanced AI agent capabilities
jupyter notebook agents/agent_v_1_0/JupyterNotebook/GraphRaG_Neo4j.ipynb
```

### **Option 2: v2.0 Semantic Enhanced (Without Vector Intelligence)**
```bash
# Mathematical foundation + semantic layer
neo4j-cypher-shell -f examples/v1.0-core/create-p002-instance.cypher
neo4j-cypher-shell -f examples/v2.0-semantic-layer/drypump-semantic-enhancement.cypher
```

### **Option 3: v1.0 Core Only**
```bash
# Mathematical foundation only
neo4j-cypher-shell -f examples/v1.0-core/create-p002-instance.cypher
```

### **View Documentation**
1. **Vector Intelligence Guide**: [v2.1 Vector Intelligence Examples](examples/v2.1-vector-intelligence/README.md) ✨ NEW
2. **Enhanced AI Agent**: [Agent Architecture Documentation](agents/agent_v_1_0/README.md) ✨ NEW
3. **Architecture Overview**: [Semantic Layer Architecture](docs/implementation/semantic-layer/semantic-layer-architecture.md)
4. **Implementation Guide**: [v2.0 Semantic Layer Examples](examples/v2.0-semantic-layer/README.md)
5. **v1.0 Foundation**: [Core Implementation Documentation](examples/v1.0-core/README.md)
6. **Migration Guide**: [v1.0 to v2.0 Enhancement](docs/implementation/semantic-layer/migration-guide.md)

## Enhanced AI Agent Capabilities ✨ NEW

### **Semantic Equipment Discovery** (v2.1)
```python
# Natural language query with vector similarity search
agent.search("What equipment is related to vacuum technology and process efficiency?")
```

**Sample Results**:
```
🔍 Semantic Similarity Search Results:

1. Vacuum Pump Equipment
   - Similarity Score: 0.8234
   - Connected Equipment: P002
   - Health Index: 0.28
   - Risk Score: 0.136

2. Process Enabling Equipment  
   - Similarity Score: 0.7892
   - Connected Equipment: P002
   - Business Context: Equipment failure causes immediate process shutdown...
```

### **Hybrid Retrieval Architecture** (v2.1)
```python
# Combines vector similarity with graph traversal
query → vector_search → semantic_concepts → equipment → operational_data
```

**2-Hop Graph Integration**:
- **Hop 1**: SemanticConcept → DryPump (via HAS_SEMANTIC_TYPE)
- **Hop 2**: DryPump → RUL/FailurePrediction/ProcessChamber (operational data)

### **Business Impact Analysis** (v2.0)
```cypher
// AI agent understands business implications
MATCH (pump:DryPump {pumpIdentifier: "P002"})-[:HAS_SEMANTIC_TYPE]->(concept:SemanticConcept)
      -[context_rel:HAS_MEANING_IN_CONTEXT]->(context:SemanticContext)
WHERE context.industry = "Semiconductor"
RETURN pump.pumpIdentifier, pump.criticalityLevel, concept.label,
       context_rel.businessImplication as BusinessImpact
```

**Sample Results**:
- **P002 (Level5) Vacuum Pump Equipment** → "Equipment failure causes immediate process shutdown with $50K-$200K production impact per incident"
- **P002 (Level5) Process Enabling Equipment** → "Unscheduled downtime disrupts committed customer deliveries and negatively impacts fab OEE metrics"

### **Standards Compliance Verification** (v2.0)
```cypher
// AI agent verifies industry standards alignment
MATCH (pump:DryPump {pumpIdentifier: "P002"})-[:HAS_SEMANTIC_TYPE]->(concept:SemanticConcept)
      -[:ALIGNED_WITH]->(term:OntologyTerm)
RETURN pump.pumpIdentifier, concept.label, term.ontologySource, 
       term.termLabel, term.standardVersion
```

### **Mathematical Traceability** (v1.0)
```cypher
// Trace all calculation components for specific pump
MATCH (p:DryPump {pumpIdentifier: 'P002'})
MATCH (p)-[:HAS_SURVIVAL_MODEL]->(w:WeibullSurvivalFunction)
MATCH (p)-[:HAS_RUL_ASSESSMENT]->(rul:RemainingUsefulLife)
MATCH (p)-[:HAS_HAZARD_CALCULATION]->(h:BlendedHazardFunction)
MATCH (h)-[:GENERATES_PREDICTION]->(pred:ThirtyDayFailureProbability)
RETURN p.currentAge, w.weibullShape, w.weibullScale,
       rul.remainingUsefulLife, rul.healthIndex,
       h.blendingWeight, pred.failureProbability
```

### **Daily Risk Assessment** (v1.0 + v2.0 + v2.1)
```cypher
// Get all pumps with current risk and business context
MATCH (p:DryPump)-[:HAS_FAILURE_PREDICTION]->(pred:ThirtyDayFailureProbability)
MATCH (p)-[:SERVES]->(c:ProcessChamber)-[:PART_OF]->(t:SemiconductorTool)
OPTIONAL MATCH (p)-[:HAS_SEMANTIC_TYPE]->(concept:SemanticConcept)
             -[:HAS_MEANING_IN_CONTEXT]->(context:SemanticContext)
WHERE pred.predictionTimestamp >= datetime() - duration('PT24H')
RETURN p.pumpIdentifier, p.criticalityLevel, t.toolId, 
       pred.failureProbability, pred.riskClassification,
       context.businessImplication as BusinessImpact
ORDER BY pred.failureProbability DESC
```

## Technology Stack

- **Knowledge Graph**: Neo4j 5.x with APOC plugin
- **Mathematical Foundation**: Weibull survival analysis + Health index monitoring
- **Semantic Layer**: Industry standards integration (MIMOSA, SOSA, ISA-95)
- **Vector Intelligence**: OpenAI embeddings (1536D) with cosine similarity ✨ NEW
- **AI Agent Framework**: LangGraph with ReAct methodology ✨ NEW
- **Hybrid Retrieval**: Vector similarity + graph traversal ✨ NEW
- **Ontology Modeling**: Based on Noy & McGuinness methodology
- **Standards Compliance**: ISA-95, SEMI E10/E30, MIMOSA OSA-EAI, W3C SOSA
- **Manufacturing Integration**: SEMI standards, ISA-95 compatibility
- **Business Intelligence**: Financial impact analysis and domain expertise

## Core Use Cases

### **Primary Use Case**: Intelligent Equipment Discovery ✨ NEW
The enhanced AI agent uses natural language queries to discover equipment through semantic similarity, providing comprehensive operational data and business context with similarity scores.

### **Traditional Use Case**: 30-Day Failure Probability Reporting
The AI agent generates regular reports showing every dry pump and its corresponding probability of failure in the next 30 days, with complete business context and standards compliance.

### **Enhanced Use Cases**:
- **Semantic Equipment Search**: "Find equipment related to vacuum technology"
- **Maintenance Strategy Discovery**: "What maintenance approaches are used for critical equipment?"
- **Business Impact Analysis**: "Show equipment that affects manufacturing cost and uptime"
- **Hybrid Intelligence**: Vector similarity + graph relationships for comprehensive insights
- **Enterprise Integration**: Standards-compliant data exchange with manufacturing systems
- **Innovation Documentation**: Competitive advantage tracking and patent potential assessment

## Implementation Status

### **✅ Completed Phases**

#### **Phase 1: Ontology Development** (Steps 1-6)
- Domain analysis and terminology establishment
- Mathematical foundation with survival analysis
- Property definitions and constraint validation
- Production-ready schema design

#### **Phase 2: Core Implementation** (Step 7 - v1.0)
- Complete P002 pump instance with operational data
- Mathematical model integration and validation
- Query pattern optimization for AI agent operations
- Performance testing and production deployment

#### **Phase 3: Semantic Enhancement** (v2.0)
- Industry standards integration (MIMOSA, SOSA, ISA-95)  
- Business context and domain expertise embedding
- Enhanced AI agent reasoning capabilities
- Enterprise integration readiness

#### **Phase 4: Vector Intelligence** (v2.1) ✨ NEW
- OpenAI embeddings integration with proper graph relationships
- Semantic vector search with similarity scoring
- Enhanced LangGraph agent with hybrid retrieval
- 2-hop graph traversal for comprehensive operational data
- Natural language query capabilities for equipment discovery

### **🚧 Future Phases**

#### **Phase 5: Full Entity Coverage**
- Extend semantic layer to all 12 entity types
- Cross-entity semantic relationships
- Advanced inference capabilities

#### **Phase 6: Production AI Agent**
- Real-time telemetry integration
- Automated report generation and distribution
- Machine learning model updates
- Performance monitoring and optimization

## Contributing

This knowledge graph is designed for continuous improvement. We welcome contributions in:
- **Domain Expertise**: Semiconductor manufacturing and reliability engineering insights
- **Technical Implementation**: Neo4j optimization and semantic modeling
- **Vector Intelligence**: Embedding optimization and hybrid retrieval improvements ✨ NEW
- **AI Agent Enhancement**: Advanced reasoning and decision-making capabilities ✨ NEW
- **Standards Integration**: Additional industry ontology mappings
- **Real-World Validation**: Production deployment feedback and optimization

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Documentation

Comprehensive documentation follows the structured ontology development methodology with emphasis on:
- Mathematical foundations and production readiness (v1.0)
- Semantic intelligence and industry standards integration (v2.0)
- Vector search capabilities and enhanced agent intelligence (v2.1) ✨ NEW
- Enhanced AI agent capabilities and business intelligence

---

## Status Summary

**Current Status**: ✅ **v2.1 Production Ready** - Complete implementation with vector intelligence and enhanced AI agent

**Implementation Achievements**:
- ✅ Complete ontology development (Steps 1-7)
- ✅ v1.0 Core: Mathematical precision with P002 operational instance
- ✅ v2.0 Semantic: Industry standards integration with enhanced AI capabilities
- ✅ v2.1 Vector: Semantic search with hybrid retrieval and enhanced agent ✨ NEW
- ✅ Production deployment ready with comprehensive validation
- ✅ Enhanced LangGraph AI agent with natural language query capabilities ✨ NEW

**Business Value Delivered**:
- **Mathematical Precision**: 13.6% failure probability prediction with 83% confidence
- **Business Intelligence**: $50K-$200K financial impact awareness
- **Standards Compliance**: MIMOSA, SOSA, ISA-95 integration for enterprise systems
- **Domain Expertise**: Semiconductor manufacturing knowledge embedded
- **AI Enhancement**: Contextual reasoning for autonomous decision-making
- **Vector Intelligence**: Semantic equipment discovery through natural language ✨ NEW
- **Hybrid Retrieval**: Vector similarity + graph relationships for comprehensive insights ✨ NEW

**Next Evolution**:
- [ ] Extend vector intelligence to complete entity coverage
- [ ] Advanced semantic inference and cross-entity relationships
- [ ] Real-time production integration and monitoring
- [ ] Machine learning model optimization and continuous improvement
- [ ] Multi-agent orchestration for complex maintenance scenarios

**Last Updated**: August 9, 2025 ✨ NEW  
**Current Version**: v2.1 - Vector Intelligence Enhanced ✨ NEW  
**Model Status**: Production Ready with AI Agent and Vector Search Capabilities ✨ NEW
