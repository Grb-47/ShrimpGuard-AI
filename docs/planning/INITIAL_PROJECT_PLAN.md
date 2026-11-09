# ShrimpGuard AI — Initial Project Plan

**Team:** CSE4104-7C-T04 · Section 7C
**Status:** Week 02 foundation
**Planning note:** The task distribution below is a proposal. The team should confirm or adjust it at the next planning meeting.

---

## 1. Development Phases

| Phase | Focus | Key Deliverables | Exit Criteria |
|---|---|---|---|
| 0 | Requirements and stack | Week 01 requirements, technology stack, architecture direction | Team agreement on scope and stack |
| 1 | Project foundation (current) | Folder structure, README, `.gitignore`, architecture docs, database design, service skeletons, hardware docs, Week 02 assignment documents | All foundation files reviewed and consistent |
| 2 | Database and authentication | Applied PostgreSQL schema, Node.js auth endpoints, password hashing, token handling | A farmer can register and log in against the real database |
| 3 | Core backend and data model | Farm, pond, device, sensor, reading, and history endpoints | CRUD and reading storage work with authorization |
| 4 | Device and mobile ingestion | ESP32 firmware, Bluetooth protocol, Flutter device connection and reading submission | A reading can travel from the device to PostgreSQL |
| 5 | Risk analysis | FastAPI rules, trend analysis, anomaly detection, risk reports | A stored reading produces a stored risk report |
| 6 | Bengali explanation | Gemini integration grounded in the risk result, recommendation storage | A validated risk report receives Bengali text or a safe fallback |
| 7 | Dashboard, notifications, and charts | React views, Flutter history and charts, notification flow | End-to-end monitoring flow is usable by the team |
| 8 | Testing and deployment | Integration tests, calibration validation, cloud deployment, user documentation | System is demonstrable and documented |
| 9 | Future ML and expansion | Custom ML model, turbidity sensor, offline sync | Planned after the core system is stable |

## 2. Proposed Task Distribution

This is a balanced three-person proposal and is subject to change.

| Area | Primary | Support | Notes |
|---|---|---|---|
| Coordination, scope, and integration | Shefa Hassan Shefa | All | Team leader; owns milestone tracking and final review |
| Node.js backend and authentication | Shefa Hassan Shefa | Gourab Mondal | API design, auth, farm/pond/device/reading/report modules |
| Database design and operations | Gourab Mondal | Shefa Hassan Shefa | Schema, migrations, indexes, backups, query review |
| ESP32 firmware and sensor integration | Gourab Mondal | Shahreia Alam | Pin map, firmware, Bluetooth payload, calibration support |
| Python risk service and future ML | Gourab Mondal | Shefa Hassan Shefa | Rules, trends, anomaly detection, risk scoring, ML path |
| Flutter farmer application | Shahreia Alam | Shefa Hassan Shefa | Screens, navigation, API client, device flow, Bengali UI |
| React dashboard | Shahreia Alam | Gourab Mondal | Monitoring views, reports, notifications, admin layout |
| Bengali content and farmer UX | Shahreia Alam | All | Explanation review, clarity, localization |
| Hardware testing and calibration | Gourab Mondal | All | Bench tests, reference checks, calibration records |
| Documentation and submission | Shefa Hassan Shefa | All | Architecture, planning, proposal, team info, README review |

**Shared responsibilities:** code review, testing, weekly progress notes, and keeping documentation aligned with implementation.

## 3. Development Priorities

### P0 — Must work for the core demonstration

1. Database schema applied and stable.
2. Farmer registration and login.
3. Farm and pond management.
4. Device and sensor registration.
5. Sensor reading ingestion and historical retrieval.
6. Rule-based risk analysis with configurable thresholds.
7. Risk report storage.
8. Flutter dashboard and history views.
9. ESP32-to-Flutter Bluetooth path.

### P1 — Required for a complete user experience

1. Manual ammonia entry.
2. Bengali explanation through Gemini with safe fallback.
3. Notifications for risky conditions.
4. Charts and trend views.
5. React dashboard views.
6. Calibration records and sensor status.

### P2 — Enhancement and future scope

1. Custom ML model.
2. Turbidity sensor.
3. Offline-first synchronization.
4. SMS/push delivery.
5. Advanced analytics and benchmarking.

## 4. Backend Development

### Modules

- `auth` — registration, login, password hashing, token issue and verification
- `farms` — create, read, update, delete, ownership checks
- `ponds` — create, read, update, delete, farm ownership checks
- `devices` — registration, assignment to pond, status and last-seen tracking
- `readings` — sensor ingestion, manual test ingestion, history queries
- `risk` — call the FastAPI service, persist reports and recommendations
- `notifications` — create, list, mark as read

### Rules

- Validate every request body before database access.
- Enforce farmer ownership on farms, ponds, devices, and readings.
- Hash passwords; never log or return password hashes.
- Use parameterized SQL queries.
- Use consistent error responses.
- Keep the Node.js service as the owner of stored business data.
- Do not expose the Gemini key to clients.

### Foundation status

Routes, controllers, middleware, database pool, and the risk-service client exist as skeletons. Most endpoints intentionally return `501 Not Implemented`.

## 5. Mobile Application Development

### Modules

- Authentication
- Farmer profile
- Dashboard
- Farm management
- Pond management
- Device connection
- Water testing
- Manual ammonia entry
- AI risk analysis
- Bengali recommendations
- Historical data
- Charts
- Notifications
- Settings

### Implementation notes

- Use the existing `ApiClient` for HTTP calls.
- Add authentication token storage after the auth flow is implemented.
- Confirm the Bluetooth package only after the ESP32 protocol is fixed.
- Confirm the chart package before implementing charts.
- Keep Bengali text in a localization-friendly structure.
- Design for unstable connectivity in rural areas; offline queueing is planned.

### Foundation status

All feature screens and navigation exist. Most screens are placeholders with a clear description of planned behavior.

## 6. Database Development

### Immediate tasks

1. Review the schema in `database/schema/001_initial_schema.sql`.
2. Apply it to a local PostgreSQL instance.
3. Confirm the migration workflow.
4. Add seed data only in a local development script, never in committed production migrations.
5. Verify indexes with representative queries.

### Rules

- Add numbered migrations for every schema change.
- Do not edit an already-applied migration.
- Keep sensor readings append-only.
- Store units with values.
- Maintain calibration history.
- Back up the database before destructive changes.

### Open decisions

- Migration runner selection
- Retention period for raw readings
- Soft-delete policy before production
- Final units and expert-validated thresholds

## 7. AI Development

### Rule layer

1. Collect expert-validated thresholds for pH, dissolved oxygen, temperature, salinity, and ammonia.
2. Configure thresholds through `WATER_QUALITY_THRESHOLDS_JSON`.
3. Evaluate each reading against its configured range.
4. Include manual ammonia readings in analysis.
5. Return structured factors, not only a label.

### Trend and anomaly layer

1. Require at least three historical points for a trend.
2. Detect rising, falling, and stable directions.
3. Use the foundation z-score detector to flag statistical outliers in history; expert review is required before treating an outlier as an environmental rule.
4. Keep trend and anomaly evidence alongside the risk result.

### Classification layer

1. Use a transparent, documented scoring policy.
2. Treat the current scoring as a foundation policy pending expert review.
3. Never classify risk when no thresholds are configured; return `not_configured`.

### Gemini layer

1. Send the validated risk level, summary, and factor messages.
2. Instruct Gemini to explain in simple Bengali and not to change the risk level.
3. Do not allow chemical dosing instructions from the model.
4. Store the generated explanation with the report.
5. Fall back safely when the key or model is unavailable.
6. Review prompts and outputs with the team and a domain expert.

### Future ML

1. Collect a clean labeled dataset.
2. Define features from sensor history and manual readings.
3. Train and validate a model with Scikit-learn.
4. Compare ML output with the rule engine.
5. Deploy only after evaluation and expert review.

## 8. Hardware Testing

### Bench testing

1. Verify board boot and serial logging.
2. Test one sensor at a time.
3. Confirm supply voltages and signal levels.
4. Confirm the pin map and firmware constants.
5. Check reading stability with repeated samples.

### Calibration testing

1. Confirm reference solutions/methods for each sensor.
2. Follow `hardware/calibration/CALIBRATION_GUIDE.md`.
3. Record before/after values and temperatures.
4. Verify with an independent reference where possible.
5. Update `calibration_records` and sensor status.

### Field testing

1. Test in a safe, controlled pond environment.
2. Observe probe fouling and cable strain.
3. Check Bluetooth range and reconnection behavior.
4. Compare device readings with trusted manual measurements.
5. Record failures and environmental conditions.

### Safety

- Keep electronics dry.
- Confirm waterproofing before deployment.
- Do not deploy uncalibrated sensors as if they are accurate.
- Do not let the device claim a valid reading when a sensor is unconfigured or faulty.

## 9. Documentation Responsibilities

| Document | Primary owner | Reviewers |
|---|---|---|
| `README.md` | Shefa Hassan Shefa | All |
| `docs/architecture/SYSTEM_ARCHITECTURE.md` | Shefa Hassan Shefa | Gourab Mondal |
| `docs/architecture/DATABASE_DESIGN.md` | Gourab Mondal | Shefa Hassan Shefa |
| `database/schema/001_initial_schema.sql` | Gourab Mondal | Shefa Hassan Shefa |
| `docs/proposal/CSE4104-7C-T04_Proposal.md` | Shefa Hassan Shefa | All |
| `docs/team/CSE4104-7C-T04_TeamInfo.md` | Shefa Hassan Shefa | All |
| `docs/planning/INITIAL_PROJECT_PLAN.md` | Shefa Hassan Shefa | All |
| Hardware overview and ESP32 setup | Gourab Mondal | Shahreia Alam |
| Sensor documents | Gourab Mondal | Shefa Hassan Shefa |
| Calibration guide | Gourab Mondal | All |
| Flutter and React setup notes | Shahreia Alam | Shefa Hassan Shefa |

Documentation rule: when implementation changes behavior, update the relevant document in the same work cycle.

## 10. Dependencies and Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Sensor models not confirmed | Firmware and calibration blocked | Confirm datasheets and pin map early |
| Expert thresholds not available | Risk output remains `not_configured` | Schedule expert review; keep thresholds configurable |
| Flutter/Python not installed on a developer machine | Code cannot be run locally | Install SDKs and document versions |
| Bluetooth protocol not fixed | Mobile integration blocked | Agree on payload and profile before UI work |
| Gemini key handling | Security and cost risk | Keep key server-side; use safe fallback |
| Unstable internet in the field | Data loss | Plan offline queue and retry |
| Scope growth | Delays | Protect P0 scope first |

## 11. Definition of Done

A task is done when:

1. The code or document is complete and reviewed.
2. The relevant test or verification has passed.
3. Errors and edge cases are handled.
4. Documentation is updated.
5. No secrets are committed.
6. The team knows how to run or use the result.

## 12. Immediate Next Tasks

1. Install Flutter and Python on development machines and record versions.
2. Confirm ESP32 board, sensor models, pin map, and Bluetooth payload.
3. Apply the database schema locally.
4. Implement authentication in Node.js.
5. Implement farm and pond CRUD.
6. Implement reading ingestion and history.
7. Obtain expert-validated thresholds.
8. Connect the Flutter app to the implemented APIs.
