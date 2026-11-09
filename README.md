# ShrimpGuard AI

AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System.

> **Team:** CSE4104-7C-T04 · **Section:** 7C
>
> **Repository:** [ShrimpGuard-AI](https://github.com/Grb-47/ShrimpGuard-AI)

---

## 1. Project Title

**ShrimpGuard AI** — An AI-powered platform that monitors shrimp farm water quality through ESP32-based sensors, detects environmental risk using expert-validated rules and historical trend analysis, and delivers practical recommendations to farmers in Bengali.

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

Shrimp farming is highly sensitive to changes in water quality. Unsafe pH, dissolved oxygen, temperature, salinity, or ammonia levels can cause stress, disease, and mass mortality. Many farmers rely on manual testing and delayed expert advice, which makes early intervention difficult.

ShrimpGuard AI connects low-cost sensors to an **ESP32**, sends readings over **Bluetooth** to a **Flutter mobile application**, stores them through a **Node.js backend** in **PostgreSQL**, and analyzes risk through a separate **Python FastAPI** service. A **React.js** dashboard supports wider monitoring. **Google Gemini API** converts validated risk results into clear Bengali explanations and recommendations.

The project is being built as a three-member academic project for CSE4104.

## 4. Problem Statement

Shrimp farmers often lack affordable, continuous, and localized water-quality monitoring. Manual testing is infrequent, sensor results are difficult to interpret, and expert support may not be available when a pond is deteriorating. Existing tools rarely combine device data, historical trends, validated environmental rules, and farmer-friendly Bengali guidance in one system.

## 5. Objectives

1. Continuously collect water-quality data using ESP32-connected sensors.
2. Transfer readings from the device to the mobile application over Bluetooth.
3. Store multiple farms, ponds, devices, and historical readings in PostgreSQL.
4. Detect abnormal patterns and classify environmental risk using expert-validated rules.
5. Generate Bengali explanations and actionable recommendations using Gemini API, grounded in the risk analysis results.
6. Provide farmers with dashboards, charts, history, and notifications.
7. Build a foundation that can later support a custom machine-learning model.

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
- Calibration records per sensor
- React dashboard for monitoring and administration
- Optional/future turbidity sensor support

## 7. Technology Stack

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
- `risk_reports`
- `recommendations`
- `notifications`
- `calibration_records`

Relationship: **User → Farms → Ponds → Devices/Sensors → Historical Readings → Risk Reports → Recommendations/Notifications**.

Schema: [`database/schema/001_initial_schema.sql`](database/schema/001_initial_schema.sql)
Design and ER diagram: [`docs/architecture/DATABASE_DESIGN.md`](docs/architecture/DATABASE_DESIGN.md)

## 11. Hardware Components

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

- Trained custom ML models for risk prediction and anomaly detection
- Turbidity and additional water-quality sensors
- Offline-first mobile operation with background synchronization
- SMS or push alerts for critical conditions
- Multi-language support beyond Bengali
- Veterinary/extension-officer collaboration workflows
- Farm-level analytics and benchmarking
- Automated calibration reminders and device health monitoring
- Cloud deployment with observability and audit trails

---

### Academic Context

This repository is the initial foundation for the CSE4104 Week 02 assignment of team **CSE4104-7C-T04**. It is prepared for future GitHub upload but is not yet connected to a remote repository.
