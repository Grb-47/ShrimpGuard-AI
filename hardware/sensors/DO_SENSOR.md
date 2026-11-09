# Dissolved Oxygen (DO) Sensor Guide

**Project:** ShrimpGuard AI
**Sensor model:** To Be Confirmed (TBC)
**Interface:** To Be Confirmed (TBC)

> No sensor model, pin number, electrical specification, or calibration solution is invented in this document. Every unknown value is marked **To Be Confirmed (TBC)**.

---

## 1. Introduction

The dissolved oxygen sensor measures the concentration of oxygen dissolved in pond water. DO is a critical parameter for shrimp health. ShrimpGuard AI records DO readings and uses them, together with other parameters and historical trends, in risk analysis.

## 2. Working Principle

The working principle depends on the selected sensor, which is **TBC**. Common DO measurement approaches include:

- **Optical/fluorescent** sensors that measure the quenching of a luminescent dye.
- **Galvanic or polarographic** electrochemical sensors that produce a current proportional to oxygen diffusion through a membrane.
- **Digital modules** that perform signal conversion and temperature compensation internally.

Optical and electrochemical sensors have different maintenance needs. The final choice, probe type, and interface must be confirmed from the datasheet.

## 3. Required Components

| Component | Notes |
|---|---|
| DO probe/sensor | Model **TBC** |
| Interface board or module (if required) | **TBC** |
| Power supply suitable for the module | **TBC** |
| Waterproof cable and connector | **TBC** |
| Calibration reference materials | Types **TBC** |
| Zero-oxygen solution (if required) | **TBC** |
| Stirring/flow arrangement (if required) | **TBC** |
| Multimeter | For supply and output checks |
| Reference DO measurement (optional) | Method **TBC** |

## 4. Wiring and Pin Configuration

| Signal | ESP32 connection | Status |
|---|---|---|
| Sensor supply (VCC) | **TBC** | Confirm voltage and current |
| Ground (GND) | Common ground | Confirm grounding design |
| Analog/digital output | **TBC** | Confirm signal type and level |
| Temperature signal (if separate) | **TBC** | Depends on sensor |
| Probe connector | **TBC** | Confirm waterproofing |

**Before wiring:**

- Confirm the output voltage is within the ESP32's **3.3 V** input range; use an interface module or level shifting if required.
- DO sensors can draw significant current; confirm the supply can deliver it.
- Some electrochemical sensors require warm-up or polarization time. Confirm the required time.
- Keep signal cables away from pumps and power switching noise.
- Do not connect or disconnect probes while powered in a wet environment.

## 5. Required Libraries

| Interface | Library |
|---|---|
| Analog voltage output | No special library may be required; ADC reading only |
| I2C / UART / RS485 / SDI-12 | Library **TBC** based on confirmed module |
| Sensor-vendor library | **TBC** |

Add libraries only after the sensor model and interface are confirmed.

## 6. Sample Code

The following is an **analog template only**. It compiles with the pin unconfigured and reports that configuration is pending. If the confirmed sensor uses a digital protocol, this template must be replaced.

```cpp
#include <Arduino.h>

// TODO: set after the confirmed wiring and sensor interface are documented.
constexpr int PIN_DO = -1;
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
  if (PIN_DO < 0) {
    Serial.println("dissolved_oxygen: pin not configured (To Be Confirmed)");
  } else {
    Serial.print("do_raw=");
    Serial.println(readAverage(PIN_DO));
  }
  delay(5000);
}
```

The conversion from raw value to mg/L depends on the confirmed sensor, calibration, temperature, and salinity compensation. That conversion is **TBC** and must not be guessed.

## 7. Calibration Procedure

1. Prepare the probe according to the manufacturer's instructions.
2. Confirm the required calibration references; these are **TBC** (for example, a zero-oxygen reference and a water-saturated-air reference may be required, depending on sensor type).
3. Follow the shared procedure in [`../calibration/CALIBRATION_GUIDE.md`](../calibration/CALIBRATION_GUIDE.md).
4. Record reference conditions, raw values, temperature, salinity (if used), date, and operator.
5. Verify with an independent reference measurement where possible.

## 8. Measurement Range and Accuracy

| Property | Value |
|---|---|
| Measurement range | **TBC** |
| Resolution | **TBC** |
| Accuracy | **TBC** |
| Response time | **TBC** |
| Operating temperature | **TBC** |
| Temperature compensation | **TBC** |
| Salinity compensation | **TBC** |
| Minimum flow/stirring requirement | **TBC** |
| Warm-up/polarization time | **TBC** |

These values must be copied from the confirmed sensor datasheet. They are not assumed here.

## 9. Testing Procedure

1. Verify supply voltage and ground before connecting the signal line.
2. Allow the required warm-up or polarization time.
3. Read the value in a safe reference condition.
4. Observe the response when the oxygen condition changes.
5. Compare with a reference DO measurement where possible.
6. Record stability, response time, and test conditions.
7. Repeat the test and confirm the reading returns to a consistent baseline.

## 10. Common Errors

| Error | Cause | Action |
|---|---|---|
| Reading near zero | Probe not polarized, membrane dry, or wrong interface | Follow warm-up and conditioning procedure |
| Reading drifts downward | Membrane fouling or depleted electrolyte | Clean/replace per manufacturer guidance |
| Noisy reading | Poor grounding or pump interference | Improve grounding, move cables, average samples |
| Value does not respond | Probe disconnected or output type mismatch | Check wiring and signal type |
| Inaccurate at different temperatures | Temperature compensation not applied | Confirm and apply the sensor's compensation method |
| Sensor damaged | Wrong supply or wet connector | Verify wiring and waterproofing |

## 11. Troubleshooting

- [ ] Confirm the exact sensor model and datasheet.
- [ ] Confirm supply voltage, current, warm-up time, and polarity.
- [ ] Confirm output signal type and voltage range.
- [ ] Confirm whether flow/stirring is required.
- [ ] Confirm temperature and salinity compensation requirements.
- [ ] Check membrane/electrolyte condition if applicable.
- [ ] Recalibrate with the confirmed reference materials.
- [ ] Compare with an independent reference measurement.
- [ ] Replace the probe only after wiring and calibration are ruled out.

## 12. Open Items

- Sensor model and measurement technology
- Interface board and output characteristics
- Pin assignment
- Library or driver
- Calibration references and schedule
- Conversion formula and compensation method
- Flow/stirring requirement and maintenance interval
