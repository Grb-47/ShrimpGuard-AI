# ShrimpGuard AI — Calibration Guide

**Applies to:** pH, dissolved oxygen, temperature, and salinity sensors
**Status:** Week 02 foundation

> **No calibration solution, buffer value, reference method, or schedule is invented in this document.** Every sensor-specific value is marked **To Be Confirmed (TBC)** and must come from the confirmed sensor datasheet and an expert-approved procedure.

---

## 1. Purpose

Calibration keeps sensor readings trustworthy. This guide defines a shared calibration workflow, the records that must be kept, and the safety rules that apply to all sensors. Individual sensor documents contain sensor-specific notes.

## 2. Why Calibration Matters

- Raw sensor signals drift over time.
- Probe fouling, membrane aging, and storage conditions change response.
- The AI risk analysis is only as good as the readings it receives.
- Calibration history supports troubleshooting and auditability.

## 3. Prerequisites

- Confirmed sensor model and datasheet
- Confirmed interface and pin map
- Stable power supply
- Clean, suitable containers for reference solutions
- Reference solutions/materials that are **TBC** for each sensor
- Reference thermometer or independent measurement where required (**TBC**)
- Distilled or deionized water for rinsing, as appropriate (**TBC**)
- Soft cloth or tissue for careful probe drying
- Personal protective equipment appropriate to the solutions used
- This guide and the sensor-specific document

## 4. General Calibration Principles

1. **Read the manufacturer's instructions first.** They override this general guide.
2. **Clean gently.** Follow the probe's cleaning guidance; avoid abrasion.
3. **Rinse between solutions.** Prevent cross-contamination.
4. **Stabilize.** Allow the probe and solution to reach thermal equilibrium.
5. **Record the temperature.** Many sensors compensate for temperature.
6. **Use fresh solutions.** Expired or contaminated solutions invalidate calibration.
7. **Do not guess values.** Use only confirmed reference values.
8. **Record everything.** Calibration without a record is difficult to audit.
9. **Verify.** After calibration, check against an independent reference where possible.
10. **Stop if anything is uncertain.** Ask the hardware lead or domain expert.

## 5. General Two-Point Calibration Workflow

This is a generic workflow. The number of points and the exact solutions are **TBC** for each sensor.

1. Confirm the sensor is clean, hydrated, and undamaged.
2. Power the system in a safe, dry environment.
3. Read the raw value in the first confirmed reference condition.
4. Record the raw value, reference value, temperature, and timestamp.
5. Rinse the probe according to the manufacturer's instructions.
6. Read the raw value in the second confirmed reference condition.
7. Record the raw value, reference value, temperature, and timestamp.
8. Apply the calibration using the method specified by the sensor manufacturer.
9. Re-read each reference condition to verify.
10. Store the calibration record and update the sensor status.

If the sensor requires a different procedure (for example, a zero-oxygen reference or a saturated-air reference for DO), follow the manufacturer's method and record it as the `calibration_type`.

## 6. Sensor-Specific Notes

### 6.1 pH

- Reference solutions and their values: **TBC**.
- Number of calibration points: **TBC**.
- Temperature compensation method: **TBC**.
- Probe storage and hydration requirements: **TBC**.
- Conversion from raw value to pH: **TBC**.

### 6.2 Dissolved Oxygen

- Reference conditions (for example, zero-oxygen and/or water-saturated air): **TBC**.
- Warm-up/polarization time: **TBC**.
- Flow/stirring requirement during measurement: **TBC**.
- Temperature and salinity compensation: **TBC**.
- Membrane/electrolyte service interval: **TBC**.

### 6.3 Temperature

- Whether the sensor is factory-calibrated or field-adjustable: **TBC**.
- Reference thermometer and comparison method: **TBC**.
- Verification points: **TBC**.
- Immersion depth and equilibrium time: **TBC**.

### 6.4 Salinity

- Reference solutions and values: **TBC**.
- Output unit (ppt, PSU, µS/cm): **TBC**.
- Temperature compensation method: **TBC**.
- Conversion from conductivity to salinity: **TBC**.
- Probe cleaning and storage: **TBC**.

## 7. Calibration Records

Every calibration event must be stored in the `calibration_records` table:

| Field | Meaning |
|---|---|
| `sensor_id` | Sensor that was calibrated |
| `calibrated_by` | User who performed the calibration |
| `calibration_type` | Method used (for example, two-point); exact label **TBC** |
| `reference_solution` | Confirmed reference solution(s) used |
| `before_value` | Reading before adjustment |
| `after_value` | Reading after adjustment |
| `temperature` | Temperature during calibration |
| `notes` | Observations, problems, and deviations |
| `calibrated_at` | Calibration timestamp |
| `next_due_at` | Next due date, based on the confirmed schedule |

The sensor's `calibration_status` should be updated to `calibrated`, `due`, or `overdue` as appropriate.

## 8. Calibration Schedule

The calibration interval is **TBC** for every sensor. It will depend on:

- Manufacturer recommendations
- Pond conditions and fouling rate
- Observed drift
- Deployment duration
- Criticality of the parameter

Until a schedule is approved, calibrate before deployment and after any suspected drift, cleaning, repair, or probe replacement.

## 9. Calibration Safety

- Wear appropriate eye and skin protection when handling reference solutions.
- Do not eat or drink near calibration materials.
- Label containers clearly and never reuse a container for a different solution.
- Keep solutions away from children, livestock, and pond water.
- Dispose of solutions according to local rules and the manufacturer's instructions.
- Do not calibrate near open water or with wet hands and exposed electronics.
- Keep the ESP32 and power supply dry.

## 10. Quality Checks

- Check that the raw reading responds in the expected direction.
- Check stability over several samples.
- Compare with an independent reference where possible.
- Confirm the calibration record is complete.
- Confirm the sensor status and next due date are updated.
- Re-check after cleaning or maintenance.

## 11. Troubleshooting

| Symptom | Possible cause | Action |
|---|---|---|
| Calibration will not stabilize | Probe dirty, bubbles, or insufficient equilibrium time | Clean, tap to remove bubbles, wait longer |
| Reading offset after calibration | Wrong/expired reference solution | Repeat with fresh confirmed solution |
| Different results between operators | Inconsistent procedure | Follow this guide and record every step |
| Sensor responds slowly | Fouled probe or aging membrane | Clean or service per manufacturer guidance |
| Raw value clipped | Output exceeds ADC range | Use correct interface/level shifting |
| Temperature-dependent error | Compensation not applied | Confirm and apply the sensor's compensation method |
| Cannot find confirmed reference values | Documentation gap | Stop and obtain the datasheet/expert guidance; do not guess |

## 12. Calibration Checklist

- [ ] Sensor model and datasheet confirmed
- [ ] Interface and pin map confirmed
- [ ] Reference solutions/materials confirmed
- [ ] Containers labeled and clean
- [ ] Probe cleaned and prepared
- [ ] Temperature recorded
- [ ] Before-value recorded
- [ ] Adjustment performed per manufacturer method
- [ ] After-value recorded
- [ ] Verification performed
- [ ] `calibration_records` entry created
- [ ] Sensor status updated
- [ ] Next due date set
- [ ] Deviations and notes recorded

## 13. Open Items

- Confirmed reference solutions and values for each sensor
- Confirmed number of calibration points
- Confirmed temperature compensation methods
- Confirmed calibration intervals
- Confirmed verification/reference measurement method
- Confirmed storage and maintenance procedures
- Assignment of calibration responsibility within the team
