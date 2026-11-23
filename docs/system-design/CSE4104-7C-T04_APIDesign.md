# ShrimpGuard AI — Planned REST API Design

**Course:** CSE4104  
**Assignment:** Week 04 — System Design & Software Architecture  
**Official Team Name:** CSE4104-7C-T04 · **Section:** 7C  
**Project Title:** ShrimpGuard AI — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System  
**Document Status:** Week 04 planned design — **not fully implemented**

---

## 1. Purpose and Status

This document defines the planned HTTP interface for ShrimpGuard AI. It is derived from `docs/architecture/SYSTEM_ARCHITECTURE.md` Section 8, the Week 03 SRS (`CSE4104-7C-T04_SRS.md`), and the canonical schema `database/schema/001_initial_schema.sql`. The current repository contains service skeletons; most Node.js routes return `501 Not Implemented`. Therefore every endpoint below is a **planned API**, not a claim of existing functionality.

### 1.1 Source Labels

| Label | Meaning |
|---|---|
| **[ARCH-8]** | Explicitly listed in `SYSTEM_ARCHITECTURE.md` Section 8 (foundation API surface). |
| **[SRS]** | Required by an SRS functional requirement or detailed use case but not listed verbatim in Section 8. |
| **[PROPOSED]** | Proposed design decision needed to expose the SRS requirement as a REST endpoint; requires team confirmation before implementation. |

### 1.2 Global Conventions

- **Public application API:** all Flutter/React-facing Node.js/Express endpoints use the `/api/v1/` prefix.
- **Internal service API:** the Python/FastAPI Risk Analysis Service exposes only `/analyze` and `/health` in this design. Flutter and React must never call these endpoints directly; only Node.js does, over an internal network path.
- **Authentication:** `Authorization: Bearer <token>` is the proposed transport for the signed token/session described in the SRS. Token expiry and refresh strategy remain **To Be Confirmed**.
- **Roles:** strictly `farmer` and `admin`, matching the `user_role` enum. No `Officer` role exists.
- **Identifiers:** all ID strings in examples are UUIDs except `sensor_readings.id`, which is a `bigint` (`BIGSERIAL` in the schema).
- **Field naming:** database `snake_case` columns are represented as `camelCase` JSON keys; the mapping is a proposed design decision.
- **Units:** sensor and test-kit units remain **To Be Confirmed** in the project documentation; examples use `"unit": "TBC"` rather than invented units.
- **Timestamps:** ISO 8601 UTC strings, for example `2026-11-23T08:30:00Z`.
- **Secrets:** the Gemini API key, database credentials, and JWT secrets are server-side environment variables only. They are never accepted in request bodies or returned in responses.
- **Notification channels:** `in_app` is the current requirement. `push` and `sms` exist in the enum for future use.
- **Risk levels:** `low`, `moderate`, `high`, `critical` are stored in `risk_reports.risk_level`. `not_configured` is a **service status**, not a stored risk level.
- **Admin scope:** all Admin Monitoring endpoints are strictly `GET` (read-only). No admin creation, deletion, suspension, or mutation endpoint is defined here.

### 1.3 Common Status Codes

| Code | Meaning |
|---|---|
| `200 OK` | Read or update completed. |
| `201 Created` | Resource persisted. |
| `204 No Content` | Deletion completed. |
| `400 Bad Request` | Malformed or incomplete request. |
| `401 Unauthorized` | Missing or invalid credentials/token. |
| `403 Forbidden` | Authenticated user lacks ownership or role permission. |
| `404 Not Found` | Resource does not exist or is not visible to the caller. |
| `409 Conflict` | Duplicate email or device serial. |
| `422 Unprocessable Entity` | Schema/type validation failed. |
| `503 Service Unavailable` | Internal risk service unavailable; no risk level is claimed. |

Example error body:

```json
{
  "error": {
    "code": "FORBIDDEN",
    "message": "The selected pond does not belong to the authenticated farmer."
  }
}
```

---

## 2. Authentication

### 2.1 Register Farmer
- **API Name:** Farmer Registration
- **HTTP Method & URL:** `POST /api/v1/auth/register` **[ARCH-8]**
- **Purpose:** Create a farmer account with a hashed password (SRS FR-01, UC-01).
- **Auth/Role:** None (public).
- **Request Body:**
  ```json
  { "fullName": "Shefa Hassan Shefa", "email": "farmer@example.test", "phone": "01XXXXXXXXX", "password": "example-password" }
  ```
- **Expected HTTP Status:** `201 Created`; `400`, `409`, `422`, `500`.
- **Expected Response JSON:**
  ```json
  { "id": "11111111-1111-4111-8111-111111111111", "fullName": "Shefa Hassan Shefa", "email": "farmer@example.test", "phone": "01XXXXXXXXX", "role": "farmer", "createdAt": "2026-11-23T08:00:00Z" }
  ```
- **Related DB Table(s):** `users` (`password_hash` is persisted, never returned).

### 2.2 Login
- **API Name:** User Login
- **HTTP Method & URL:** `POST /api/v1/auth/login` **[ARCH-8]**
- **Purpose:** Authenticate a farmer or system admin and issue a signed token (FR-02, UC-02).
- **Auth/Role:** None (public).
- **Request Body:**
  ```json
  { "email": "farmer@example.test", "password": "example-password" }
  ```
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `422`.
- **Expected Response JSON:**
  ```json
  { "token": "<signed-token>", "tokenType": "Bearer", "user": { "id": "11111111-1111-4111-8111-111111111111", "fullName": "Shefa Hassan Shefa", "email": "farmer@example.test", "role": "farmer" } }
  ```
- **Related DB Table(s):** `users`.

---

## 3. User / Profile

### 3.1 Get Current Profile
- **API Name:** Get Farmer Profile
- **HTTP Method & URL:** `GET /api/v1/farmers/me` **[ARCH-8]**
- **Purpose:** Return the authenticated farmer's profile (FR-03, UC-03).
- **Auth/Role:** Authenticated Shrimp Farmer.
- **Request Body/Params:** None.
- **Expected HTTP Status:** `200 OK`; `401`, `404`.
- **Expected Response JSON:**
  ```json
  { "id": "11111111-1111-4111-8111-111111111111", "fullName": "Shefa Hassan Shefa", "email": "farmer@example.test", "phone": "01XXXXXXXXX", "role": "farmer", "createdAt": "2026-11-23T08:00:00Z", "updatedAt": "2026-11-23T08:00:00Z" }
  ```
- **Related DB Table(s):** `users`.

### 3.2 Update Current Profile
- **API Name:** Update Farmer Profile
- **HTTP Method & URL:** `PUT /api/v1/farmers/me` **[ARCH-8]**
- **Purpose:** Update full name and phone number (FR-03, UC-03).
- **Auth/Role:** Authenticated Shrimp Farmer.
- **Request Body:**
  ```json
  { "fullName": "Shefa Hassan Shefa", "phone": "01XXXXXXXXX" }
  ```
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "11111111-1111-4111-8111-111111111111", "fullName": "Shefa Hassan Shefa", "email": "farmer@example.test", "phone": "01XXXXXXXXX", "role": "farmer", "updatedAt": "2026-11-23T09:00:00Z" }
  ```
- **Related DB Table(s):** `users`.

---

## 4. Farms

### 4.1 List Farms
- **API Name:** List Owned Farms
- **HTTP Method & URL:** `GET /api/v1/farms` **[ARCH-8]**
- **Purpose:** List farms owned by the authenticated farmer (FR-04, UC-04).
- **Auth/Role:** Authenticated Shrimp Farmer.
- **Request Body/Params:** Query: `limit=20`, `offset=0` (proposed pagination).
- **Expected HTTP Status:** `200 OK`; `401`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "33333333-3333-4333-8333-333333333333", "userId": "11111111-1111-4111-8111-111111111111", "name": "Coastal Farm 1", "locationArea": "Satkhira", "area": 2.5, "areaUnit": "TBC", "createdAt": "2026-11-23T08:05:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `farms`.

### 4.2 Create Farm
- **API Name:** Create Farm
- **HTTP Method & URL:** `POST /api/v1/farms` **[ARCH-8]**
- **Purpose:** Create a farm owned by the authenticated farmer (FR-04).
- **Auth/Role:** Authenticated Shrimp Farmer.
- **Request Body:**
  ```json
  { "name": "Coastal Farm 1", "locationArea": "Satkhira", "area": 2.5, "areaUnit": "TBC" }
  ```
- **Expected HTTP Status:** `201 Created`; `400`, `401`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "33333333-3333-4333-8333-333333333333", "userId": "11111111-1111-4111-8111-111111111111", "name": "Coastal Farm 1", "locationArea": "Satkhira", "area": 2.5, "areaUnit": "TBC", "createdAt": "2026-11-23T08:05:00Z" }
  ```
- **Related DB Table(s):** `farms`.

### 4.3 Get Farm by ID
- **API Name:** Get Farm Details
- **HTTP Method & URL:** `GET /api/v1/farms/{farmId}` **[PROPOSED]**
- **Purpose:** Retrieve one owned farm detail record for editing or display (FR-04).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path: `farmId` (UUID).
- **Expected HTTP Status:** `200 OK`; `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "id": "33333333-3333-4333-8333-333333333333", "userId": "11111111-1111-4111-8111-111111111111", "name": "Coastal Farm 1", "locationArea": "Satkhira", "area": 2.5, "areaUnit": "TBC", "createdAt": "2026-11-23T08:05:00Z", "updatedAt": "2026-11-23T08:05:00Z" }
  ```
- **Related DB Table(s):** `farms`.

### 4.4 Update Farm
- **API Name:** Update Farm
- **HTTP Method & URL:** `PUT /api/v1/farms/{farmId}` **[PROPOSED]**
- **Purpose:** Edit owned farm details (FR-04).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path `farmId` (UUID); body:
  ```json
  { "name": "Coastal Farm 1", "locationArea": "Satkhira", "area": 2.75, "areaUnit": "TBC" }
  ```
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`, `404`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "33333333-3333-4333-8333-333333333333", "name": "Coastal Farm 1", "area": 2.75, "areaUnit": "TBC", "updatedAt": "2026-11-23T09:10:00Z" }
  ```
- **Related DB Table(s):** `farms`.

### 4.5 Delete Farm
- **API Name:** Delete Farm
- **HTTP Method & URL:** `DELETE /api/v1/farms/{farmId}` **[PROPOSED]**
- **Purpose:** Delete an owned farm (FR-04). The schema cascades to ponds, devices, sensors, readings, reports, and notifications.
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path: `farmId` (UUID).
- **Expected HTTP Status:** `204 No Content`; `401`, `403`, `404`, `409` (proposed guard for non-empty farms pending team decision).
- **Expected Response JSON:** No body on success.
- **Related DB Table(s):** `farms` and cascading child tables.

---

## 5. Ponds

### 5.1 List Ponds
- **API Name:** List Ponds
- **HTTP Method & URL:** `GET /api/v1/ponds` **[ARCH-8]**
- **Purpose:** List ponds in the farmer's farms or in one selected farm (FR-05, UC-04).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Query: `farmId` (UUID, optional filter), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "44444444-4444-4444-8444-444444444444", "farmId": "33333333-3333-4333-8333-333333333333", "name": "Pond A", "area": 0.5, "areaUnit": "TBC", "depth": 1.2, "depthUnit": "TBC", "status": "active", "stockingDate": "2026-10-01", "createdAt": "2026-11-23T08:10:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `ponds`, `farms`.

### 5.2 Create Pond
- **API Name:** Create Pond
- **HTTP Method & URL:** `POST /api/v1/ponds` **[ARCH-8]**
- **Purpose:** Create a pond under an owned farm (FR-05).
- **Auth/Role:** Authenticated Shrimp Farmer; farm ownership enforced.
- **Request Body:**
  ```json
  { "farmId": "33333333-3333-4333-8333-333333333333", "name": "Pond A", "area": 0.5, "areaUnit": "TBC", "depth": 1.2, "depthUnit": "TBC", "status": "active", "stockingDate": "2026-10-01" }
  ```
- **Expected HTTP Status:** `201 Created`; `400`, `401`, `403`, `404`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "44444444-4444-4444-8444-444444444444", "farmId": "33333333-3333-4333-8333-333333333333", "name": "Pond A", "status": "active", "createdAt": "2026-11-23T08:10:00Z" }
  ```
- **Related DB Table(s):** `ponds`, `farms`.

### 5.3 Get Pond by ID
- **API Name:** Get Pond Details
- **HTTP Method & URL:** `GET /api/v1/ponds/{pondId}` **[PROPOSED]**
- **Purpose:** Retrieve one owned pond detail record (FR-05, UC-08).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path: `pondId` (UUID).
- **Expected HTTP Status:** `200 OK`; `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "id": "44444444-4444-4444-8444-444444444444", "farmId": "33333333-3333-4333-8333-333333333333", "name": "Pond A", "area": 0.5, "areaUnit": "TBC", "depth": 1.2, "depthUnit": "TBC", "status": "active", "stockingDate": "2026-10-01", "updatedAt": "2026-11-23T08:10:00Z" }
  ```
- **Related DB Table(s):** `ponds`, `farms`.

### 5.4 Update Pond
- **API Name:** Update Pond
- **HTTP Method & URL:** `PUT /api/v1/ponds/{pondId}` **[PROPOSED]**
- **Purpose:** Edit pond details or archive a pond using `status: "archived"` (FR-05).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path `pondId`; body:
  ```json
  { "name": "Pond A", "area": 0.5, "areaUnit": "TBC", "depth": 1.2, "depthUnit": "TBC", "status": "inactive", "stockingDate": "2026-10-01" }
  ```
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`, `404`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "44444444-4444-4444-8444-444444444444", "name": "Pond A", "status": "inactive", "updatedAt": "2026-11-23T09:15:00Z" }
  ```
- **Related DB Table(s):** `ponds`.

### 5.5 Delete Pond
- **API Name:** Delete Pond
- **HTTP Method & URL:** `DELETE /api/v1/ponds/{pondId}` **[PROPOSED]**
- **Purpose:** Delete an owned pond. The schema cascades to devices, sensors, sensor readings, manual readings, risk reports, and nullifies notification pond references.
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path: `pondId` (UUID).
- **Expected HTTP Status:** `204 No Content`; `401`, `403`, `404`.
- **Expected Response JSON:** No body on success.
- **Related DB Table(s):** `ponds` and dependent tables.

---

## 6. Devices

### 6.1 List Devices
- **API Name:** List Devices
- **HTTP Method & URL:** `GET /api/v1/devices` **[ARCH-8]**
- **Purpose:** List ESP32 devices registered to the farmer's ponds (FR-06, FR-07).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Query: `pondId` (UUID, optional), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "55555555-5555-4555-8555-555555555555", "pondId": "44444444-4444-4444-8444-444444444444", "deviceSerial": "ESP32-TBC-001", "name": "Pond A ESP32", "status": "online", "lastSeenAt": "2026-11-23T08:30:00Z", "createdAt": "2026-11-23T08:12:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `devices`, `ponds`.

### 6.2 Register Device
- **API Name:** Register ESP32 Device
- **HTTP Method & URL:** `POST /api/v1/devices` **[SRS]**
- **Purpose:** Register an ESP32 serial and associate it with an owned pond (FR-06, UC-05).
- **Auth/Role:** Authenticated Shrimp Farmer; pond ownership enforced.
- **Request Body:**
  ```json
  { "pondId": "44444444-4444-4444-8444-444444444444", "deviceSerial": "ESP32-TBC-001", "name": "Pond A ESP32" }
  ```
- **Expected HTTP Status:** `201 Created`; `400`, `401`, `403`, `404`, `409`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "55555555-5555-4555-8555-555555555555", "pondId": "44444444-4444-4444-8444-444444444444", "deviceSerial": "ESP32-TBC-001", "name": "Pond A ESP32", "status": "unknown", "createdAt": "2026-11-23T08:12:00Z" }
  ```
- **Related DB Table(s):** `devices`, `ponds`.

### 6.3 Get Device by ID
- **API Name:** Get Device Details
- **HTTP Method & URL:** `GET /api/v1/devices/{deviceId}` **[PROPOSED]**
- **Purpose:** Retrieve one registered device and its connection status for the Bluetooth screen (UC-05).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced.
- **Request Body/Params:** Path: `deviceId` (UUID).
- **Expected HTTP Status:** `200 OK`; `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "id": "55555555-5555-4555-8555-555555555555", "pondId": "44444444-4444-4444-8444-444444444444", "deviceSerial": "ESP32-TBC-001", "name": "Pond A ESP32", "status": "online", "lastSeenAt": "2026-11-23T08:30:00Z" }
  ```
- **Related DB Table(s):** `devices`, `ponds`, `sensors` (registered sensor metadata may be included by a future detail view).

---

## 7. Sensor Readings (ESP32)

> These readings originate from the ESP32's pH, dissolved oxygen, temperature, and salinity sensors over Bluetooth. Ammonia is **not** included here; it is a manual test-kit reading.

### 7.1 Ingest Sensor Reading
- **API Name:** Create Sensor Reading
- **HTTP Method & URL:** `POST /api/v1/readings` **[ARCH-8]**
- **Purpose:** Store a complete, validated sensor payload from the Flutter app (FR-08, FR-09, FR-11, UC-06).
- **Auth/Role:** Authenticated Shrimp Farmer; device-to-pond ownership enforced.
- **Request Body:**
  ```json
  {
    "deviceId": "55555555-5555-4555-8555-555555555555",
    "qualityFlag": "valid",
    "values": [
      { "parameter": "ph", "value": 6.8, "recordedAt": "2026-11-23T08:30:00Z" },
      { "parameter": "dissolved_oxygen", "value": 5.2, "recordedAt": "2026-11-23T08:30:00Z" },
      { "parameter": "temperature", "value": 28.5, "recordedAt": "2026-11-23T08:30:00Z" },
      { "parameter": "salinity", "value": 12.0, "recordedAt": "2026-11-23T08:30:00Z" }
    ]
  }
  ```
  The parameter list resolves to registered `sensors.id` UUIDs for that device. Units are held in `sensors.unit` and remain TBC. `turbidity` is future scope and is not accepted in the current planned payload.
- **Expected HTTP Status:** `201 Created`; `400`, `401`, `403`, `404`, `422`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": 1024, "sensorId": "66666666-6666-4666-8666-666666666666", "parameter": "ph", "value": 6.8, "unit": "TBC", "qualityFlag": "valid", "recordedAt": "2026-11-23T08:30:00Z", "createdAt": "2026-11-23T08:31:00Z" } ] }
  ```
- **Related DB Table(s):** `sensor_readings` (`id` is `bigint`), `sensors`, `devices`, `ponds`.

### 7.2 Get Reading History
- **API Name:** Get Historical Readings
- **HTTP Method & URL:** `GET /api/v1/readings/history` **[ARCH-8]**
- **Purpose:** Retrieve pond-level history by parameter and time range for charts and trend views (FR-12, FR-13, UC-08).
- **Auth/Role:** Authenticated Shrimp Farmer; ownership enforced. Admin history access is provided through the read-only `GET /api/v1/admin/monitoring/readings` endpoint.
- **Request Body/Params:** Query: `pondId` (UUID, required), `parameter` (`ph` | `dissolved_oxygen` | `temperature` | `salinity`), `from` (ISO 8601), `to` (ISO 8601), `limit=100`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": 1024, "sensorId": "66666666-6666-4666-8666-666666666666", "parameter": "ph", "value": 6.8, "unit": "TBC", "qualityFlag": "valid", "recordedAt": "2026-11-23T08:30:00Z" } ], "limit": 100, "offset": 0 }
  ```
- **Related DB Table(s):** `sensor_readings`, `sensors`, `devices`, `ponds`.

---

## 8. Manual Test Readings (Ammonia)

### 8.1 Create Manual Reading
- **API Name:** Create Manual Ammonia Reading
- **HTTP Method & URL:** `POST /api/v1/readings/manual` **[ARCH-8]**
- **Purpose:** Store a farmer-entered ammonia test-kit result for a pond (FR-10, FR-11, UC-07).
- **Auth/Role:** Authenticated Shrimp Farmer; pond ownership enforced.
- **Request Body:**
  ```json
  { "pondId": "44444444-4444-4444-8444-444444444444", "parameter": "ammonia", "value": 0.25, "unit": "TBC", "testKitName": "TBC", "notes": "Morning test", "recordedAt": "2026-11-23T08:35:00Z" }
  ```
  `recorded_by` is set server-side from the authenticated user. `test_kit_name` and `notes` are nullable in the schema.
- **Expected HTTP Status:** `201 Created`; `400`, `401`, `403`, `404`, `422`.
- **Expected Response JSON:**
  ```json
  { "id": "77777777-7777-4777-8777-777777777777", "pondId": "44444444-4444-4444-8444-444444444444", "recordedBy": "11111111-1111-4111-8111-111111111111", "parameter": "ammonia", "value": 0.25, "unit": "TBC", "testKitName": "TBC", "notes": "Morning test", "recordedAt": "2026-11-23T08:35:00Z", "createdAt": "2026-11-23T08:36:00Z" }
  ```
- **Related DB Table(s):** `manual_test_readings`, `ponds`, `users`.

### 8.2 List Manual Readings
- **API Name:** List Manual Test Readings
- **HTTP Method & URL:** `GET /api/v1/manual-test-readings` **[PROPOSED]**
- **Purpose:** List ammonia test-kit history for a pond, kept separate from sensor history (FR-11, FR-12, UC-08).
- **Auth/Role:** Authenticated Shrimp Farmer; pond ownership enforced.
- **Request Body/Params:** Query: `pondId` (UUID, required), `parameter=ammonia`, `from`, `to`, `limit=100`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "77777777-7777-4777-8777-777777777777", "pondId": "44444444-4444-4444-8444-444444444444", "recordedBy": "11111111-1111-4111-8111-111111111111", "parameter": "ammonia", "value": 0.25, "unit": "TBC", "recordedAt": "2026-11-23T08:35:00Z" } ], "limit": 100, "offset": 0 }
  ```
- **Related DB Table(s):** `manual_test_readings`, `ponds`.

---

## 9. Risk Analysis

### 9.1 Request Risk Analysis (Public Node.js API)
- **API Name:** Request Environmental Risk Analysis
- **HTTP Method & URL:** `POST /api/v1/risk/analyze` **[ARCH-8]**
- **Purpose:** Ask Node.js to gather pond context/history, call the internal risk service, persist the report, and return the result (FR-14, FR-16, FR-19, UC-09).
- **Auth/Role:** Authenticated Shrimp Farmer; pond ownership enforced.
- **Request Body:**
  ```json
  { "pondId": "44444444-4444-4444-8444-444444444444" }
  ```
  Node.js, not the client, selects the recent sensor/manual readings and history to send to FastAPI.
- **Expected HTTP Status:** `200 OK` (including `not_configured` and `pending` states); `400`, `401`, `403`, `404`, `422`, `503`.
- **Expected Response JSON — success with AI text:**
  ```json
  {
    "status": "ok",
    "report": {
      "id": "88888888-8888-4888-8888-888888888888",
      "pondId": "44444444-4444-4444-8444-444444444444",
      "riskLevel": "moderate",
      "riskScore": 55.0,
      "summary": "One configured parameter is outside its validated range.",
      "factors": { "items": [ { "parameter": "ph", "value": 6.8, "status": "below_range", "message": "pH below the configured range" } ] },
      "analysisEngine": "rules-v0",
      "explanationBn": "অনুগ্রহ করে পাঠ্য যাচাই করুন।",
      "recommendationsBn": "অনুগ্রহ করে স্থানীয় বিশেষজ্ঞের পরামর্শ নিন।",
      "modelVersion": "rules-v0",
      "generatedAt": "2026-11-23T08:40:00Z"
    },
    "notificationCreated": true
  }
  ```
  Bengali strings above are structural placeholders, not approved farmer-facing content. `status`, `message`, and `notificationCreated` are response-only fields derived from the stored report and notification state; they are not database columns.
- **Expected Response JSON — thresholds not configured (no stored report):**
  ```json
  { "status": "not_configured", "report": null, "message": "Expert-validated thresholds are not configured. No risk level was assigned.", "notificationCreated": false }
  ```
- **Expected Response JSON — FastAPI unavailable:**
  ```json
  { "status": "pending", "report": null, "message": "Readings are stored. Risk analysis is pending; no risk level was assigned.", "notificationCreated": false }
  ```
- **Related DB Table(s):** `ponds`, `sensor_readings`, `manual_test_readings`, `risk_reports`, `notifications`.

### 9.2 Analyze — Internal Python/FastAPI Service
- **API Name:** Internal Rule-Based Risk Analysis
- **HTTP Method & URL:** `POST /analyze` **[ARCH-8]**
- **Purpose:** Evaluate readings with configured rules, trends, and anomalies; return a validated risk result before any Gemini call (FR-15, FR-17).
- **Auth/Role:** Internal service-to-service only. Node.js is the sole caller; Flutter and React must not call it. Network-level isolation is a deployment requirement, not a client feature.
- **Request Body:** Sent by Node.js using validated data:
  ```json
  {
    "pond_id": "44444444-4444-4444-8444-444444444444",
    "readings": {
      "ph": { "value": 6.8, "unit": "TBC", "recorded_at": "2026-11-23T08:30:00Z", "source": "sensor" },
      "ammonia": { "value": 0.25, "unit": "TBC", "recorded_at": "2026-11-23T08:35:00Z", "source": "manual" }
    },
    "history": [ { "parameter": "ph", "value": 6.9, "recorded_at": "2026-11-23T07:30:00Z" } ],
    "pond_context": { "pond_id": "44444444-4444-4444-8444-444444444444" },
    "language": "bn"
  }
  ```
  The current foundation schema also accepts `dissolved_oxygen`, `temperature`, and `salinity` keys with `source: "sensor"`.
- **Expected HTTP Status:** `200 OK` with `status: "ok"` or `status: "not_configured"`; `422 Unprocessable Entity`; `500` on unhandled service failure.
- **Expected Response JSON:**
  ```json
  {
    "status": "ok",
    "risk_level": "moderate",
    "risk_score": 55.0,
    "summary": "One configured parameter is outside its validated range.",
    "factors": [ { "parameter": "ph", "value": 6.8, "unit": "TBC", "status": "below_range", "message": "pH below the configured range" } ],
    "trends": [ { "parameter": "ph", "direction": "stable", "message": "Insufficient trend evidence" } ],
    "anomalies": [],
    "recommendations": [ { "title": "Verify and consult an expert", "description_bn": "অনুগ্রহ করে পরিমাপ যাচাই করুন।", "priority": "high", "category": "expert_consultation" } ],
    "explanation_bn": "অনুগ্রহ করে পাঠ্য যাচাই করুন।",
    "analysis_engine": "rules-v0",
    "generated_at": "2026-11-23T08:40:00Z"
  }
  ```
  Field names follow the FastAPI `AnalyzeResponse` model (`snake_case`). If thresholds are unavailable, `status` is `not_configured` and `risk_level` is `null`. If Gemini is unavailable, `explanation_bn` is `null` while the rule-based fields remain unchanged.
- **Related DB Table(s):** None directly; the service analyzes data supplied by Node.js. Node.js persists the result to `risk_reports`.

### 9.3 Internal FastAPI Health
- **API Name:** Risk Service Health
- **HTTP Method & URL:** `GET /health` **[ARCH-8]**
- **Purpose:** Allow Node.js/deployment monitoring to check internal service availability.
- **Auth/Role:** Internal only; not exposed to Flutter or React.
- **Request Body/Params:** None.
- **Expected HTTP Status:** `200 OK`.
- **Expected Response JSON:**
  ```json
  { "status": "ok", "service": "shrimguard-risk-service", "version": "0.1.0", "gemini_configured": true, "thresholds_configured": true }
  ```
- **Related DB Table(s):** None.

---

## 10. Risk Reports

### 10.1 List Risk Reports
- **API Name:** List Risk Reports
- **HTTP Method & URL:** `GET /api/v1/risk/reports` **[ARCH-8]**
- **Purpose:** List stored analysis reports for a pond with Bengali text where available (FR-16, FR-18, UC-10).
- **Auth/Role:** Authenticated Shrimp Farmer; pond ownership enforced.
- **Request Body/Params:** Query: `pondId` (UUID, required), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "88888888-8888-4888-8888-888888888888", "pondId": "44444444-4444-4444-8444-444444444444", "riskLevel": "moderate", "riskScore": 55.0, "summary": "One configured parameter is outside its validated range.", "explanationBn": "অনুগ্রহ করে পাঠ্য যাচাই করুন।", "recommendationsBn": "অনুগ্রহ করে স্থানীয় বিশেষজ্ঞের পরামর্শ নিন।", "generatedAt": "2026-11-23T08:40:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `risk_reports`, `ponds`.

### 10.2 Get Risk Report by ID
- **API Name:** Get Risk Report Details
- **HTTP Method & URL:** `GET /api/v1/risk/reports/{reportId}` **[PROPOSED]**
- **Purpose:** Retrieve one report including factors, analysis engine, model version, and Bengali text or its unavailable state (UC-10).
- **Auth/Role:** Authenticated Shrimp Farmer; report/pond ownership enforced.
- **Request Body/Params:** Path: `reportId` (UUID).
- **Expected HTTP Status:** `200 OK`; `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "id": "88888888-8888-4888-8888-888888888888", "pondId": "44444444-4444-4444-8444-444444444444", "riskLevel": "moderate", "riskScore": 55.0, "summary": "One configured parameter is outside its validated range.", "factors": { "items": [ { "parameter": "ph", "value": 6.8, "status": "below_range", "message": "pH below the configured range" } ] }, "analysisEngine": "rules-v0", "explanationBn": null, "recommendationsBn": null, "aiTextStatus": "unavailable", "modelVersion": "rules-v0", "generatedAt": "2026-11-23T08:40:00Z" }
  ```
  `aiTextStatus` is a proposed response-only field derived from the nullable Bengali columns; it is **not** a database column.
- **Related DB Table(s):** `risk_reports`, `ponds`.

---

## 11. Notifications

### 11.1 List Notifications
- **API Name:** List Notifications
- **HTTP Method & URL:** `GET /api/v1/notifications` **[ARCH-8]**
- **Purpose:** List in-app notifications for the authenticated user (FR-20, UC-11).
- **Auth/Role:** Authenticated Shrimp Farmer. Admin notification viewing is provided through the read-only Admin Monitoring endpoints in Section 12.
- **Request Body/Params:** Query: `isRead=false`, `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "99999999-9999-4999-8999-999999999999", "userId": "11111111-1111-4111-8111-111111111111", "pondId": "44444444-4444-4444-8444-444444444444", "riskReportId": "88888888-8888-4888-8888-888888888888", "title": "Water-quality risk detected", "message": "Review the latest pond risk report.", "channel": "in_app", "isRead": false, "sentAt": "2026-11-23T08:41:00Z", "createdAt": "2026-11-23T08:41:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `notifications`, `users`, `ponds`, `risk_reports`.

### 11.2 Mark Notification as Read
- **API Name:** Mark Notification Read
- **HTTP Method & URL:** `PATCH /api/v1/notifications/{notificationId}/read` **[PROPOSED]**
- **Purpose:** Update `is_read` for the authenticated farmer's own notification (FR-20, UC-11).
- **Auth/Role:** Authenticated Shrimp Farmer; notification ownership enforced. **Not exposed to the admin role** in this design because Admin Monitoring is strictly read-only.
- **Request Body/Params:** Path: `notificationId` (UUID); no body.
- **Expected HTTP Status:** `200 OK`; `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "id": "99999999-9999-4999-8999-999999999999", "isRead": true, "createdAt": "2026-11-23T08:41:00Z" }
  ```
- **Related DB Table(s):** `notifications`.

---

## 12. Admin Monitoring (Read-Only)

All endpoints in this section are **[PROPOSED]** design decisions for the React dashboard and are `GET` only. They satisfy UC-12/FR-21 and the SRS actor associations for UC-08 and UC-11 without granting record mutation. The exact scope of admin data visibility remains **To Be Confirmed**. No admin may call create, update, or delete endpoints in this design.

### 12.1 Get Monitoring Summary
- **API Name:** Admin Monitoring Summary
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/summary` **[PROPOSED]**
- **Purpose:** Return counts for dashboard overview cards (UC-12).
- **Auth/Role:** System Admin only.
- **Request Body/Params:** None.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "farms": 4, "ponds": 12, "devices": 10, "sensorReadings": 3580, "manualTestReadings": 42, "riskReports": 96, "notifications": 18 }
  ```
- **Related DB Table(s):** all nine tables (aggregate reads only).

### 12.2 Monitor Farms
- **API Name:** Admin Monitor Farms
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/farms` **[PROPOSED]**
- **Purpose:** Read-only farm monitoring list.
- **Auth/Role:** System Admin only.
- **Request Body/Params:** Query: `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "33333333-3333-4333-8333-333333333333", "userId": "11111111-1111-4111-8111-111111111111", "name": "Coastal Farm 1", "locationArea": "Satkhira", "createdAt": "2026-11-23T08:05:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `farms`, `users`.

### 12.3 Monitor Ponds
- **API Name:** Admin Monitor Ponds
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/ponds` **[PROPOSED]**
- **Purpose:** Read-only pond monitoring list, including historical view support for UC-08.
- **Auth/Role:** System Admin only.
- **Request Body/Params:** Query: `farmId` (optional UUID), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "44444444-4444-4444-8444-444444444444", "farmId": "33333333-3333-4333-8333-333333333333", "name": "Pond A", "status": "active", "stockingDate": "2026-10-01" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `ponds`, `farms`.

### 12.4 Monitor Devices
- **API Name:** Admin Monitor Devices
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/devices` **[PROPOSED]**
- **Purpose:** Read-only device status list.
- **Auth/Role:** System Admin only.
- **Request Body/Params:** Query: `pondId` (optional UUID), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "55555555-5555-4555-8555-555555555555", "pondId": "44444444-4444-4444-8444-444444444444", "deviceSerial": "ESP32-TBC-001", "status": "online", "lastSeenAt": "2026-11-23T08:30:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `devices`, `ponds`.

### 12.5 Monitor Readings
- **API Name:** Admin Monitor Readings
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/readings` **[PROPOSED]**
- **Purpose:** Read-only sensor and manual reading monitoring for charts and detail views (UC-08).
- **Auth/Role:** System Admin only.
- **Request Body/Params:** Query: `pondId` (UUID, required), `source=sensor|manual`, `parameter`, `from`, `to`, `limit=100`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`, `404`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "source": "sensor", "id": 1024, "sensorId": "66666666-6666-4666-8666-666666666666", "parameter": "ph", "value": 6.8, "qualityFlag": "valid", "recordedAt": "2026-11-23T08:30:00Z" }, { "source": "manual", "id": "77777777-7777-4777-8777-777777777777", "parameter": "ammonia", "value": 0.25, "unit": "TBC", "recordedAt": "2026-11-23T08:35:00Z" } ], "limit": 100, "offset": 0 }
  ```
- **Related DB Table(s):** `sensor_readings`, `manual_test_readings`, `sensors`, `devices`, `ponds`.

### 12.6 Monitor Risk Reports
- **API Name:** Admin Monitor Risk Reports
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/risk-reports` **[PROPOSED]**
- **Purpose:** Read-only risk report review, including Bengali text state (UC-12).
- **Auth/Role:** System Admin only.
- **Request Body/Params:** Query: `pondId` (optional UUID), `riskLevel` (`low` | `moderate` | `high` | `critical`), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `400`, `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "88888888-8888-4888-8888-888888888888", "pondId": "44444444-4444-4444-8444-444444444444", "riskLevel": "moderate", "riskScore": 55.0, "analysisEngine": "rules-v0", "explanationBn": null, "recommendationsBn": null, "generatedAt": "2026-11-23T08:40:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `risk_reports`, `ponds`.

### 12.7 Monitor Notifications
- **API Name:** Admin Monitor Notifications
- **HTTP Method & URL:** `GET /api/v1/admin/monitoring/notifications` **[PROPOSED]**
- **Purpose:** Read-only notification review for oversight (UC-11, UC-12).
- **Auth/Role:** System Admin only.
- **Request Body/Params:** Query: `isRead` (optional boolean), `pondId` (optional UUID), `limit=20`, `offset=0`.
- **Expected HTTP Status:** `200 OK`; `401`, `403`.
- **Expected Response JSON:**
  ```json
  { "items": [ { "id": "99999999-9999-4999-8999-999999999999", "userId": "11111111-1111-4111-8111-111111111111", "pondId": "44444444-4444-4444-8444-444444444444", "riskReportId": "88888888-8888-4888-8888-888888888888", "title": "Water-quality risk detected", "channel": "in_app", "isRead": false, "createdAt": "2026-11-23T08:41:00Z" } ], "limit": 20, "offset": 0 }
  ```
- **Related DB Table(s):** `notifications`, `users`, `ponds`, `risk_reports`.

---

## 13. Service Boundary and Security Notes

1. **Public vs internal:** `/api/v1/**` belongs to Node.js/Express. `POST /analyze` and `GET /health` belong to the internal Python/FastAPI service and are called only by Node.js.
2. **No direct client access:** Flutter and React have no FastAPI base URL and no Gemini credentials. This is both an application rule and a deployment/firewall requirement.
3. **Gemini key handling:** the key is used server-side by the risk service for text generation only. It is never returned in `/analyze`, `/risk/analyze`, report responses, or logs.
4. **Validation and ownership:** Node.js validates every request before database access and enforces farmer ownership on farms, ponds, devices, readings, reports, and notifications.
5. **Data separation:** ESP32 sensor data goes to `sensor_readings`; manual ammonia data goes to `manual_test_readings`. Neither endpoint accepts the other source.
6. **Incomplete analysis:** `not_configured` and `pending` responses carry no risk level and create no `risk_reports` row, because `risk_level` is `NOT NULL`.
7. **AI fallback:** Gemini failure preserves the rule-based risk level; the Bengali fields remain `null` and clients display an unavailable/pending state.
8. **Planned status:** these endpoints describe intended design. Current skeleton routes mostly return `501 Not Implemented`, and admin endpoints are not yet present in the repository.
