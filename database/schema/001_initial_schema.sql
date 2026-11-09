-- ============================================================
-- ShrimpGuard AI - Initial PostgreSQL Schema (Version 001)
-- Team: CSE4104-7C-T04
-- Database: PostgreSQL
--
-- Canonical DDL for:
--   users, farms, ponds, devices, sensors, sensor_readings,
--   manual_test_readings, risk_reports, recommendations,
--   notifications, calibration_records
--
-- NOTE: Sensor models, units, ranges, and calibration values are
-- intentionally not hard-coded. Unknown specifications are stored
-- as free text until confirmed.
-- ============================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ---------- Enumerated types ----------

CREATE TYPE user_role AS ENUM ('farmer', 'admin');

CREATE TYPE pond_status AS ENUM ('active', 'inactive', 'archived');

CREATE TYPE device_status AS ENUM ('online', 'offline', 'maintenance', 'unknown');

CREATE TYPE sensor_type AS ENUM (
    'ph',
    'dissolved_oxygen',
    'temperature',
    'salinity',
    'turbidity'
);

CREATE TYPE calibration_status AS ENUM (
    'uncalibrated',
    'calibrated',
    'due',
    'overdue'
);

CREATE TYPE reading_quality AS ENUM ('valid', 'suspect', 'invalid');

CREATE TYPE risk_level AS ENUM ('low', 'moderate', 'high', 'critical');

CREATE TYPE priority_level AS ENUM ('low', 'medium', 'high', 'urgent');

CREATE TYPE notification_channel AS ENUM ('in_app', 'push', 'sms');

-- ---------- Shared updated_at trigger ----------

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ---------- Users ----------

CREATE TABLE users (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name       TEXT NOT NULL,
    email           TEXT NOT NULL UNIQUE,
    phone           TEXT,
    password_hash   TEXT NOT NULL,
    role            user_role NOT NULL DEFAULT 'farmer',
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER trg_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ---------- Farms ----------

CREATE TABLE farms (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name            TEXT NOT NULL,
    address         TEXT,
    location_area   TEXT,
    area            NUMERIC(12, 2) CHECK (area IS NULL OR area >= 0),
    area_unit       TEXT,
    latitude        NUMERIC(9, 6),
    longitude       NUMERIC(9, 6),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_farms_user_id ON farms(user_id);

CREATE TRIGGER trg_farms_updated_at
BEFORE UPDATE ON farms
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ---------- Ponds ----------

CREATE TABLE ponds (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    farm_id         UUID NOT NULL REFERENCES farms(id) ON DELETE CASCADE,
    name            TEXT NOT NULL,
    area            NUMERIC(12, 2) CHECK (area IS NULL OR area >= 0),
    area_unit       TEXT,
    depth           NUMERIC(12, 2) CHECK (depth IS NULL OR depth >= 0),
    depth_unit      TEXT,
    status          pond_status NOT NULL DEFAULT 'active',
    stocking_date   DATE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ponds_farm_id ON ponds(farm_id);

CREATE TRIGGER trg_ponds_updated_at
BEFORE UPDATE ON ponds
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ---------- Devices ----------

CREATE TABLE devices (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pond_id           UUID NOT NULL REFERENCES ponds(id) ON DELETE CASCADE,
    device_serial     TEXT NOT NULL UNIQUE,
    name              TEXT,
    firmware_version  TEXT,
    status            device_status NOT NULL DEFAULT 'unknown',
    last_seen_at      TIMESTAMPTZ,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_devices_pond_id ON devices(pond_id);

CREATE TRIGGER trg_devices_updated_at
BEFORE UPDATE ON devices
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ---------- Sensors ----------

CREATE TABLE sensors (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id           UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    sensor_type         sensor_type NOT NULL,
    model               TEXT,
    unit                TEXT,
    calibration_status  calibration_status NOT NULL DEFAULT 'uncalibrated',
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_sensors_device_type UNIQUE (device_id, sensor_type)
);

CREATE INDEX idx_sensors_device_id ON sensors(device_id);

CREATE TRIGGER trg_sensors_updated_at
BEFORE UPDATE ON sensors
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ---------- Sensor readings ----------

CREATE TABLE sensor_readings (
    id            BIGSERIAL PRIMARY KEY,
    sensor_id     UUID NOT NULL REFERENCES sensors(id) ON DELETE CASCADE,
    value         NUMERIC(12, 4) NOT NULL,
    quality_flag  reading_quality NOT NULL DEFAULT 'valid',
    recorded_at   TIMESTAMPTZ NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_sensor_readings_sensor_time
    ON sensor_readings(sensor_id, recorded_at DESC);

CREATE INDEX idx_sensor_readings_recorded_at
    ON sensor_readings(recorded_at DESC);

-- ---------- Manual test readings ----------

CREATE TABLE manual_test_readings (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pond_id         UUID NOT NULL REFERENCES ponds(id) ON DELETE CASCADE,
    recorded_by     UUID REFERENCES users(id) ON DELETE SET NULL,
    parameter       TEXT NOT NULL,
    value           NUMERIC(12, 4) NOT NULL,
    unit            TEXT NOT NULL,
    test_kit_name   TEXT,
    notes           TEXT,
    recorded_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_manual_readings_pond_time
    ON manual_test_readings(pond_id, recorded_at DESC);

CREATE INDEX idx_manual_readings_recorded_by
    ON manual_test_readings(recorded_by);

-- ---------- Risk reports ----------

CREATE TABLE risk_reports (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pond_id             UUID NOT NULL REFERENCES ponds(id) ON DELETE CASCADE,
    risk_level          risk_level NOT NULL,
    risk_score          NUMERIC(5, 2) CHECK (
                            risk_score IS NULL OR (risk_score >= 0 AND risk_score <= 100)
                        ),
    summary             TEXT,
    factors             JSONB NOT NULL DEFAULT '{}'::jsonb,
    analysis_engine     TEXT NOT NULL DEFAULT 'rules-v0',
    gemini_explanation  TEXT,
    model_version       TEXT,
    generated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_risk_reports_pond_time
    ON risk_reports(pond_id, generated_at DESC);

CREATE INDEX idx_risk_reports_level
    ON risk_reports(risk_level);

-- ---------- Recommendations ----------

CREATE TABLE recommendations (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    risk_report_id   UUID NOT NULL REFERENCES risk_reports(id) ON DELETE CASCADE,
    title            TEXT NOT NULL,
    description_bn   TEXT,
    description_en   TEXT,
    priority         priority_level NOT NULL DEFAULT 'medium',
    category         TEXT,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_recommendations_report_id
    ON recommendations(risk_report_id);

-- ---------- Notifications ----------

CREATE TABLE notifications (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id          UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    pond_id          UUID REFERENCES ponds(id) ON DELETE SET NULL,
    risk_report_id   UUID REFERENCES risk_reports(id) ON DELETE SET NULL,
    title            TEXT NOT NULL,
    message          TEXT NOT NULL,
    channel          notification_channel NOT NULL DEFAULT 'in_app',
    is_read          BOOLEAN NOT NULL DEFAULT FALSE,
    sent_at          TIMESTAMPTZ,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_read_time
    ON notifications(user_id, is_read, created_at DESC);

CREATE INDEX idx_notifications_pond_id
    ON notifications(pond_id);

CREATE INDEX idx_notifications_risk_report_id
    ON notifications(risk_report_id);

-- ---------- Calibration records ----------

CREATE TABLE calibration_records (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sensor_id           UUID NOT NULL REFERENCES sensors(id) ON DELETE CASCADE,
    calibrated_by       UUID REFERENCES users(id) ON DELETE SET NULL,
    calibration_type    TEXT,
    reference_solution  TEXT,
    before_value        NUMERIC(12, 4),
    after_value         NUMERIC(12, 4),
    temperature         NUMERIC(8, 3),
    notes               TEXT,
    calibrated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    next_due_at         TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_calibration_sensor_time
    ON calibration_records(sensor_id, calibrated_at DESC);

CREATE INDEX idx_calibration_calibrated_by
    ON calibration_records(calibrated_by);
