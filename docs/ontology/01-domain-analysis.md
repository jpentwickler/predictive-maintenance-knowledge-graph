# Step 1: Domain Analysis - Determine Domain and Focus 🎯

> **Methodology Reference**: Noy & McGuinness (2000) - Step 1 of the 7-step iterative ontology development process

## Executive Summary

This ontology is designed to support an **AI agent** that autonomously optimizes semiconductor manufacturing **Overall Equipment Effectiveness (OEE)** through intelligent predictive maintenance of vacuum dry pumps and related critical equipment. The primary goal is to reduce unscheduled events, minimize wafer scrap losses, and optimize equipment availability through data-driven decision making and regular stakeholder reporting.

## Domain Analysis Summary

The predictive maintenance system is a **semiconductor manufacturing OEE optimization platform** powered by an **AI agent** that combines:

- **Weibull survival modeling** for historical lifetime analysis of critical vacuum dry pumps
- **Real-time telemetry monitoring** (power, pressure, temperature, vibration) from semiconductor manufacturing tools
- **Health Index computation** using unsupervised machine learning for anomaly detection
- **Blended hazard procedures** for 30-day failure risk assessment
- **5-level risk classification system** (A-E) for actionable maintenance decisions
- **AI Agent-Driven Decision Support** for autonomous predictive maintenance program management
- **OEE Optimization Focus** targeting quality (wafer scrap reduction) and availability (downtime minimization)
- **Semiconductor Manufacturing Integration** with fab operations, production schedules, and yield management
- **Unscheduled Event Prevention** specifically targeting dry pump crashes that cause production disruptions
- **Regular Risk Assessment Reporting** with automated, scheduled communication to stakeholders
- **Service Plan Reporting & Tracking** for transparent maintenance planning and execution monitoring

## Four Fundamental Questions

### 1. Which Domain should be covered by the ontology?

**Primary Domain**: **Semiconductor Manufacturing Equipment Predictive Maintenance with AI-Driven OEE Optimization and Stakeholder Reporting**

#### Critical Sub-domains:

- **🔬 Semiconductor Manufacturing Operations**
  - Fab processes, wafer production, yield management, lot tracking
  - Process chambers, clean rooms, manufacturing environments
  - Production scheduling, cycle time optimization

- **📊 Overall Equipment Effectiveness (OEE)**
  - Availability metrics (planned vs. unplanned downtime)
  - Performance rates (actual vs. theoretical throughput)
  - Quality yields (good wafers vs. total wafers)
  - Production efficiency measurements

- **🔧 Manufacturing Equipment Management**
  - Vacuum dry pumps (primary focus)
  - Semiconductor tools and process equipment
  - Support systems and utilities
  - Component hierarchies and dependencies

- **💰 Production Impact Analysis**
  - Wafer scrap costs and yield loss calculations
  - Downtime costs and opportunity losses
  - Cycle time impacts and throughput effects
  - Financial impact modeling

- **📈 Failure Analysis & Reliability Engineering**
  - Weibull modeling and survival analysis
  - MTBF (Mean Time Between Failures)
  - MTTR (Mean Time To Repair)
  - Failure modes specific to semiconductor equipment

- **📡 Real-time Manufacturing Monitoring**
  - Tool telemetry and sensor data
  - Process parameters and environmental conditions
  - Data quality and validation

- **🤖 AI Agent Decision Framework**
  - Autonomous reasoning and decision trees
  - Escalation protocols and human-in-the-loop
  - Learning mechanisms and model updates
  - Multi-criteria optimization algorithms

- **⚠️ Risk Assessment & Analytics**
  - Probability calculations and statistical modeling
  - Impact assessments and cost-benefit analysis
  - Trend analysis and pattern recognition

- **🔄 Predictive Maintenance Strategy**
  - Proactive scheduling and optimization
  - Spare parts management and inventory
  - Resource allocation and capacity planning

- **🚨 Unscheduled Event Prevention**
  - Failure prediction and early warning systems
  - Contingency planning and emergency response
  - Root cause analysis and prevention

- **📋 Reporting & Communication Framework**
  - Report templates and content customization
  - Stakeholder profiles and communication preferences
  - Delivery schedules and distribution mechanisms
  - Performance dashboards and visualizations

- **📅 Service Plan Management**
  - Maintenance scheduling and resource planning
  - Execution tracking and progress monitoring
  - Performance measurement and effectiveness analysis

- **🏭 Manufacturing Execution Integration**
  - MES (Manufacturing Execution System) connectivity
  - Production scheduling interfaces
  - Work order management and tracking

- **👥 Stakeholder Management**
  - Reporting hierarchies and organizational structure
  - Communication preferences and protocols
  - Escalation procedures and decision authorities

### 2. What should the ontology be used for?

#### Primary Use Cases:

#### 🤖 AI Agent Autonomous Operations
- **Intelligent Decision Making**: Enable AI agent to autonomously assess risks and recommend actions
- **Continuous Learning**: Allow AI agent to improve predictions based on historical outcomes
- **Escalation Management**: Define when AI agent should involve human experts vs. autonomous action
- **Multi-Criteria Optimization**: Balance OEE components (availability, performance, quality) in decision making

#### 📊 Automated Reporting & Communication
- **Regular Risk Assessment Reports**: Generate scheduled reports for different stakeholder groups
- **Service Plan Communication**: Automatically distribute maintenance plans and updates to relevant teams
- **Executive Dashboard Generation**: Create high-level summaries for management decision making
- **Technical Documentation**: Produce detailed analysis reports for engineering teams
- **Compliance Reporting**: Ensure regulatory and industry standard documentation
- **Performance Tracking Reports**: Monitor effectiveness of implemented service plans

#### 📈 OEE Optimization & Manufacturing Excellence
- **Availability Optimization**: Minimize unplanned downtime from dry pump failures
- **Quality Enhancement**: Prevent wafer scrap caused by vacuum system degradation
- **Performance Monitoring**: Track equipment efficiency and process capability impacts
- **Yield Management**: Connect equipment health to semiconductor yield trends

#### 🔬 Semiconductor Manufacturing Integration
- **Production Schedule Optimization**: Align maintenance activities with fab scheduling constraints
- **Wafer Lot Impact Assessment**: Evaluate potential quality impacts on specific production runs
- **Process Recipe Correlation**: Link equipment health to process parameter stability
- **Fab-Wide Risk Management**: Assess cascade effects of equipment failures on production flow

#### 📅 Service Plan Management & Tracking
- **Automated Service Planning**: Generate optimized maintenance schedules based on risk assessments
- **Resource Allocation**: Coordinate technicians, parts, and tools for maintenance activities
- **Execution Monitoring**: Track completion of planned maintenance activities
- **Effectiveness Analysis**: Measure success of service plans in reducing risks and improving OEE

#### 🔍 Core Analytics & Prediction
- **Predictive Analytics Integration**: Connect historical failure data with real-time manufacturing telemetry
- **Risk Assessment Automation**: Standardize risk evaluation for semiconductor manufacturing context
- **Cost Impact Modeling**: Quantify financial implications of equipment failures on wafer production

### 3. Who will use and maintain the ontology?

#### Primary Users:

#### 🤖 AI Agent (Primary User)
- **Autonomous Risk Assessment**: Continuously evaluate equipment health and failure probabilities
- **Predictive Decision Making**: Automatically generate maintenance recommendations and service plans
- **Report Generation**: Create and distribute regular risk assessments and service plan updates
- **OEE Optimization**: Balance availability, performance, and quality objectives
- **Learning and Adaptation**: Improve predictions and decisions based on outcomes

#### 📊 Report Recipients & Stakeholders
- **Executive Leadership**: Receiving high-level OEE performance summaries and strategic recommendations
- **Operations Managers**: Getting detailed risk assessments and service plan updates
- **Engineering Teams**: Accessing technical analysis reports and equipment health details
- **Maintenance Supervisors**: Receiving work order assignments and resource allocation plans
- **Quality Teams**: Monitoring equipment impacts on yield and process stability
- **Finance/Controlling**: Reviewing maintenance costs and ROI analysis

#### 🔬 Semiconductor Manufacturing Operations
- **Fab Operations Managers**: Monitoring OEE metrics and production efficiency
- **Process Engineers**: Ensuring equipment stability for consistent wafer quality
- **Production Planners**: Integrating maintenance activities with manufacturing schedules
- **Yield Engineers**: Analyzing equipment health impacts on semiconductor yield

#### 🔧 Technical Specialists
- **Equipment Engineers**: Maintaining semiconductor manufacturing tools and support systems
- **Reliability Engineers**: Modeling equipment failure patterns specific to fab environment
- **Maintenance Technicians**: Executing AI agent-recommended maintenance activities
- **Data Scientists**: Improving AI agent algorithms and prediction models

#### Maintainers:
- **Semiconductor Domain Experts** (process engineers, equipment specialists, yield engineers)
- **AI/ML Engineers** (agent behavior, learning algorithms, decision optimization)
- **Manufacturing Systems Integrators** (MES connectivity, data flows, production coordination)
- **Knowledge Engineers** (ontology structure, reasoning rules, domain relationships)
- **Reporting System Administrators** (report templates, distribution lists, delivery mechanisms)

### 4. What types of Questions should your knowledge graph answer?

#### Core Competency Questions:

#### 🤖 AI Agent Decision Support
- Should the AI agent recommend immediate maintenance for pump XYZ given current risk level and production schedule?
- What is the optimal maintenance window that minimizes OEE impact while preventing pump failure?
- Which combination of maintenance actions will maximize OEE improvement per dollar spent?
- Should the AI agent escalate this risk assessment to human experts or proceed autonomously?

#### 📊 Reporting & Communication
- What should be included in this week's executive risk summary report?
- Which stakeholders need to be notified about the elevated risk status of Tool ABC's vacuum pump?
- How should the monthly service plan performance report be structured for the maintenance team?
- What are the key metrics and trends that should be highlighted in the quarterly OEE impact assessment?
- Which technical details should be included in the engineering team's pump failure analysis report?
- How frequently should different stakeholder groups receive risk assessment updates?

#### 📅 Service Plan Reporting & Tracking
- What is the current status of all active service plans and their expected completion dates?
- Which maintenance activities are behind schedule and what is their impact on risk mitigation?
- How effective have recent service interventions been at reducing equipment failure probabilities?
- What resources (technicians, parts, tools) are required for next month's planned maintenance activities?
- Which service plans should be prioritized based on their potential OEE impact?
- How should service plan changes be communicated to affected stakeholders?

#### 📈 OEE Optimization & Manufacturing Impact
- How will a predicted dry pump failure on Tool ABC impact overall fab OEE this week?
- What is the expected wafer scrap cost if maintenance is delayed by 48 hours?
- Which equipment failures would cause the highest production losses during peak manufacturing periods?
- How does vacuum pump degradation correlate with wafer yield trends on specific process tools?

#### 🔬 Semiconductor Manufacturing Integration
- Which wafer lots are at risk if pump XYZ fails during the next production run?
- How should maintenance be scheduled to minimize impact on committed customer deliveries?
- What process recipe adjustments might compensate for declining vacuum pump performance?
- Which tools should be prioritized for maintenance based on their impact on fab throughput?

#### 🚨 Unscheduled Event Prevention
- What is the probability of an unscheduled pump crash disrupting production in the next 30 days?
- Which early warning indicators should trigger immediate preventive action?
- What contingency plans should be activated if multiple pumps show elevated risk simultaneously?
- How effective have past interventions been at preventing unscheduled downtime events?

#### 📋 Report Performance & Optimization
- Which reports are most valuable to different stakeholder groups based on their usage and feedback?
- How should report content and frequency be adjusted based on changing risk levels?
- What metrics should be tracked to measure the effectiveness of risk communication?
- Which stakeholders require real-time alerts vs. scheduled reports for different risk scenarios?

#### 🔍 Performance & Continuous Improvement
- How accurate are the AI agent's predictions compared to actual equipment failures?
- Which decision patterns lead to the best OEE outcomes?
- What maintenance strategies have proven most effective for semiconductor manufacturing environments?
- How should reporting and service planning processes be improved based on stakeholder feedback?

## Key Design Principles

### 🔄 Iterative Nature
> **"There is no one correct way to model a domain. There are always viable alternatives."** - Noy & McGuinness (2000)

This ontology development follows an iterative approach that:
- Continuously improves based on real-world feedback
- Adapts to changing semiconductor manufacturing requirements
- Incorporates lessons learned from AI agent performance
- Evolves with new predictive maintenance methodologies

### 🎯 AI Agent-Centric Design
The ontology is specifically designed to support autonomous AI agent operations while maintaining human oversight and control when needed.

### 📊 OEE-Driven Focus
Every concept and relationship is evaluated for its contribution to Overall Equipment Effectiveness optimization in semiconductor manufacturing.

### 🔗 Integration-Ready
Designed for seamless integration with existing semiconductor manufacturing systems, standards, and workflows.

## Success Metrics

The effectiveness of this ontology will be measured by:

1. **OEE Improvement**: Measurable increases in overall equipment effectiveness
2. **Unscheduled Event Reduction**: Decrease in unexpected equipment failures
3. **AI Agent Performance**: Accuracy of autonomous decisions and recommendations
4. **Stakeholder Satisfaction**: Effectiveness of reporting and communication
5. **Cost Savings**: Reduction in maintenance costs and production losses
6. **Yield Enhancement**: Improvement in semiconductor wafer quality and yield

## Validation Against Source Requirements

Based on the comprehensive analysis of your Notion workspace, this domain analysis incorporates:

### ✅ Technical Foundation
- **Weibull Survival Analysis**: 30-day failure probability calculations for vacuum dry pumps
- **Health Index Computation**: Real-time telemetry-based anomaly detection using unsupervised ML
- **Blended Hazard Procedures**: Fusion of age-driven (Weibull) and condition-driven (RUL) risk factors
- **5-Level Risk Classification**: A-E system with specific probability thresholds and actions

### ✅ Semiconductor Manufacturing Context
- **OEE Optimization**: Focus on availability, performance, and quality improvements
- **Wafer Scrap Prevention**: Quality protection through predictive maintenance
- **Production Integration**: Coordination with fab schedules and manufacturing constraints
- **Unscheduled Event Mitigation**: Specific focus on dry pump crash prevention

### ✅ AI Agent Requirements
- **Autonomous Decision Support**: Knowledge graph foundation for intelligent reasoning
- **Multi-Criteria Optimization**: Balance between multiple OEE factors
- **Continuous Learning**: Adaptation based on historical outcomes and feedback

### ✅ Reporting & Communication
- **Stakeholder-Specific Reports**: Customized content for different organizational levels
- **Regular Risk Assessments**: Scheduled communication of equipment health status
- **Service Plan Tracking**: Transparent maintenance planning and execution monitoring

---

**Next Step**: [Step 2: Consider Reuse](02-reuse-analysis.md) - Evaluate existing ontologies for potential reuse and adaptation

**Status**: ✅ Complete

**Last Updated**: July 18, 2025

**Review Date**: Monthly review recommended during development phase

---

## Document Metadata

| Attribute | Value |
|-----------|-------|
| Document Type | Domain Analysis |
| Methodology Step | 1 of 7 |
| Primary Stakeholder | AI Agent + Semiconductor Manufacturing Teams |
| Domain Scope | Predictive Maintenance + OEE Optimization |
| Review Frequency | Monthly (development), Quarterly (production) |
| Dependencies | Notion workspace analysis, Noy & McGuinness methodology |
