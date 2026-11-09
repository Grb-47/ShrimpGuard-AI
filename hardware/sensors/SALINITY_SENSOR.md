# Salinity Sensor Guide

**Project:** ShrimpGuard AI
**Sensor model:** To Be Confirmed (TBC)
**Interface:** To Be Confirmed (TBC)

> No sensor model, pin number, electrical specification, or calibration solution is invented in this document. Every unknown value is marked **To Be Confirmed (TBC)**.

---

## 1. Introduction

The salinity sensor measures the salt concentration of pond water. Salinity affects shrimp osmoregulation and interacts with temperature and dissolved oxygen. ShrimpGuard AI records salinity readings for monitoring and risk analysis.

## 2. Working Principle

The working principle depends on the selected sensor, which is **TBC**. Common salinity measurement approaches include:

- **Conductivity-based** probes that infer salinity from electrical conductivity, usually with temperature compensation.
- **Dedicated salinity modules** that output a calibrated salinity value directly.
- **Digital or RS485 modules** that perform conversion and compensation internally.

The final sensor type, measurement units, and compensation method must be confirmed from the datasheet.

## 3. Required Components

| Component | Notes |
|---|---|
| Salinity probe/sensor | Model **TBC** |
| Interface board or module (if required) | **TBC** |
| Power supply suitable for the module | **TBC** |
| Waterproof cable and connector | **TBC** |
| Calibration reference solutions | Types/values **TBC** |
| Reference salinity measurement (optional) | Method **TBC** |
| Multimeter | For supply and signal checks |

## 4. Wiring and Pin Configuration

| Signal | ESP32 connection | Status |
|---|---|---|
| Sensor supply (VCC) | **TBC** | Confirm voltage and current |
| Ground (GND) | Common ground | Confirm grounding design |
| Analog/digital output | **TBC** | Confirm signal type and level |
| Temperature signal (if separate) | **TBC** | Depends on sensor |
| Probe connector | **TBC** | Confirm waterproofing |

**Before wiring:**

- Confirm output voltage is within the ESP32's **3.3 V** input range; use an interface module or level shifting if required.
- Confirm the probe's excitation method and whether it must not be powered continuously in water.
- Keep probe cables away from pumps and power switching noise.
- Do not connect or disconnect probes while powered in a wet environment.

## 5. Required Libraries

| Interface | Library |
|---|---|
| Analog voltage output | No special library may be required; ADC reading only |
| I2C / UART / RS485 | Library **TBC** based on confirmed module |
| Sensor-vendor library | **TBC** |

Add libraries only after the sensor model and interface are confirmed.

## 6. Sample Code

The following is an **analog template only**. It compiles with the pin unconfigured and reports that configuration is pending. If the confirmed sensor uses a digital protocol, replace this template with the confirmed driver.

```cpp
#include <Arduino.h>

// TODO: set after the confirmed wiring and sensor interface are documented.
constexpr int PIN_SALINITY = -1;
constexpr int SAMPLES = 10;

int readAverage(int pin) {
  long total = 0;
  for (int i = 0; i < SAMPLES; i++) {
    total += analogRead(pin);
    delay(10);
  }
  return static_cast<int>(total / SAMPLES);
}

void setup() {
  Serial.begin(115200);
}

void loop() {
  if (PIN_SALINITY < 0) {
    Serial.println("salinity: pin not configured (To Be Confirmed)");
  } else {
    Serial.print("salinity_raw=");
    Serial.println(readAverage(PIN_SALINITY));
  }
  delay(5000);
}
```

The conversion from raw value to salinity depends on the confirmed sensor, reference solutions, and temperature compensation. The output unit (for example ppt, PSU, or µS/cm) is **TBC**.

## 7. Calibration Procedure

1. Prepare the probe according to the manufacturer's instructions.
2. Select the required calibration reference solutions; types and values are **TBC**.
3. Confirm the temperature compensation method and record the water temperature.
4. Follow the shared procedure in [`../calibration/CALIBRATION_GUIDE.md`](../calibration/CALIBRATION_GUIDE.md).
5. Record reference values, raw values, temperature, date, and operator in `calibration_records`.
6. Verify with an independent reference measurement where possible.

## 8. Measurement Range and Accuracy

| Property | Value |
|---|---|
| Measurement range | **TBC** |
| Output unit | **TBC** |
| Resolution | **TBC** |
| Accuracy | **TBC** |
| Response time | **TBC** |
| Operating temperature | **TBC** |
| Temperature compensation | **TBC** |
| Probe cell constant (if applicable) | **TBC** |

These values must be copied from the confirmed sensor datasheet. They are not assumed here.

## 9. Testing Procedure

1. Verify supply voltage and ground before connecting the signal line.
2. Immerse the probe in a safe reference solution.
3. Allow the reading to stabilize and record the temperature.
4. Compare with the reference value.
5. Observe the response when the reference salinity changes.
6. Record the test result, date, and equipment identifiers.
7. Repeat and check stability.

## 10. Common Errors

| Error | Cause | Action |
|---|---|---|
| Reading does not change | Probe disconnected, unpowered, or wrong interface | Check power, connector, and signal type |
| Reading drifts | Probe fouling, bubbles, or polarization | Clean probe and follow manufacturer guidance |
| Value depends on temperature | Temperature compensation not applied | Apply the confirmed compensation method |
| Noisy reading | Poor grounding or cable interference | Improve grounding, shorten cable, average samples |
| Incorrect unit conversion | Raw conductivity treated as salinity | Confirm the sensor's output unit and conversion |
| Sensor damaged | Wrong supply or continuous excitation beyond rating | Verify wiring and power sequence |

## 11. Troubleshooting

- [ ] Confirm the exact sensor model and datasheet.
- [ ] Confirm whether the output is conductivity or salinity, and the unit.
- [ ] Confirm supply voltage, current, and excitation requirements.
- [ ] Confirm output signal type and voltage range.
- [ ] Confirm temperature compensation requirements.
- [ ] Clean the probe and check for bubbles or fouling.
- [ ] Recalibrate with the confirmed reference solutions.
- [ ] Compare with an independent reference measurement.
- [ ] Replace the probe only after wiring and calibration are ruled out.

## 12. Open Items

- Sensor model and measurement method
- Interface and pin assignment
- Output unit and conversion formula
- Library or driver
- Calibration reference solutions and schedule
- Temperature compensation method
- Probe maintenance and replacement interval
