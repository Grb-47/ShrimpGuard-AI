# ShrimpGuard AI — Entity Relationship Diagram

**Course:** CSE4104
**Assignment:** Week 03
**Official Team Name:** CSE4104-7C-T04
**Section:** 7C
**Project Title:** ShrimpGuard AI — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System

---

## 1. Source

This diagram is copied from the existing Week 02 database design document:

- Source file: `docs/architecture/DATABASE_DESIGN.md`
- Source section: Section 2, Entity–Relationship Diagram
- Schema version: 001 (foundation)
- Canonical DDL: `database/schema/001_initial_schema.sql`

The Mermaid code below is reproduced verbatim from the existing Week 02 document. It was not recreated or redesigned for Week 03.

## 2. Entity–Relationship Diagram

```mermaid
erDiagram
    USERS ||--o{ FARMS : owns
    USERS ||--o{ NOTIFICATIONS : receives
    USERS ||--o{ MANUAL_TEST_READINGS : records
    USERS ||--o{ CALIBRATION_RECORDS : performs

    FARMS ||--o{ PONDS : contains
    PONDS ||--o{ DEVICES : has
    PONDS ||--o{ MANUAL_TEST_READINGS : has
    PONDS ||--o{ RISK_REPORTS : produces
    PONDS ||--o{ NOTIFICATIONS : relates_to

    DEVICES ||--o{ SENSORS : hosts
    SENSORS ||--o{ SENSOR_READINGS : measures
    SENSORS ||--o{ CALIBRATION_RECORDS : calibrated_by

    RISK_REPORTS ||--o{ RECOMMENDATIONS : includes
    RISK_REPORTS ||--o{ NOTIFICATIONS : triggers

    USERS {
        uuid id PK
        text full_name
        text email UK
        text phone
        text password_hash
        text role
        timestamptz created_at
        timestamptz updated_at
    }

    FARMS {
        uuid id PK
        uuid user_id FK
        text name
        text address
        text location_area
        numeric area
        text area_unit
        numeric latitude
        numeric longitude
        timestamptz created_at
        timestamptz updated_at
    }

    PONDS {
        uuid id PK
        uuid farm_id FK
        text name
        numeric area
        text area_unit
        numeric depth
        text depth_unit
        text status
        date stocking_date
        timestamptz created_at
        timestamptz updated_at
    }

    DEVICES {
        uuid id PK
        uuid pond_id FK
        text device_serial UK
        text name
        text firmware_version
        text status
        timestamptz last_seen_at
        timestamptz created_at
        timestamptz updated_at
    }

    SENSORS {
        uuid id PK
        uuid device_id FK
        text sensor_type
        text model
        text unit
        text calibration_status
        boolean is_active
        timestamptz created_at
        timestamptz updated_at
    }

    SENSOR_READINGS {
        bigint id PK
        uuid sensor_id FK
        numeric value
        text quality_flag
        timestamptz recorded_at
        timestamptz created_at
    }

    MANUAL_TEST_READINGS {
        uuid id PK
        uuid pond_id FK
        uuid recorded_by FK
        text parameter
        numeric value
        text unit
        text test_kit_name
        text notes
        timestamptz recorded_at
        timestamptz created_at
    }

    RISK_REPORTS {
        uuid id PK
        uuid pond_id FK
        text risk_level
        numeric risk_score
        text summary
        text analysis_engine
        text gemini_explanation
        text model_version
        jsonb factors
        timestamptz generated_at
        timestamptz created_at
    }

    RECOMMENDATIONS {
        uuid id PK
        uuid risk_report_id FK
        text title
        text description_bn
        text description_en
        text priority
        text category
        timestamptz created_at
    }

    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        uuid pond_id FK
        uuid risk_report_id FK
        text title
        text message
        text channel
        boolean is_read
        timestamptz sent_at
        timestamptz created_at
    }

    CALIBRATION_RECORDS {
        uuid id PK
        uuid sensor_id FK
        uuid calibrated_by FK
        text calibration_type
        text reference_solution
        numeric before_value
        numeric after_value
        numeric temperature
        text notes
        timestamptz calibrated_at
        timestamptz next_due_at
        timestamptz created_at
    }
```

## 3. Brief Explanation

The diagram models the core data relationships of ShrimpGuard AI:

1. **User ownership:** A `USERS` record represents a farmer or administrator. One user may own many `FARMS`.
2. **Farm and pond hierarchy:** A farm contains many `PONDS`. The pond is the main unit of environmental monitoring.
3. **Device and sensor hierarchy:** A pond may have many `DEVICES`, and each ESP32 device may host many `SENSORS`. Each sensor produces many `SENSOR_READINGS`.
4. **Manual readings:** `MANUAL_TEST_READINGS` are linked directly to a pond and a recording user. They are intentionally separate from automatic sensor readings so that manual ammonia results remain distinguishable.
5. **Risk analysis trail:** Each pond may produce many `RISK_REPORTS`. A risk report contains the validated risk level, score, summary, analysis engine, model version, structured factors, and optional Gemini explanation.
6. **Recommendations and notifications:** A risk report may include many `RECOMMENDATIONS` and may trigger many `NOTIFICATIONS`. Notifications are also linked to a user and may reference a pond or risk report.
7. **Calibration history:** `CALIBRATION_RECORDS` preserve the calibration history for each sensor and record the user who performed the calibration.

The diagram is consistent with the established AI boundary: the risk report stores the rule-based analysis metadata and, separately, the optional Gemini explanation. The explanation is not the source of the risk classification.
