# Step 3: Enumerate Terms - Survival & Condition Monitoring Analysis 📝

> **Methodology Reference**: Noy & McGuinness (2000) - Step 3 of the 7-step iterative ontology development process
> 
> **Focus**: Mathematical foundations for 30-day failure probability calculation using survival analysis and condition monitoring

## Use Case Focus

**Primary Use Case**: Calculate 30-day failure probability for vacuum dry pumps using survival analysis and condition monitoring

**Mathematical Foundation**: Combine historical lifetime analysis (Weibull survival modeling) with real-time telemetry-based health indices

**Target Output**: AI agent generates regular reports showing every dry pump and its corresponding probability of failure in the next 30 days

## Core Mathematical Framework

```
30-Day Failure Probability = f(Survival_Function(t), Health_Index(t), Hazard_Rate(t))

Where:
- Survival_Function(t): Weibull-based historical lifetime model
- Health_Index(t): Real-time telemetry degradation assessment  
- Hazard_Rate(t): Instantaneous failure rate at time t
- t = current pump age + 30 days
```

## Terminology Enumeration

### 📊 **Survival Analysis Terms** (Core - Mathematical Foundation)

#### **Survival Functions** (Custom - Core Innovation)
- **SurvivalFunction**: Mathematical function S(t) = P(T > t) representing probability of surviving beyond time t
- **WeibullSurvivalFunction**: Specific survival function using Weibull distribution
- **HazardFunction**: Instantaneous failure rate h(t) = f(t)/S(t)
- **CumulativeHazardFunction**: Integrated hazard over time H(t) = ∫h(u)du
- **ReliabilityFunction**: Synonym for survival function, R(t) = S(t)

#### **Weibull Distribution Parameters** (Custom)
- **WeibullShape**: Shape parameter β (beta) controlling failure pattern
- **WeibullScale**: Scale parameter η (eta) characteristic lifetime
- **WeibullLocation**: Location parameter γ (gamma) minimum lifetime
- **WeibullParameters**: Collection of shape, scale, and location parameters

#### **Survival Analysis Calculations** (Custom)
- **MedianLifetime**: Time at which 50% of pumps fail (S(t) = 0.5)
- **CharacteristicLifetime**: Scale parameter representing 63.2% failure time
- **MeanTimeToFailure**: Expected lifetime E[T]
- **FailureRate**: Current hazard rate for specific pump
- **SurvivalProbability**: Current S(t) value for specific pump

### 🔍 **Condition Monitoring Terms** (Core - Real-time Assessment)

#### **Health Index Concepts** (Custom - Core Innovation)
- **HealthIndex**: Normalized degradation measure [0,1] where 1=perfect, 0=failed
- **HealthIndexTimeSeries**: Sequence of health index measurements over time
- **HealthTrend**: Rate of health index degradation dHI/dt
- **HealthThreshold**: Critical health index value triggering alerts
- **DegradationRate**: Speed of condition deterioration

#### **Telemetry Data** (Custom)
- **TelemetryMeasurement**: Single sensor reading with timestamp
- **TelemetryTimeSeries**: Sequence of measurements from single sensor
- **SensorReading**: Raw value from monitoring equipment
- **ProcessedMeasurement**: Filtered/normalized sensor data
- **FeatureExtraction**: Derived metrics from raw telemetry

#### **Sensor and Monitoring** (Minimal External - SOSA/SSN concepts)
- **Sensor**: Device that observes pump condition (sosa:Sensor)
- **Observation**: Act of measuring pump parameter (sosa:Observation)
- **ObservableProperty**: Pump characteristic being monitored (sosa:ObservableProperty)
- **Measurement**: Quantified observation result
- **SensorData**: Collection of observations from sensors

### ⚙️ **Dry Pump Specific Terms** (Custom - Domain Focus)

#### **Pump Identification** (Custom)
- **DryPump**: Oil-free vacuum pump for semiconductor manufacturing
- **PumpInstance**: Specific individual pump with unique identifier
- **PumpModel**: Manufacturer model designation
- **PumpFamily**: Group of pumps with similar failure characteristics
- **PumpPopulation**: Statistical cohort for survival analysis

#### **Pump Lifecycle** (Custom)
- **PumpAge**: Current operating time since installation
- **AccumulatedOperatingHours**: Total runtime hours
- **InstallationDate**: Date pump was commissioned
- **LastMaintenanceDate**: Most recent service event
- **ExpectedLifetime**: Projected total operational lifetime

#### **Operating Conditions** (Custom)
- **OperatingTemperature**: Current pump temperature
- **OperatingPressure**: Current vacuum pressure
- **OperatingSpeed**: Current rotor speed (RPM)
- **ProcessLoad**: Current workload intensity
- **DutyCycle**: Operational vs idle time ratio

### 📈 **Blended Hazard Analysis** (Custom - Core Innovation)

#### **Hazard Combination** (Custom)
- **BlendedHazardRate**: Combined hazard from survival and condition monitoring
- **SurvivalHazard**: Hazard rate from historical Weibull analysis
- **ConditionHazard**: Hazard rate from current health index
- **HazardWeighting**: Balance between survival and condition components
- **DynamicHazard**: Time-varying hazard incorporating real-time data

#### **30-Day Prediction** (Custom)
- **ThirtyDayFailureProbability**: P(failure in next 30 days)
- **PredictionWindow**: 30-day forward-looking time period
- **PredictionConfidence**: Uncertainty bounds on probability estimate
- **PredictionMethod**: Algorithm used for probability calculation
- **PredictionTimestamp**: When prediction was calculated

### 🕒 **Temporal Concepts** (Minimal External - Time ontology)

#### **Time Representation** (OWL-Time concepts)
- **TimeInstant**: Specific point in time (time:Instant)
- **TimeInterval**: Duration or period (time:Interval)
- **TimePosition**: Temporal coordinate
- **TimeDuration**: Length of time period

#### **Failure Time Modeling** (Custom)
- **FailureTime**: Random variable T representing time to failure
- **ObservationTime**: Current time of analysis
- **CensoredObservation**: Incomplete failure time data
- **LifetimeData**: Historical failure times for pump population

### 📊 **Statistical Measures** (Custom - Mathematical Support)

#### **Distribution Properties** (Custom)
- **ProbabilityDensityFunction**: f(t) for failure time distribution
- **CumulativeDistributionFunction**: F(t) = P(T ≤ t)
- **Quantile**: Time corresponding to specific survival probability
- **PercentileLifetime**: Lifetime at specific percentage of population

#### **Parameter Estimation** (Custom)
- **MaximumLikelihoodEstimate**: MLE parameter values
- **ConfidenceInterval**: Uncertainty range for parameters
- **GoodnessOfFit**: Statistical measure of model adequacy
- **ParameterUncertainty**: Error bounds on estimated parameters

### 🤖 **AI Agent Calculation Terms** (Custom - Computational)

#### **Model Management** (Custom)
- **SurvivalModel**: Trained Weibull model for pump population
- **HealthModel**: Algorithm for health index calculation
- **BlendingModel**: Method for combining survival and condition data
- **ModelVersion**: Specific iteration of prediction algorithm
- **ModelValidation**: Performance assessment of prediction model

#### **Calculation Process** (Custom)
- **SurvivalCalculation**: Process computing S(t) from Weibull parameters
- **HealthCalculation**: Process computing health index from telemetry
- **HazardCalculation**: Process computing blended hazard rate
- **ProbabilityCalculation**: Process computing 30-day failure probability
- **ReportCalculation**: Process generating final probability report

## Minimal External Ontology Usage

### ✅ **Essential External Terms** (Minimal Usage)

| Concept | Source | Specific Term | Justification |
|---------|--------|---------------|---------------|
| Sensors | SOSA/SSN | Sensor, Observation | Standard sensor modeling |
| Time | OWL-Time | Instant, Interval | Temporal reasoning support |
| Units | QUDT | Hour, Day, Dimensionless | Measurement standardization |
| Math | OMDoc | Function, Parameter | Mathematical expression |

### 🚀 **Core Custom Innovation** (80% of terminology)

| Domain | Innovation | Strategic Value |
|--------|------------|-----------------|
| Survival Analysis | Weibull-based pump lifetime modeling | Predictive accuracy |
| Health Monitoring | Real-time degradation assessment | Early warning |
| Blended Hazard | Combining historical + real-time data | Optimal prediction |
| 30-Day Prediction | Specific maintenance planning horizon | Actionable insights |

## Calculation-Focused Vocabulary

### **Priority 1: Core Calculation Terms** (Week 1)
```
Classes: DryPump, SurvivalFunction, HealthIndex, ThirtyDayFailureProbability
Properties: hasSurvivalFunction, hasHealthIndex, hasFailureProbability
Data: WeibullShape, WeibullScale, HealthIndexValue, ProbabilityValue
```

### **Priority 2: Mathematical Foundation** (Week 2)
```
Classes: WeibullParameters, HazardFunction, BlendedHazardRate
Properties: hasWeibullParameters, hasHazardRate, calculatedAt
Data: ShapeParameter, ScaleParameter, HazardValue, CalculationTimestamp
```

### **Priority 3: Telemetry Integration** (Week 3)
```
Classes: TelemetryMeasurement, SensorReading, HealthTrend
Properties: hasTelemetryData, hasSensorReading, showsTrend
Data: SensorValue, MeasurementTimestamp, TrendDirection
```

## Mathematical Relationship Framework

```
DryPump --hasSurvivalModel--> WeibullSurvivalFunction
DryPump --hasHealthIndex--> HealthIndex
DryPump --currentAge--> PumpAge

WeibullSurvivalFunction --hasParameters--> WeibullParameters
WeibullParameters --shapeParameter--> WeibullShape
WeibullParameters --scaleParameter--> WeibullScale

HealthIndex --calculatedFrom--> TelemetryMeasurement
TelemetryMeasurement --observedBy--> Sensor
TelemetryMeasurement --hasValue--> SensorReading

SurvivalFunction + HealthIndex --blendedInto--> BlendedHazardRate
BlendedHazardRate --generates--> ThirtyDayFailureProbability

ThirtyDayFailureProbability --includedIn--> FailureProbabilityReport
```

## Competency Questions for Validation

### **Survival Analysis Questions**:
1. What is the Weibull survival function for pump P001?
2. What is the current hazard rate for pump P001?
3. What is the expected remaining lifetime for pump P001?
4. How do the Weibull parameters compare across pump families?

### **Condition Monitoring Questions**:
1. What is the current health index for pump P001?
2. How has the health index trended over the past month?
3. Which telemetry measurements contribute to the health index?
4. What is the degradation rate for pump P001?

### **30-Day Prediction Questions**:
1. What is the 30-day failure probability for pump P001?
2. Which pumps have >20% failure probability in next 30 days?
3. How was the 30-day probability calculated?
4. What is the confidence interval for the prediction?

### **Calculation Process Questions**:
1. How are survival and condition monitoring data blended?
2. When was the last prediction calculation performed?
3. Which model version was used for the calculation?
4. What telemetry data influenced the latest prediction?

## Implementation Strategy

### **Phase 1: Survival Foundation** (Current)
- Weibull parameter estimation from historical data
- Basic survival function calculation
- Pump-specific lifetime modeling

### **Phase 2: Condition Integration** (Next)
- Health index calculation from telemetry
- Real-time condition assessment
- Trend analysis and degradation detection

### **Phase 3: Blended Prediction** (Core Goal)
- Combine survival and condition hazards
- 30-day failure probability calculation
- Automated report generation for AI agent

### **Phase 4: Model Refinement** (Future)
- Dynamic parameter updating
- Confidence interval calculation
- Model validation and improvement

## Mathematical Precision Requirements

### **Probability Calculations**
- All failure probabilities: [0.0, 1.0] (dimensionless)
- Survival function values: [0.0, 1.0] (monotonically decreasing)
- Health index values: [0.0, 1.0] (1 = perfect condition)
- Hazard rates: [0.0, ∞) (instantaneous failure rate)

### **Time Representations**
- Pump age: Days since installation
- Operating hours: Cumulative runtime
- Prediction window: Exactly 30 days
- Measurement timestamps: ISO 8601 format

### **Parameter Constraints**
- Weibull shape β > 0 (positive real number)
- Weibull scale η > 0 (positive real number)
- Health degradation rate ≤ 0 (non-positive slope)
- Blending weights: sum to 1.0

---

**Core Innovation**: Mathematics-first terminology for survival analysis and condition monitoring

**Calculation Priority**: 30-day failure probability as primary AI agent output

**Minimal Dependencies**: <20% external ontology usage, >80% custom domain terms

**Implementation Ready**: Focused on computational requirements for knowledge graph

**Next Step**: [Step 4: Define Classes](04-classes-hierarchy.md) - Create mathematical class hierarchy

**Status**: ✅ Complete - Survival & Condition Monitoring Terminology

**Last Updated**: July 18, 2025