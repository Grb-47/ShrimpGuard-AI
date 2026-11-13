# ShrimpGuard AI — Software Requirements Specification (SRS)

**Course:** CSE4104
**Assignment:** Week 03
**Official Team Name:** CSE4104-7C-T04
**Section:** 7C
**Project Title:** ShrimpGuard AI — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System
**Document Version:** 1.0
**Document Status:** Week 03 deliverable
**Date:** 14 November 2026

| Role | Name | Student ID | GitHub |
|---|---|---|---|
| Team Leader | Shefa Hassan Shefa | 11230121166 | shefa-dev |
| Team Member | Gourab Mondal | 11230321547 | Grb-47 |
| Team Member | Shahreia Alam | 11230321561 | shahreia |

---

## Document Control

| Version | Date | Description | Prepared By |
|---|---|---|---|
| 1.0 | 14 November 2026 | Initial Week 03 SRS for ShrimpGuard AI | CSE4104-7C-T04 |

### Source References

This SRS is based on the following verified documents in the existing workspace:

1. `README.md`
2. `docs/proposal/CSE4104-7C-T04_Proposal.md`
3. `docs/architecture/SYSTEM_ARCHITECTURE.md`
4. `docs/architecture/DATABASE_DESIGN.md`
5. `docs/planning/INITIAL_PROJECT_PLAN.md`
6. `docs/team/CSE4104-7C-T04_TeamInfo.md`
7. `hardware/documentation/HARDWARE_OVERVIEW.md` and the related hardware documents

> **Reference limitation:** No Week 01 project documentation or PDF was found in the workspace or Git history. This SRS does not claim to have inspected a Week 01 document. It uses only the verified Week 02 project documentation and the confirmed project context supplied for Week 03.

### Requirement Status Convention

| Status | Meaning |
|---|---|
| **Confirmed** | The requirement is part of the established ShrimpGuard AI scope and should be implemented in the core system. |
| **Confirmed — supporting** | The requirement is supported by the existing database or architecture, but its user-facing workflow may still need team confirmation. |
| **Future** | The item is explicitly outside the current implementation scope and is not presented as an implemented requirement. |

---

# Section 1: Introduction

## 1.1 Project Title

**ShrimpGuard AI — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System**

## 1.2 Project Overview

Shrimp farming is highly sensitive to changes in water quality. Unsafe pH, dissolved oxygen, temperature, salinity, or ammonia levels can stress shrimp, increase environmental risk, and lead to serious financial loss. Many farmers rely on manual testing and delayed expert advice, which makes early intervention difficult.

ShrimpGuard AI combines low-cost water-quality sensors, an ESP32 controller, a Flutter mobile application, a Node.js backend, a Python FastAPI risk-analysis service, PostgreSQL, a React.js dashboard, and the Google Gemini API. Sensor readings travel from the ESP32 to the Flutter application over Bluetooth. The mobile application uploads readings to the Node.js backend, which stores them in PostgreSQL. The Python FastAPI service evaluates expert-validated rules, historical trends, and abnormal patterns to classify environmental risk. Gemini then explains the validated result in simple Bengali and provides farmer-friendly recommendation text. Gemini does not independently determine or override the risk classification.

The project is being developed by a three-member CSE team as an academic project for CSE4104.

## 1.3 Problem Statement

Shrimp farmers often lack affordable, continuous, and localized water-quality monitoring. Manual testing is infrequent, sensor results may be difficult to interpret, and expert support may not be available when a pond is deteriorating. Existing tools rarely combine device data, historical trends, validated environmental rules, and farmer-friendly Bengali guidance in one system.

The core problems addressed by ShrimpGuard AI are:

1. Limited continuous monitoring between manual farm visits.
2. Delayed interpretation of water-quality readings.
3. Fragmented or missing historical records.
4. Technical information that is not accessible in clear Bengali.
5. Late detection of environmental risk, when treatment is more difficult and costly.

## 1.4 Objectives

The objectives of ShrimpGuard AI are:

1. Collect water-quality data using ESP32-connected pH, dissolved oxygen, temperature, and salinity sensors.
2. Transfer readings from the device to the Flutter mobile application over Bluetooth.
3. Store multiple farmers, farms, ponds, devices, sensors, and historical readings in PostgreSQL.
4. Provide a Node.js backend for authentication, farmer and farm management, pond management, sensor data management, historical retrieval, risk report management, notifications, and API management.
5. Provide a separate Python FastAPI service for water-quality analysis, expert-validated rule-based risk classification, historical trend analysis, abnormal pattern detection, and environmental risk assessment.
6. Use the Google Gemini API to generate understandable Bengali explanations and farmer-friendly recommendations based on validated risk analysis results.
7. Support manual ammonia test-kit entry alongside sensor readings.
8. Provide a React.js dashboard for monitoring and administration.
9. Establish a foundation that can later support a custom machine-learning model and optional sensors such as turbidity.

## 1.5 Scope of the Project

### 1.5.1 What the System Will Do

ShrimpGuard AI will:

1. Allow farmers to register, authenticate, and manage their profiles.
2. Allow farmers to manage multiple farms and multiple ponds under those farms.
3. Register ESP32 devices and associate them with ponds.
4. Connect the Flutter application to an ESP32 device over Bluetooth.
5. Collect and display pH, dissolved oxygen, temperature, and salinity readings from the device.
6. Allow farmers to enter manual ammonia test-kit results for a selected pond.
7. Store sensor readings and manual readings in PostgreSQL with timestamps and pond context.
8. Retrieve and display historical readings, charts, and trend views.
9. Request environmental risk analysis for a pond.
10. Classify environmental risk using expert-validated rules, historical trend analysis, and abnormal pattern detection in the Python FastAPI service.
11. Store and display risk reports containing the risk level, score, summary, factors, analysis engine, and generation time.
12. Generate Bengali explanations and farmer-friendly recommendation text from validated risk results using the Gemini API.
13. Display recommendations and in-app notifications for risky conditions.
14. Provide a React.js dashboard for authenticated monitoring and administration.
15. Enforce role-based access so farmers can access only their own records and administrators can access dashboard monitoring views supported by the project.

### 1.5.2 What the System Will Not Do

ShrimpGuard AI will not:

1. Diagnose shrimp diseases directly from water-quality readings. The system assesses **environmental risk**; it does not provide a medical or veterinary diagnosis.
2. Replace a qualified aquaculture expert, veterinarian, or extension officer.
3. Control aerators, pumps, feeders, or other pond equipment automatically.
4. Provide automatic chemical dosing instructions or prescribe exact chemical treatments.
5. Let Gemini independently determine, change, or override the validated risk classification.
6. Treat turbidity monitoring as a current implementation requirement. Turbidity is optional/future.
7. Treat a custom machine-learning model as a current implementation requirement. The future ML model is planned but not part of the current core.
8. Provide push or SMS alert delivery as a current requirement. In-app notifications are the current notification channel; push and SMS remain future scope.
9. Provide offline-first synchronization as a current requirement. Offline queueing is a future enhancement.
10. Provide multi-language support beyond Bengali as a current requirement.
11. Provide financial, marketplace, accounting, or farm-commerce functionality.
12. Replace manual sensor calibration or guarantee sensor accuracy without proper calibration and maintenance.

### 1.5.3 Intended Users

| User | Description |
|---|---|
| **Shrimp Farmer** | The primary user who owns farms and ponds, connects the ESP32 device, collects readings, enters manual ammonia results, requests risk analysis, and views Bengali explanations, recommendations, and notifications. |
| **System Admin** | An administrative user supported by the existing `admin` role and React dashboard scope. The admin monitors farms, ponds, devices, readings, risk reports, and notifications through the dashboard. Additional administrative permissions are not assumed unless confirmed by the team. |

No other user role is introduced in this SRS. The `Officer / Farm Owner` label that appears in the Week 02 architecture context diagram is not established as a separate role in the current role model.

### 1.5.4 Major System Components

| Component | Technology | Primary Responsibility |
|---|---|---|
| Sensor layer | pH, dissolved oxygen, temperature, and salinity sensors | Measure physical and chemical water parameters |
| Edge controller | ESP32 | Read sensors, package readings, and expose data over Bluetooth |
| Mobile application | Flutter | Farmer authentication, farm and pond management, Bluetooth connection, reading collection, manual ammonia entry, history, risk reports, recommendations, and notifications |
| Web dashboard | React.js | Monitoring and administration views for farms, ponds, devices, readings, risk reports, and notifications |
| Backend API | Node.js | Authentication, farmer and farm management, pond management, sensor data management, historical retrieval, risk report management, notification management, and API management |
| Risk analysis service | Python, FastAPI | Water-quality analysis, expert-validated rule-based risk classification, historical trend analysis, abnormal pattern detection, and environmental risk assessment |
| Database | PostgreSQL | Persistent storage for users, farms, ponds, devices, sensors, readings, manual readings, risk reports, recommendations, notifications, and calibration records |
| Explanation layer | Google Gemini API | Generate Bengali explanations and farmer-friendly recommendation text from validated risk results |
| Connectivity | Bluetooth | Transfer readings from the ESP32 to the Flutter application |
| Deployment | Cloud server | Host the Node.js service, FastAPI service, PostgreSQL, and React build |

### 1.5.5 Environmental Risk Monitoring Purpose

The purpose of environmental risk monitoring in ShrimpGuard AI is to help farmers detect potentially harmful water-quality conditions earlier and understand what the validated analysis means in simple Bengali. The system monitors pH, dissolved oxygen, temperature, salinity, and manually entered ammonia values. It compares readings with expert-validated thresholds, examines historical trends, and flags abnormal patterns. The output is an environmental risk report, not a disease diagnosis. The report is intended to support timely verification, preventive action, and consultation with a local aquaculture expert when needed.

## 1.6 Definitions and Abbreviations

| Term | Definition |
|---|---|
| **AI** | Artificial Intelligence |
| **API** | Application Programming Interface |
| **DO** | Dissolved Oxygen |
| **ESP32** | A microcontroller board used as the device controller and Bluetooth gateway |
| **FastAPI** | The Python web framework used for the risk-analysis service |
| **FR** | Functional Requirement |
| **Gemini** | Google Gemini API used for Bengali explanation and recommendation text |
| **ML** | Machine Learning |
| **NFR** | Non-Functional Requirement |
| **PostgreSQL** | The relational database used by the system |
| **Risk classification** | The rule-based determination of environmental risk level by the Python FastAPI service |
| **SRS** | Software Requirements Specification |
| **TBC** | To Be Confirmed |

## 1.7 References

1. ShrimpGuard AI README, repository root.
2. ShrimpGuard AI Project Proposal, `docs/proposal/CSE4104-7C-T04_Proposal.md`.
3. ShrimpGuard AI System Architecture, `docs/architecture/SYSTEM_ARCHITECTURE.md`.
4. ShrimpGuard AI Database Design, `docs/architecture/DATABASE_DESIGN.md`.
5. ShrimpGuard AI Initial Project Plan, `docs/planning/INITIAL_PROJECT_PLAN.md`.
6. ShrimpGuard AI Team Information, `docs/team/CSE4104-7C-T04_TeamInfo.md`.
7. ShrimpGuard AI Hardware Overview, `hardware/documentation/HARDWARE_OVERVIEW.md`.

---

# Section 2: Functional Requirements

The functional requirements below define the confirmed capabilities of ShrimpGuard AI. Each requirement has a unique identifier, a single testable capability, and an identified responsible actor or system component.

## 2.1 Functional Requirement List

| ID | Functional Requirement | Responsible Actor / Component | Priority | Status |
|---|---|---|---|---|
| **FR-01** | The Flutter application shall allow a new farmer to register with full name, email, optional phone number, and password, and the Node.js service shall validate the input and persist the account with a hashed password. | Shrimp Farmer; Flutter application; Node.js service; PostgreSQL | Must | Confirmed |
| **FR-02** | The Flutter application shall allow a registered farmer or administrator to authenticate with email and password, and the Node.js service shall issue a signed token or session for authorized access. | Shrimp Farmer; System Admin; Flutter application; Node.js service | Must | Confirmed |
| **FR-03** | The Flutter application shall allow an authenticated farmer to view and update profile fields such as full name and phone number, and the Node.js service shall persist the updated profile. | Shrimp Farmer; Flutter application; Node.js service | Must | Confirmed |
| **FR-04** | The Flutter application shall allow an authenticated farmer to create, view, update, and delete farms that the farmer owns, and the Node.js service shall enforce farm ownership on every operation. | Shrimp Farmer; Flutter application; Node.js service | Must | Confirmed |
| **FR-05** | The Flutter application shall allow an authenticated farmer to create, view, update, and archive ponds under the farmer's own farms, and the Node.js service shall enforce farm ownership on every pond operation. | Shrimp Farmer; Flutter application; Node.js service | Must | Confirmed |
| **FR-06** | The Flutter application shall allow an authenticated farmer to register an ESP32 device with a device serial and name and assign it to one of the farmer's ponds, and the Node.js service shall persist the device-to-pond association. | Shrimp Farmer; Flutter application; Node.js service; PostgreSQL | Must | Confirmed |
| **FR-07** | The Flutter application shall discover and connect to a compatible ESP32 device over Bluetooth after the farmer selects the device. | Shrimp Farmer; Flutter application; ESP32 | Must | Confirmed |
| **FR-08** | The Flutter application shall receive a structured reading payload from the connected ESP32 containing pH, dissolved oxygen, temperature, and salinity values with their units. | Flutter application; ESP32; sensor layer | Must | Confirmed |
| **FR-09** | The Flutter application shall display the latest received water-quality values with units, device identity, and timestamp, and shall indicate when a value is missing or invalid. | Flutter application | Must | Confirmed |
| **FR-10** | The Flutter application shall allow a farmer to record a manual ammonia test result for a selected pond, including value, unit, test-kit name, optional notes, and recorded time. | Shrimp Farmer; Flutter application; Node.js service | Must | Confirmed |
| **FR-11** | The Node.js service shall persist sensor readings and manual ammonia readings in PostgreSQL with references to the pond, the device or sensor where applicable, and the recorded time. | Node.js service; PostgreSQL | Must | Confirmed |
| **FR-12** | The Node.js service shall retrieve historical readings for a pond filtered by parameter and time range and return them to the Flutter application or React dashboard. | Node.js service; PostgreSQL; Flutter application; React dashboard | Must | Confirmed |
| **FR-13** | The Flutter application and React dashboard shall display historical readings as charts or trend views for a selected pond and parameter. | Flutter application; React dashboard | Should | Confirmed |
| **FR-14** | The Flutter application shall allow a farmer to request environmental risk analysis for a selected pond, and the Node.js service shall forward the pond context and recent readings or history to the Python FastAPI service. | Shrimp Farmer; Flutter application; Node.js service; FastAPI service | Must | Confirmed |
| **FR-15** | The Python FastAPI service shall evaluate configured expert-validated thresholds and available historical trends and anomalies and return a risk level, risk score, summary, and structured factors; when thresholds are not configured, it shall return a `not_configured` status without presenting a risk level. | Python FastAPI service | Must | Confirmed |
| **FR-16** | The Node.js service shall store each risk report with its risk level, score, summary, factors, analysis engine, model version, and generation time, and the Flutter application and React dashboard shall display the report. | Node.js service; PostgreSQL; Flutter application; React dashboard | Must | Confirmed |
| **FR-17** | The Python FastAPI service shall send the validated risk result to the Gemini API to generate a Bengali explanation and farmer-friendly recommendation text, and shall not allow Gemini to change or override the validated risk level. | Python FastAPI service; Gemini API | Must | Confirmed |
| **FR-18** | The Flutter application and React dashboard shall display structured recommendations and any available Bengali recommendation text for a risk report, including priority or category where provided. | Flutter application; React dashboard; Node.js service | Should | Confirmed |
| **FR-19** | The Node.js service shall create an in-app notification for a farmer when a stored risk report meets the configured notification condition. | Node.js service; PostgreSQL | Should | Confirmed |
| **FR-20** | The Flutter application and React dashboard shall list a user's notifications and allow the user to mark a notification as read. | Shrimp Farmer; System Admin; Flutter application; React dashboard; Node.js service | Should | Confirmed |
| **FR-21** | The React dashboard shall provide authenticated monitoring views of farms, ponds, devices, readings, risk reports, and notifications. | System Admin; React dashboard; Node.js service | Should | Confirmed |
| **FR-22** | The Node.js service shall enforce role-based access so that farmers can access only their own farms, ponds, devices, and readings, while administrators can access system-wide monitoring views without granting farmer-data mutation by default. | Node.js service; PostgreSQL | Must | Confirmed |
| **FR-23** | The Node.js service shall store and retrieve sensor calibration records containing the sensor, calibration type, reference solution, before and after values, temperature, calibration time, and next due time, and shall expose the current sensor calibration status. | Shrimp Farmer (authorized device owner); Node.js service; PostgreSQL | Should | Confirmed — supporting; mobile UI workflow TBC |

## 2.2 Functional Requirement Notes

1. **FR-08** covers the four confirmed sensor parameters only. Turbidity is not included as a current sensor-reading requirement.
2. **FR-11** intentionally separates sensor readings from manual test-kit readings, matching the existing database design.
3. **FR-15** is owned by the Python FastAPI service. Gemini is not part of the classification decision.
4. **FR-17** allows Gemini to explain and draft recommendation text, but it does not allow Gemini to introduce new measurements, change the risk level, or prescribe chemical dosing.
5. **FR-23** is a confirmed data requirement because calibration records exist in the database design. The dedicated Flutter calibration workflow is not yet confirmed as implemented.
6. Push and SMS notification delivery are not current functional requirements. The `notifications.channel` database field permits future channels, but the current requirement is in-app notification display.

---

# Section 3: Non-Functional Requirements

## 3.1 Non-Functional Requirement List

| ID | Category | Non-Functional Requirement | Verification Method |
|---|---|---|---|
| **NFR-01** | Usability and localization | The Flutter application and farmer-facing outputs shall use clear Bengali labels and simple language so that a farmer can complete registration, pond selection, reading collection, manual ammonia entry, and risk-report viewing without technical training. | Team usability walkthrough and Bengali text review with at least three test users. |
| **NFR-02** | Performance | On a stable network connection, normal authenticated API requests shall return within 3 seconds for typical single-record or list operations; rule-based risk classification shall return within 5 seconds excluding any Gemini explanation time; and a Gemini explanation shall complete within 20 seconds or fall back safely. | Timed API and end-to-end tests under representative data volumes. |
| **NFR-03** | Reliability and graceful degradation | If Gemini is unavailable or unconfigured, the rule-based risk report shall still be produced and stored, with the explanation marked unavailable or pending. If the FastAPI service is unavailable, readings shall still be stored and the analysis shall be marked pending rather than falsely reported as complete. | Failure-injection tests for Gemini, FastAPI, and database outages. |
| **NFR-04** | Bluetooth communication reliability | The Flutter application shall expose Bluetooth connection state, detect disconnection, reject malformed or incomplete reading payloads, and allow the farmer to retry a connection or reading. A reading shall not be stored without valid device and pond context. | Disconnect, malformed-payload, and retry tests with the ESP32. |
| **NFR-05** | Security | Passwords shall be stored only as hashes; authenticated access shall use signed tokens or sessions; database credentials, token secrets, and the Gemini API key shall be stored in environment variables; database queries shall be parameterized; and secrets shall never be written to logs or returned to clients. | Code review, configuration review, and authentication and authorization tests. |
| **NFR-06** | Data privacy | Farmer identity, farm location, and pond data shall be access-controlled so that a farmer can access only their own records and an administrator can access only the monitoring views granted by their role. Personal data shall not be exposed in logs or public API responses. | Role-based access tests and log review. |
| **NFR-07** | Data integrity | The database shall enforce foreign-key relationships, store units with values, store timestamps in UTC, keep sensor readings append-only, and use quality flags for suspect or invalid readings. | Schema review, constraint tests, and representative data-integrity checks. |
| **NFR-08** | Maintainability | The system shall keep Flutter, React, Node.js, and FastAPI code in separate service directories, document the API surface, use numbered database migrations, and pass the available lint or build checks for each service. | Repository structure review, migration review, and lint or build execution. |
| **NFR-09** | Scalability | The database schema and indexes shall support multiple farms, multiple ponds per farm, multiple devices per pond, and growing historical reading volume; historical queries shall use indexed pond, sensor, parameter, and time-range access paths. | Representative query plans and index review with sample data. |
| **NFR-10** | Compatibility | The Flutter application shall target Android devices supported by the selected Flutter SDK; the React dashboard shall run in current major desktop browsers; the Node.js and FastAPI services shall run on the documented cloud server environment; and PostgreSQL version selection shall be recorded. | Build and smoke tests on target platforms. |
| **NFR-11** | Traceability and auditability | Each risk report shall retain the analysis engine identifier, model version, structured factors, generation time, and any Gemini explanation so that a report can be traced to the inputs and analysis policy used. Analysis inputs and outputs shall be logged without logging secrets. | Inspection of stored risk-report records and log review. |

## 3.2 Non-Functional Requirement Notes

1. Performance targets are realistic project targets, not guaranteed production service-level agreements.
2. Exact Bluetooth range, sensor accuracy, cloud provider, PostgreSQL version, and mobile operating-system coverage remain **To Be Confirmed** in the project documentation.
3. The system does not claim continuous availability. Failure handling is defined so that a partial result is never presented as a complete analysis.
4. The NFRs apply to the confirmed core scope. Future ML and turbidity features would require additional performance and validation requirements.

---

# Section 4: User Roles

## 4.1 Shrimp Farmer

**Description:** The primary user of the mobile application who owns or manages shrimp ponds.

**Responsibilities supported by the established project scope:**

1. Register and authenticate in the Flutter application.
2. View and update farmer profile information.
3. Create and manage farms and ponds.
4. Register an ESP32 device and assign it to a pond.
5. Connect the Flutter application to the ESP32 over Bluetooth.
6. Collect and view water-quality readings.
7. Enter manual ammonia test-kit results.
8. View historical readings, charts, and trend views.
9. Request environmental risk analysis.
10. View validated risk reports, Bengali explanations, and recommendations.
11. View in-app notifications and warnings.
12. View or record sensor calibration information where the calibration workflow is supported.

**Restrictions:**

1. A farmer can access only their own farms, ponds, devices, readings, reports, and notifications.
2. A farmer cannot change a validated risk level or the rule-based classification.
3. A farmer cannot use the system as a substitute for a qualified aquaculture expert or veterinarian.

## 4.2 System Admin

**Description:** An administrative user represented by the existing `admin` role in the database and the React dashboard's monitoring and administration scope.

**Responsibilities supported by the existing project scope:**

1. Authenticate to the React dashboard.
2. View monitoring summaries for farms, ponds, devices, readings, risk reports, and notifications.
3. Review risk reports and notification records for oversight.
4. Use dashboard filters and detail views to inspect monitoring data.

**Restrictions and open points:**

1. The current project documentation does not define separate admin workflows for creating, deleting, or suspending farmer accounts. This SRS does not introduce them.
2. Admin access is limited to monitoring and review unless the team confirms additional permissions.
3. The exact scope of admin data visibility and any admin mutation rights must be confirmed by the team.
4. The `Officer / Farm Owner` actor shown in the Week 02 architecture context diagram is not a separate role in this SRS. It should be treated as an unconfirmed label or mapped to an existing role after team review.

---

# Section 5: Use Cases

## 5.1 Use Case Summary

| Use Case ID | Use Case Name | Primary Actor | Related FRs |
|---|---|---|---|
| UC-01 | Farmer Registration | Shrimp Farmer | FR-01 |
| UC-02 | User Login | Shrimp Farmer; System Admin | FR-02, FR-22 |
| UC-03 | Manage Farmer Profile | Shrimp Farmer | FR-03 |
| UC-04 | Manage Farms and Ponds | Shrimp Farmer | FR-04, FR-05 |
| UC-05 | Register Device and Connect ESP32 | Shrimp Farmer | FR-06, FR-07 |
| UC-06 | Collect and View Sensor Readings | Shrimp Farmer | FR-08, FR-09, FR-11 |
| UC-07 | Enter Manual Ammonia Reading | Shrimp Farmer | FR-10, FR-11 |
| UC-08 | View Historical Readings and Charts | Shrimp Farmer; System Admin | FR-12, FR-13 |
| UC-09 | Request Environmental Risk Analysis | Shrimp Farmer | FR-14, FR-15, FR-16, FR-17, FR-19 |
| UC-10 | View Bengali Explanation and Recommendations | Shrimp Farmer | FR-17, FR-18 |
| UC-11 | View Notifications | Shrimp Farmer; System Admin | FR-19, FR-20 |
| UC-12 | Admin Monitor Dashboard | System Admin | FR-21, FR-22 |
| UC-13 | Record Sensor Calibration | Shrimp Farmer | FR-23 |

## 5.2 Detailed Use Cases

### UC-01: Farmer Registration

**Use Case ID:** UC-01
**Use Case Name:** Farmer Registration
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The Flutter application is installed and running.
2. The Node.js backend and PostgreSQL database are available.
3. The farmer does not already have an account with the same email address.

**Main Flow:**
1. Farmer opens the registration screen.
2. Farmer enters full name, email address, optional phone number, and password.
3. Flutter application validates that required fields are present and that the email format is valid.
4. Flutter application sends the registration request to the Node.js service.
5. Node.js service checks that the email address is not already registered.
6. Node.js service hashes the password and stores the farmer account with the `farmer` role.
7. Node.js service returns a successful registration response.
8. Flutter application confirms registration and directs the farmer to the login screen.

**Postconditions:**
1. A new farmer account exists in PostgreSQL with a hashed password.
2. The farmer can authenticate using the registered email address and password.

**Alternative Flow:**
1. If a required field is missing or invalid, Flutter application displays a validation message and does not submit the request.
2. If the email address is already registered, Node.js service returns a controlled conflict error and the account is not created.
3. If the backend or database is unavailable, the farmer sees a controlled error and no account is claimed as created.

---

### UC-02: User Login

**Use Case ID:** UC-02
**Use Case Name:** User Login
**Primary Actor:** Shrimp Farmer; System Admin
**Preconditions:**
1. The user has a registered account.
2. The Flutter application or React dashboard is available.
3. The Node.js backend and PostgreSQL database are available.

**Main Flow:**
1. User enters email address and password.
2. Client validates that both fields are present.
3. Client sends the credentials to the Node.js service.
4. Node.js service verifies the password against the stored password hash.
5. Node.js service issues a signed token or session containing the user identity and role.
6. Client stores the token securely and opens the role-appropriate home screen.
7. Farmer is directed to the Flutter dashboard; administrator is directed to the React dashboard.

**Postconditions:**
1. The user has an authenticated session.
2. The client can access only the screens and API operations permitted by the user's role.

**Alternative Flow:**
1. If the email or password is incorrect, the system returns a generic authentication error and does not reveal which field was wrong.
2. If the account is not authorized for the requested role, access is denied.
3. If the backend is unavailable, the client shows a controlled connection error and does not grant access.

---

### UC-03: Manage Farmer Profile

**Use Case ID:** UC-03
**Use Case Name:** Manage Farmer Profile
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. The farmer profile exists.

**Main Flow:**
1. Farmer opens the profile screen.
2. Flutter application requests the current profile from the Node.js service.
3. Node.js service returns the farmer's full name, email, and phone number.
4. Flutter application displays the profile.
5. Farmer updates the full name or phone number and submits the change.
6. Flutter application validates the updated fields.
7. Node.js service updates the profile and records the update time.
8. Flutter application displays the saved profile.

**Postconditions:**
1. The updated profile is persisted in PostgreSQL.
2. The farmer sees the updated information in the application.

**Alternative Flow:**
1. If a required field is empty or invalid, the client displays a validation message and does not submit the update.
2. If the farmer is not authenticated or not authorized, the Node.js service returns an access-denied response.
3. If the update fails, the client displays a controlled error and does not claim that the profile was saved.

---

### UC-04: Manage Farms and Ponds

**Use Case ID:** UC-04
**Use Case Name:** Manage Farms and Ponds
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. The Node.js backend and PostgreSQL database are available.

**Main Flow:**
1. Farmer opens the farm list.
2. Flutter application requests the farmer's farms from the Node.js service.
3. Node.js service returns only farms owned by the authenticated farmer.
4. Farmer creates a farm or selects an existing farm.
5. Farmer enters or edits farm details such as name, address, locality, area, and optional coordinates.
6. Flutter application validates the required fields and submits the farm request.
7. Node.js service verifies ownership and persists the farm.
8. Farmer opens the selected farm and creates or edits a pond.
9. Farmer enters pond details such as name, area, depth, status, and optional stocking date.
10. Node.js service verifies farm ownership and persists the pond.
11. Flutter application refreshes the farm and pond lists.

**Postconditions:**
1. The farm and pond records are stored in PostgreSQL.
2. The authenticated farmer can view the updated farm and pond list.
3. Ownership relationships are preserved.

**Alternative Flow:**
1. If a required farm or pond field is invalid, the client displays a validation message and does not submit the request.
2. If the farmer attempts to access another farmer's farm or pond, the Node.js service denies the operation.
3. If a pond cannot be archived because of an unsupported state transition, the client displays a controlled error.
4. If the backend is unavailable, the client displays a connection error and does not claim that changes were saved.

---

### UC-05: Register Device and Connect ESP32

**Use Case ID:** UC-05
**Use Case Name:** Register Device and Connect ESP32
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. At least one pond exists and belongs to the farmer.
3. The ESP32 device is powered and Bluetooth is enabled on the mobile device.
4. The device is compatible with the ShrimpGuard AI Bluetooth payload.

**Main Flow:**
1. Farmer selects a pond and opens the device connection screen.
2. Flutter application displays devices already associated with the pond.
3. If the device is not registered, farmer enters the ESP32 device serial and a friendly name.
4. Flutter application submits the device registration request to the Node.js service.
5. Node.js service validates the serial, checks ownership of the pond, and stores the device-to-pond association.
6. Farmer starts a Bluetooth scan.
7. Flutter application discovers nearby compatible ESP32 devices.
8. Farmer selects the intended device.
9. Flutter application establishes a Bluetooth connection and displays the connection state.
10. Flutter application confirms the connected device identity and associated pond.

**Postconditions:**
1. The ESP32 device is associated with the selected pond.
2. The Flutter application has an active Bluetooth connection or a clearly displayed connection failure.
3. No reading is treated as valid until the device and pond context are known.

**Alternative Flow:**
1. If no compatible device is found, the application displays a no-device message and allows a rescan.
2. If the Bluetooth connection fails, the application displays the failure and allows retry.
3. If the device serial is already registered to another pond or farm, the Node.js service returns a controlled conflict error.
4. If the farmer does not own the selected pond, the Node.js service denies the device association.
5. If Bluetooth permission is denied on the mobile device, the application explains that connection cannot proceed.

---

### UC-06: Collect and View Sensor Readings

**Use Case ID:** UC-06
**Use Case Name:** Collect and View Sensor Readings
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. A device is registered and associated with the selected pond.
3. The Flutter application is connected to the ESP32 over Bluetooth.
4. The sensor payload format is supported by the application.

**Main Flow:**
1. Farmer starts a reading collection from the connected device.
2. Flutter application requests a reading payload from the ESP32.
3. ESP32 sends the pH, dissolved oxygen, temperature, and salinity values with units and a device timestamp.
4. Flutter application validates that the payload is complete and that numeric values are within parseable ranges.
5. Flutter application displays the current values, units, device identity, and timestamp.
6. Flutter application attaches the authenticated farmer and pond context and uploads the reading to the Node.js service.
7. Node.js service validates the request and persists the reading in PostgreSQL with the appropriate sensor and pond references.
8. Node.js service returns a successful storage response.
9. Flutter application confirms that the reading was stored.

**Postconditions:**
1. The sensor reading is stored in PostgreSQL.
2. The latest water-quality values are visible in the Flutter application.
3. The reading remains distinguishable from manual ammonia readings.

**Alternative Flow:**
1. If a sensor value is missing or malformed, the application marks the reading as incomplete and does not present it as a valid complete reading.
2. If the Bluetooth connection is lost, the application displays the disconnected state and does not claim that the reading was stored.
3. If the backend upload fails, the application reports the upload failure and does not claim persistence; retry behavior is a future enhancement.
4. If the device is not associated with the selected pond, the application blocks the upload and displays a context error.

---

### UC-07: Enter Manual Ammonia Reading

**Use Case ID:** UC-07
**Use Case Name:** Enter Manual Ammonia Reading
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. A pond belonging to the farmer exists.
3. The farmer has performed a manual ammonia test-kit measurement.

**Main Flow:**
1. Farmer selects the pond and opens the manual ammonia entry screen.
2. Flutter application displays the required fields.
3. Farmer enters the ammonia value, unit, test-kit name, optional notes, and recorded time.
4. Flutter application validates that the value is numeric, the unit is present, and the recorded time is valid.
5. Flutter application submits the manual reading to the Node.js service.
6. Node.js service verifies pond ownership and stores the manual reading in PostgreSQL.
7. Node.js service returns a successful storage response.
8. Flutter application displays the saved manual reading in the pond history.

**Postconditions:**
1. The manual ammonia reading is stored with the pond, recording user, test-kit metadata, and recorded time.
2. The manual reading is displayed separately from sensor readings.

**Alternative Flow:**
1. If the value is not numeric or the unit is missing, the application displays a validation message and does not submit.
2. If the selected pond does not belong to the farmer, the Node.js service denies the request.
3. If the backend or database is unavailable, the application displays a controlled error and does not claim that the reading was saved.

---

### UC-08: View Historical Readings and Charts

**Use Case ID:** UC-08
**Use Case Name:** View Historical Readings and Charts
**Primary Actor:** Shrimp Farmer; System Admin
**Preconditions:**
1. The user is authenticated.
2. The selected pond has at least one stored sensor or manual reading.
3. The user is authorized to view the pond history.

**Main Flow:**
1. User selects a pond, a parameter, and a time range.
2. Client sends the history request to the Node.js service.
3. Node.js service verifies access and queries PostgreSQL using the pond, parameter, and time range.
4. Node.js service returns the readings in chronological order.
5. Flutter application or React dashboard renders a chart or trend view and a corresponding data list.
6. User reviews the historical values and timestamps.

**Postconditions:**
1. No data is modified.
2. The user sees the requested historical readings and trend view.

**Alternative Flow:**
1. If no readings exist for the selected range, the client displays an empty state instead of an error.
2. If the time range is invalid, the client displays a validation message.
3. If the user is not authorized to view the pond, the Node.js service returns an access-denied response.
4. If the backend is unavailable, the client displays a controlled error.

---

### UC-09: Request Environmental Risk Analysis

**Use Case ID:** UC-09
**Use Case Name:** Request Environmental Risk Analysis
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. The selected pond exists and belongs to the farmer.
3. Recent sensor readings or manual readings are available for the pond.
4. Expert-validated thresholds are configured in the FastAPI service.

**Main Flow:**
1. Farmer opens the risk analysis view for a pond and requests analysis.
2. Flutter application sends the request to the Node.js service.
3. Node.js service verifies pond ownership and gathers the pond context and recent readings or history.
4. Node.js service sends the analysis request to the Python FastAPI service.
5. FastAPI service evaluates the readings against configured expert-validated thresholds.
6. FastAPI service analyzes available historical trends and abnormal patterns.
7. FastAPI service classifies the environmental risk and produces a risk level, score, summary, and structured factors.
8. FastAPI service may request a Bengali explanation from Gemini after classification has been completed.
9. If Gemini returns text, FastAPI service includes it with the validated result; if not, the result remains valid without an explanation.
10. Node.js service stores the risk report and any structured recommendations.
11. Flutter application displays the risk level, score, summary, factors, and report generation time.

**Postconditions:**
1. A risk report is stored in PostgreSQL with the analysis engine, model version, factors, and generation time.
2. The farmer sees the validated environmental risk result.
3. The risk level is determined by the Python rule-based analysis, not by Gemini.

**Alternative Flow:**
1. If expert-validated thresholds are not configured, FastAPI returns `status: not_configured` and does not present a risk level.
2. If historical data is insufficient for trend analysis, the system performs the available rule evaluation and indicates that the trend could not be fully assessed.
3. If the FastAPI service is unavailable, Node.js stores the readings and marks the analysis as pending instead of presenting a result.
4. If Gemini is unavailable or unconfigured, the report is still produced and stored with the explanation marked unavailable or pending.
5. If the farmer does not own the pond, the analysis request is denied.
6. If the risk report cannot be stored, the system does not claim that analysis was completed.

---

### UC-10: View Bengali Explanation and Recommendations

**Use Case ID:** UC-10
**Use Case Name:** View Bengali Explanation and Recommendations
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated.
2. A risk report exists for a pond owned by the farmer.
3. The report may or may not contain a Gemini-generated Bengali explanation.

**Main Flow:**
1. Farmer opens a stored risk report.
2. Flutter application requests the report details from the Node.js service.
3. Node.js service verifies pond ownership and returns the risk level, summary, factors, structured recommendations, and any available Bengali explanation.
4. Flutter application displays the validated risk level and its factors.
5. Flutter application displays the structured recommendations with priority or category where provided.
6. If a Bengali explanation exists, Flutter application displays it in simple Bengali.
7. Farmer reads the explanation and recommendations.

**Postconditions:**
1. The farmer has viewed the validated risk result and its explanation or fallback state.
2. No risk level is changed by the explanation layer.

**Alternative Flow:**
1. If no Bengali explanation is available, the application displays an explanation-unavailable or pending message and still shows the structured recommendations and validated risk level.
2. If the report has no recommendations, the application displays the risk result without inventing recommendations.
3. If the farmer is not authorized to view the report, the request is denied.
4. If the report cannot be retrieved, the client displays a controlled error.

---

### UC-11: View Notifications

**Use Case ID:** UC-11
**Use Case Name:** View Notifications
**Primary Actor:** Shrimp Farmer; System Admin
**Preconditions:**
1. The user is authenticated.
2. The user has permission to view the notification list.

**Main Flow:**
1. User opens the notification screen or dashboard notification panel.
2. Client requests the user's notifications from the Node.js service.
3. Node.js service returns notifications with title, message, read status, creation time, and any available pond or risk-report reference.
4. Client displays the notification list, distinguishing read and unread items.
5. User opens a notification.
6. Client displays the notification details and any linked pond or risk report.
7. Client marks the notification as read through the Node.js service.
8. Node.js service updates the read status.

**Postconditions:**
1. The notification remains available in the user's history.
2. The selected notification is marked as read.

**Alternative Flow:**
1. If the user has no notifications, the client displays an empty state.
2. If a notification references a pond or report that is no longer available, the client displays the notification text without claiming that the linked record exists.
3. If the user is not authorized to view the notification, the request is denied.
4. If marking as read fails, the client displays a controlled error and does not falsely show the item as read.

---

### UC-12: Admin Monitor Dashboard

**Use Case ID:** UC-12
**Use Case Name:** Admin Monitor Dashboard
**Primary Actor:** System Admin
**Preconditions:**
1. The administrator is authenticated through the React dashboard.
2. The administrator has the `admin` role.
3. The Node.js backend and PostgreSQL database are available.

**Main Flow:**
1. Administrator opens the React dashboard.
2. Dashboard requests monitoring summary data from the Node.js service.
3. Node.js service verifies the administrator role and returns permitted monitoring data.
4. Dashboard displays summaries of farms, ponds, devices, readings, risk reports, and notifications.
5. Administrator applies filters or opens a detail view for a farm, pond, device, reading, or risk report.
6. Dashboard requests the selected detail data from the Node.js service.
7. Node.js service returns the permitted monitoring data.
8. Dashboard displays the selected detail in a read-only monitoring view.

**Postconditions:**
1. The administrator has viewed the permitted monitoring data.
2. No farmer data is modified by this use case.

**Alternative Flow:**
1. If there is no monitoring data, the dashboard displays an empty state.
2. If the authenticated user does not have the `admin` role, access is denied.
3. If a requested detail record is unavailable, the dashboard displays a controlled not-found state.
4. If the backend is unavailable, the dashboard displays a controlled connection error.

---

### UC-13: Record Sensor Calibration

**Use Case ID:** UC-13
**Use Case Name:** Record Sensor Calibration
**Primary Actor:** Shrimp Farmer
**Preconditions:**
1. The farmer is authenticated and authorized to maintain the sensor.
2. The sensor is registered and associated with a device and pond.
3. A calibration procedure has been performed according to the project calibration guidance.

**Main Flow:**
1. Farmer selects the sensor and opens the calibration record form.
2. Farmer enters the calibration type, reference solution, before value, after value, temperature, optional notes, calibration time, and optional next due time.
3. Client validates that the sensor is selected and that numeric fields are valid.
4. Client submits the calibration record to the Node.js service.
5. Node.js service verifies authorization and stores the calibration record in PostgreSQL.
6. Node.js service updates the sensor calibration status.
7. Client displays the saved calibration record and current calibration status.

**Postconditions:**
1. A calibration record is stored for the sensor.
2. The sensor calibration status reflects the recorded calibration.
3. The calibration history remains available for later review.

**Alternative Flow:**
1. If required fields are missing or invalid, the client displays a validation message and does not submit the record.
2. If the sensor does not exist or is not accessible to the user, the Node.js service denies the request.
3. If the database write fails, the client displays a controlled error and does not claim that calibration was recorded.
4. The dedicated Flutter calibration screen is not confirmed as implemented; the use case defines the intended behavior for a later implementation increment.

---

# Appendix A: Requirements Traceability Matrix

| Functional Requirement | Use Case(s) | Traceability Note |
|---|---|---|
| FR-01 | UC-01 | Farmer registration creates the account used by all authenticated use cases. |
| FR-02 | UC-02, UC-12 | Login is required for farmer and administrator access. |
| FR-03 | UC-03 | Profile management is a farmer account function. |
| FR-04 | UC-04 | Farm management is the parent of pond management. |
| FR-05 | UC-04 | Pond management is performed under an owned farm. |
| FR-06 | UC-05 | Device registration associates the ESP32 with a pond. |
| FR-07 | UC-05 | Bluetooth connection is established after device registration. |
| FR-08 | UC-06 | Sensor payload collection is part of reading acquisition. |
| FR-09 | UC-06 | Current values are displayed after collection. |
| FR-10 | UC-07 | Manual ammonia entry is a separate data-entry use case. |
| FR-11 | UC-06, UC-07 | The Node.js service persists both sensor and manual readings. |
| FR-12 | UC-08 | Historical retrieval supplies the history view. |
| FR-13 | UC-08 | Charts and trend views display retrieved history. |
| FR-14 | UC-09 | Risk analysis is requested from the mobile application. |
| FR-15 | UC-09 | Rule-based classification is performed by FastAPI. |
| FR-16 | UC-09 | The risk report is stored and displayed. |
| FR-17 | UC-09, UC-10 | Gemini explanation is generated after classification and viewed with the report. |
| FR-18 | UC-10 | Recommendations are displayed with the report. |
| FR-19 | UC-09, UC-11 | A risk report may trigger an in-app notification. |
| FR-20 | UC-11 | Notifications are listed and marked as read. |
| FR-21 | UC-12 | The React dashboard provides monitoring views. |
| FR-22 | UC-02, UC-12 | Role-based access applies to authentication and dashboard monitoring. |
| FR-23 | UC-13 | Calibration records and status are stored and reviewed. |

---

# Appendix B: Confirmed Scope, Supporting Scope, and Future Scope

## B.1 Confirmed Scope

The following capabilities are confirmed for the core project:

1. Farmer registration and authentication.
2. Farmer profile management.
3. Multiple farm and multiple pond management.
4. ESP32 device registration and Bluetooth connection.
5. pH, dissolved oxygen, temperature, and salinity reading collection and display.
6. Manual ammonia test-kit entry.
7. Sensor and manual reading persistence.
8. Historical retrieval and chart or trend display.
9. Environmental risk analysis using expert-validated rules, historical trends, and abnormal pattern detection.
10. Risk report storage and display.
11. Gemini-generated Bengali explanation and farmer-friendly recommendation text based on validated results.
12. Structured recommendation display.
13. In-app notifications and notification viewing.
14. React dashboard monitoring.
15. Role-based access for farmers and administrators.

## B.2 Supporting Scope

1. Sensor calibration records and calibration status are supported by the database design and hardware documentation. The dedicated mobile calibration workflow requires team confirmation.
2. The database supports notification channels for future push and SMS delivery, but current requirements cover in-app notifications only.
3. The database sensor type enumeration includes turbidity for future use, but turbidity is not a current sensor-reading requirement.

## B.3 Future Scope

The following items are planned or possible future work and are **not** current functional requirements:

1. Custom machine-learning model using Pandas, NumPy, and Scikit-learn.
2. Turbidity sensor integration.
3. Offline-first mobile operation with background synchronization.
4. Push or SMS alert delivery.
5. Multi-language support beyond Bengali.
6. Veterinary or extension-officer collaboration workflows.
7. Farm-level analytics and benchmarking.
8. Automated calibration reminders and device health monitoring.
9. Cloud observability and advanced audit trails.

---

# Appendix C: Consistency Review and Open Items

## C.1 Consistency Review

1. Every FR in Section 2 is within the established ShrimpGuard AI scope described in the README, the Week 02 proposal, the system architecture, and the database design.
2. Every NFR is realistic for an academic project and does not claim an unsupported production guarantee.
3. Every FR is traceable to at least one use case in Appendix A.
4. The Python FastAPI service performs risk classification. Gemini only explains the validated result and drafts farmer-friendly text. Gemini is not permitted to change or override the risk level.
5. Turbidity, custom ML, offline synchronization, push or SMS delivery, and multi-language support are explicitly listed as future scope and are not presented as implemented features.
6. The current repository is a foundation. Most Node.js endpoints return `501 Not Implemented`, Flutter screens are placeholders, and the FastAPI service contains foundation rule, trend, anomaly, and classification logic. This SRS specifies requirements; it does not claim that all requirements are already implemented.

## C.2 Open Items Requiring Team Confirmation

1. **Week 01 reference:** No Week 01 documentation or PDF is present in the workspace. The team should confirm whether a Week 01 document exists and whether it introduces any requirement not captured here.
2. **Officer role:** The Week 02 architecture context diagram includes an `Officer / Farm Owner` actor. The confirmed role model in the database and proposal is farmer and admin. The team should confirm whether a third role is intended.
3. **Admin permissions:** The team should confirm the exact scope of admin monitoring, data visibility, and whether admins may modify any records.
4. **Calibration workflow:** The team should confirm whether the Week 03 implementation scope includes a farmer-facing calibration screen or only the calibration data model.
5. **Notification condition:** The exact risk level or threshold that triggers an in-app notification is not yet defined and requires team or expert confirmation.
6. **Expert thresholds:** Final acceptable ranges and the risk-scoring policy require expert validation. Until then, the FastAPI service returns `not_configured` when thresholds are unavailable.
7. **Implementation status:** The team should update this SRS when core requirements move from specification to implemented functionality.
