# ShrimpGuard AI

AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System.

> **Team:** CSE4104-7C-T04 · **Section:** 7C
>
> **Repository:** [ShrimpGuard-AI](https://github.com/Grb-47/ShrimpGuard-AI)

---

## 1. Project Title

**ShrimpGuard AI**  An AI-powered platform that monitors shrimp farm water quality through ESP32-based sensors, detects environmental risk using expert-validated rules and historical trend analysis, and delivers practical recommendations to farmers in Bengali-language.

## 2. Team Information

| Role | Name | Student ID | GitHub |
|---|---|---|---|
| Team Leader | Shefa Hassan Shefa | 11230121166 | [shefa-dev](https://github.com/shefa-dev) |
| Team Member | Gourab Mondal | 11230321547 | [Grb-47](https://github.com/Grb-47) |
| Team Member | Shahreia Alam | 11230321561 | [shahreia](https://github.com/shahreia) |

- **Official Team Name:** CSE4104-7C-T04
- **Section:** 7C
- **GitHub Owner:** Grb-47
- **Repository:** [ShrimpGuard-AI](https://github.com/Grb-47/ShrimpGuard-AI)

## 3. Project Overview

Shrimp farming is highly sensitive to changes in water quality. Unsafe pH, dissolved oxygen, temperature, salinity, or ammonia levels can cause stress, disease, and mass mortality. Many farmers rely on manual testing and delayed expert advice, which makes early intervention difficult in situation.

ShrimpGuard AI connects low-cost sensors to an **ESP32**, sends readings over **Bluetooth** to a **Flutter mobile application**, stores them through a **Node.js backend** in **PostgreSQL**, and analyzes risk through a separate **Python FastAPI** service. A **React.js** dashboard supports wider monitoring. **Google Gemini API** converts validated risk results into clear Bengali explanations and recommendations.

The project is being built as a three-member academic project for CSE4104.

## 4. Problem Statement

Shrimp farming is an important part of Bangladesh's aquaculture industry, but maintaining proper water quality remains a major challenge. Parameters such as temperature, pH, dissolved oxygen, ammonia, and salinity directly affect shrimp health, growth, and production. However, many farmers still rely on manual testing and occasional measurements, making it difficult to identify sudden environmental changes and potential risks early.
Limited access to affordable monitoring technology, difficulties interpreting technical readings, and a lack of timely expert guidance further complicate farm management. Additionally, the absence of an integrated platform for real-time monitoring, historical data analysis, and localized recommendations makes informed decision-making challenging.
To address these issues, the proposed ShrimpGuard AI System combines ESP32-based IoT sensors, Bluetooth connectivity, PostgreSQL database management, and expert-validated rule-based risk analysis. By integrating the Gemini API, the system will also provide understandable Bengali explanations and actionable recommendations, helping farmers monitor pond conditions and make timely, data-driven decisions.

## 5. Objectives

1. Continuously collect water-quality data using ESP32-connected sensors.
2. Transfer readings from the device to the mobile application over Bluetooth.
3. Store multiple farms, ponds, devices, and historical readings in PostgreSQL.
4. Detect abnormal patterns and classify environmental risk using expert-validated rules.
5. Generate Bengali explanations and actionable recommendations using Gemini API, grounded in the risk analysis results.
6. Provide farmers with dashboards, charts, history, and notifications.
7. Build a foundation that can later support a custom machine-learning model.
8. Enable farmers to make informed decisions through real-time monitoring, early risk detection, and data-driven farm management.

## 6. Core Features

- Farmer authentication and profile management
- Multiple farm and multiple pond management
- ESP32 device connection over Bluetooth
- Water quality monitoring: pH, dissolved oxygen, temperature, salinity
- Manual ammonia test-kit entry
- Historical sensor and manual-test records
- AI-assisted risk analysis and risk reports
- Bengali recommendations generated from validated risk results
- Charts and trend views
- Notifications for risky conditions
- React dashboard for monitoring and administration
- Optional/future turbidity sensor support

## 7. Technology part

| Layer | Technologies |
|---|---|
| Mobile | Flutter |
| Web | React.js |
| Backend API | Node.js |
| Risk analysis | Python, FastAPI |
| Database | PostgreSQL |
| AI | Google Gemini API, future custom ML model |
| Data/ML | Pandas, NumPy, Scikit-learn (future ML development) |
| Hardware | ESP32, pH sensor, dissolved oxygen sensor, temperature sensor, salinity sensor, manual ammonia test kit, optional/future turbidity sensor |
| Connectivity | Bluetooth |
| Hosting | Versal/Hostinger |

## 8. System Architecture

```text
pH / DO / Temperature / Salinity sensors
                |
                v
             ESP32
                |
          Bluetooth
                |
                v
      Flutter Farmer Mobile App
                |
                v
        Node.js Backend API  <---- React.js Dashboard
                |      |
                |      +----> PostgreSQL (users, farms, ponds,
                |                  devices, sensors, readings,
                |                  risk reports, notifications)
                |
                v
    Python FastAPI Risk Analysis Service
      - Expert-validated rules
      - Historical trend analysis
      - Abnormal pattern detection
      - Environmental risk classification
      - Future ML model integration
                |
                v
         Google Gemini API
      - Bengali explanations
      - Farmer-friendly recommendations
```

**Responsibility boundaries**

| Service | Responsibilities |
|---|---|
| Node.js | Authentication, farmer management, farm and pond management, sensor data storage, historical data retrieval, API management, risk report management, notifications |
| Python FastAPI | Rule evaluation, trend analysis, anomaly detection, risk classification, future ML integration |
| Gemini API | Bengali explanations and recommendations based on risk results. It is **not** the sole risk assessment engine. |

Detailed diagrams: [`docs/architecture/SYSTEM_ARCHITECTURE.md`](docs/architecture/SYSTEM_ARCHITECTURE.md)

## 9. Project Structure

```text
ShrimpGuard AI/
├── app/flutter_farmer_app/       Flutter farmer mobile application
├── backend/node_api/             Node.js backend API
├── risk-analysis/python_service/ FastAPI risk analysis service
├── hardware/                     ESP32 firmware, sensors, calibration, docs
├── web/react_dashboard/          React.js monitoring dashboard
├── database/                     PostgreSQL schema and migrations
├── docs/                         Architecture, proposal, team, planning
├── .gitignore
└── README.md
```

Each service contains a foundational skeleton. They are intentionally minimal and are not yet production-ready.

## 10. Database Overview

The database is designed around one farmer owning many farms, each farm containing many ponds, and each pond producing historical readings.

Core tables:

- `users`
- `farms`
- `ponds`
- `devices`
- `sensors`
- `sensor_readings`
- `manual_test_readings`
- `risk_reports` (stores `explanation_bn` and `recommendations_bn`)
- `notifications`

Relationship: **User → Farms → Ponds → Devices/Sensors → Historical Readings → Risk Reports/Notifications**.

Schema: [`database/schema/001_initial_schema.sql`](database/schema/001_initial_schema.sql)
Design and ER diagram: [`docs/architecture/DATABASE_DESIGN.md`](docs/architecture/DATABASE_DESIGN.md)

## 11. Hardware Component

| Component | Role | Details |
|---|---|---|
| ESP32 | Main controller and Bluetooth gateway | Model and board revision: To Be Confirmed |
| pH sensor | Water acidity/alkalinity | Model, interface, and specs: To Be Confirmed |
| Dissolved oxygen sensor | Oxygen available to shrimp | Model, interface, and specs: To Be Confirmed |
| Temperature sensor | Water temperature | Model, interface, and specs: To Be Confirmed |
| Salinity sensor | Salt concentration | Model, interface, and specs: To Be Confirmed |
| Manual ammonia test kit | Farmer-entered ammonia measurement | Kit brand and range: To Be Confirmed |
| Turbidity sensor (optional/future) | Water clarity | Model and specs: To Be Confirmed |

Documentation:

- [`hardware/documentation/HARDWARE_OVERVIEW.md`](hardware/documentation/HARDWARE_OVERVIEW.md)
- [`hardware/esp32/ESP32_SETUP.md`](hardware/esp32/ESP32_SETUP.md)
- [`hardware/sensors/PH_SENSOR.md`](hardware/sensors/PH_SENSOR.md)
- [`hardware/sensors/DO_SENSOR.md`](hardware/sensors/DO_SENSOR.md)
- [`hardware/sensors/TEMPERATURE_SENSOR.md`](hardware/sensors/TEMPERATURE_SENSOR.md)
- [`hardware/sensors/SALINITY_SENSOR.md`](hardware/sensors/SALINITY_SENSOR.md)
- [`hardware/calibration/CALIBRATION_GUIDE.md`](hardware/calibration/CALIBRATION_GUIDE.md)

> Sensor models, pin assignments, electrical characteristics, and exact calibration solutions are **not invented**. Unknown values are marked **To Be Confirmed (TBC)**.

## 12. AI Integration

The AI layer has two distinct parts:

1. **Risk analysis (Python FastAPI + future ML)** — deterministic, expert-validated rules, historical trend analysis, abnormal pattern detection, and environmental risk classification. This is the decision layer.
2. **Explanation layer (Gemini API)** — receives the structured risk result and generates Bengali explanations and recommendations. Gemini does not replace the rule engine.

The current codebase contains a safe stub: when `GEMINI_API_KEY` is not configured, the explanation is omitted rather than making an external call. Rule-based results are still returned. No API keys are committed to the repository.

## 13. Development Roadmap

| Phase | Focus | Status |
|---|---|---|
| Week 01 | Requirements, stack, architecture, hardware planning | Completed |
| Week 02 | Project foundation, proposal, team info, database design, service skeletons, hardware docs | In progress |
| Next | Node.js API implementation, authentication, farm/pond CRUD | Planned |
| Next | Flutter app integration and Bluetooth data flow | Planned |
| Next | FastAPI rule engine and trend analysis | Planned |
| Next | Gemini Bengali recommendation integration | Planned |
| Next | React dashboard and notifications | Planned |
| Later | Historical analytics, custom ML model, turbidity support | Future |

Detailed plan: [`docs/planning/INITIAL_PROJECT_PLAN.md`](docs/planning/INITIAL_PROJECT_PLAN.md)

## 14. Future Scope

The ShrimpGuard AI System has significant opportunities for future enhancement and expansion. Although the initial version focuses on intelligent shrimp farm management, water quality monitoring, and AI-based risk analysis, several additional features can be introduced to improve accuracy, accessibility, automation, and overall system performance.

The potential future developments include:
Advanced Machine Learning Models: Develop and integrate custom-trained machine learning models for more accurate shrimp disease risk prediction, water quality forecasting, and early anomaly detection using historical and real-time farm data.
Additional Water Quality Sensors: Integrate advanced sensors, including turbidity sensors and other essential water quality monitoring devices, to collect more comprehensive environmental data and improve monitoring accuracy.
Offline-First Mobile Application: Introduce offline functionality that allows farmers to access essential features, record farm information, and view previously stored data without an internet connection. The application will automatically synchronize data when connectivity is restored.
Real-Time Alert and Notification System: Implement SMS and push notification services to immediately inform farmers about critical water quality conditions, potential risks, unusual environmental changes, and important farm management activities.
Multilingual Support: Expand the system's language capabilities beyond Bengali to support additional languages, making the platform more accessible to shrimp farmers from different linguistic backgrounds and regions.
Veterinary and Agricultural Expert Collaboration: Introduce dedicated communication and collaboration features that allow farmers to connect with veterinary professionals, aquaculture specialists, and agricultural extension specialists for expert guidance and technical assistance.
Advanced Farm Analytics and Benchmarking: Develop comprehensive analytical dashboards to visualize farm performance, compare historical records, monitor production trends, and benchmark farm-level performance against relevant industry indicators.
Automated Device Monitoring: Introduce sensor performance tracking and device health monitoring to identify technical issues, maintain measurement accuracy, and reduce unexpected equipment failures.
Cloud-Based Deployment and System Observability: Migrate the platform toward scalable cloud infrastructure to improve data accessibility, system availability, and performance. Future versions may also include centralized logging, performance monitoring, error tracking, and audit trails to ensure better system transparency and reliability.
These future enhancements will help transform ShrimpGuard AI into a more intelligent, scalable, and comprehensive shrimp aquaculture management platform. The long-term vision is to support data-driven farming decisions, reduce operational risks, improve farm productivity, and contribute to the sustainable development of the shrimp aquaculture industry.

---

## 15. Week 03 Documentation

Week 03 defines the software requirements and system diagrams for ShrimpGuard AI.

| Document | Description |
|---|---|
| [Software Requirements Specification](docs/srs/CSE4104-7C-T04_SRS.md) | Functional and non-functional requirements, user roles, and detailed use cases |
| [Use Case Diagram](docs/srs/CSE4104-7C-T04_UseCaseDiagram.md) | Actor and use case overview |
| [ER Diagram](docs/srs/CSE4104-7C-T04_ERDiagram.md) | Entity relationship diagram from the Week 02 database design |
| [System Architecture Diagram](docs/srs/CSE4104-7C-T04_ArchitectureDiagram.md) | Week 02 architecture, data flow, and deployment diagrams |

---

## 16. Week 04 — System Design & Software Architecture

Week 04 defines the system design deliverables. All APIs and workflows below are **planned**; current services are foundation skeletons.

| Document | Description |
|---|---|
| [Combined System Design](docs/system-design/CSE4104-7C-T04_SystemDesign.md) | Self-contained master document for PDF export (`CSE4104-7C-T04_SystemDesign.pdf`) |
| [Activity Diagram](docs/system-design/CSE4104-7C-T04_ActivityDiagram.md) | UML activity diagram for sensor reading collection and environmental risk analysis |
| [API Design](docs/system-design/CSE4104-7C-T04_APIDesign.md) | Planned public `/api/v1/` endpoints and internal FastAPI service boundary |
| [AI Workflow](docs/system-design/CSE4104-7C-T04_AIWorkflow.md) | Rule-first risk classification, Gemini Bengali text layer, and fallback handling |

Reviewed diagrams reused/updated for Week 04:

- [System Architecture Diagram](docs/srs/CSE4104-7C-T04_ArchitectureDiagram.md) — reviewed, reused without changes.
- [ER Diagram](docs/srs/CSE4104-7C-T04_ERDiagram.md) — optional FK notation aligned with the SQL schema.
- [Updated Use Case Diagram](docs/srs/CSE4104-7C-T04_UseCaseDiagram.md) — added System Admin associations for UC-08 and UC-11.

---

### Academic Context

This repository is the initial foundation for the CSE4104 Week 02 assignment of team **CSE4104-7C-T04**. It is prepared for future GitHub upload but is not yet connected to a remote repository.
