# ShrimpGuard AI — Project Proposal

**Course:** CSE4104
**Team:** CSE4104-7C-T04
**Section:** 7C
**Project Title:** ShrimpGuard AI — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System

| Role | Name | Student ID | GitHub |
|---|---|---|---|
| Team Leader | Shefa Hassan Shefa | 11230121166 | shefa-dev |
| Team Member | Gourab Mondal | 11230321547 | Grb-47 |
| Team Member | Shahreia Alam | 11230321561 | shahreia |

---

## 1. Project Title

**ShrimpGuard AI** — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System.

## 2. Problem Statement

Shrimp farming depends on stable water quality. Small changes in pH, dissolved oxygen, temperature, salinity, or ammonia can stress shrimp, increase disease risk, and lead to serious financial loss. In many farms, water conditions are checked manually and infrequently. Results may be recorded on paper, interpreted without context, or shared with an expert only after visible damage has occurred.

The core problems are:

1. **Limited continuous monitoring.** Manual tests cannot show what happens between visits.
2. **Delayed interpretation.** Farmers may not know whether a reading is dangerous or what to do next.
3. **Fragmented history.** Without stored historical data, trends and repeated problems are hard to detect.
4. **Accessibility gap.** Technical water-quality information is often not available in clear Bengali.
5. **Weak early warning.** Risk is noticed late, when treatment is more difficult and costly.

ShrimpGuard AI addresses these problems by combining low-cost sensors, an ESP32 device, a mobile application, a structured database, rule-based risk analysis, and Bengali explanations generated from validated results.

## 3. Objectives

1. Build a low-cost ESP32-based device that reads pH, dissolved oxygen, temperature, and salinity.
2. Transfer readings from the device to a Flutter mobile application over Bluetooth.
3. Store multiple farmers, farms, ponds, devices, sensors, and historical readings in PostgreSQL.
4. Provide a Node.js backend for authentication, farm and pond management, reading storage, history retrieval, reports, and notifications.
5. Build a separate Python FastAPI service that applies expert-validated rules, historical trend analysis, abnormal pattern detection, and environmental risk classification.
6. Use Google Gemini API to generate Bengali explanations and recommendations from the validated risk result, without making Gemini the sole risk engine.
7. Support manual ammonia test-kit entry alongside sensor data.
8. Provide a React.js dashboard for monitoring and administration.
9. Establish a foundation that can later support a custom machine-learning model and additional sensors such as turbidity.

## 4. Proposed Features

### Farmer mobile application (Flutter)

- Farmer authentication and profile
- Dashboard with current pond status
- Multiple farm management
- Multiple pond management
- ESP32 device connection over Bluetooth
- Water-quality readings: pH, dissolved oxygen, temperature, salinity
- Manual ammonia test-kit entry
- AI risk analysis view
- Bengali recommendations
- Historical data and charts
- Notifications
- Settings

### Backend (Node.js)

- Authentication and farmer management
- Farm and pond management
- Device and sensor registration
- Sensor reading and manual reading storage
- Historical data retrieval
- Risk report and recommendation management
- Notification management
- API layer for mobile and web clients

### Risk analysis (Python FastAPI)

- Expert-validated water-quality rules
- Historical trend analysis
- Abnormal pattern detection
- Environmental risk classification
- Structured risk factors for reporting
- Future custom ML model integration

### AI explanation (Gemini API)

- Bengali explanations of validated risk results
- Farmer-friendly recommendations
- Clear separation between risk decision and text generation

### Web dashboard (React.js)

- Farm, pond, device, and risk overview
- Historical monitoring views
- Report and notification review

### Hardware

- ESP32 controller
- pH sensor
- Dissolved oxygen sensor
- Temperature sensor
- Salinity sensor
- Manual ammonia test kit
- Optional/future turbidity sensor
- Calibration records and sensor documentation

## 5. Technology Stack

| Layer | Technology |
|---|---|
| Mobile application | Flutter |
| Web dashboard | React.js |
| Backend API | Node.js |
| Risk analysis service | Python, FastAPI |
| Database | PostgreSQL |
| AI explanation | Google Gemini API |
| Data processing / future ML | Pandas, NumPy, Scikit-learn |
| Microcontroller | ESP32 |
| Sensors | pH, dissolved oxygen, temperature, salinity, optional/future turbidity |
| Manual input | Ammonia test kit |
| Device connectivity | Bluetooth |
| Deployment | Cloud server |

## 6. Expected Outcome

At the end of the project, the team expects to deliver:

1. A working ESP32-based water-quality monitoring device that can read the confirmed sensors and send readings to the mobile application over Bluetooth.
2. A Flutter farmer application that supports farm and pond management, water testing, manual ammonia entry, history, charts, and Bengali recommendations.
3. A Node.js backend connected to PostgreSQL that securely stores users, farms, ponds, devices, readings, risk reports, recommendations, and notifications.
4. A Python FastAPI risk service that applies expert-validated rules and historical analysis, with a clear path for future machine learning.
5. A Gemini-powered Bengali explanation layer that is grounded in validated risk results.
6. A React.js dashboard for monitoring and administration.
7. Complete documentation for architecture, database design, hardware, calibration, and project planning.

The expected impact is earlier risk detection, better record keeping, more accessible guidance for farmers, and a maintainable technical foundation for future expansion.
