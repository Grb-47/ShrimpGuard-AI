# Temperature Sensor Guide

**Project:** ShrimpGuard AI
**Sensor model:** To Be Confirmed (TBC)
**Interface:** To Be Confirmed (TBC)

> No sensor model, pin number, electrical specification, or calibration solution is invented in this document. Every unknown value is marked **To Be Confirmed (TBC)**.

---

## 1. Introduction

The temperature sensor measures pond water temperature. Temperature affects dissolved oxygen, shrimp metabolism, and the behavior of other sensors. ShrimpGuard AI records temperature readings and uses them in water-quality analysis and, where required, sensor compensation.

## 2. Working Principle

The working principle depends on the selected sensor, which is **TBC**. Common water-temperature sensing approaches include:

- **Thermistor** elements whose resistance changes with temperature.
- **Resistance temperature detectors (RTDs)** with a well-defined resistance-temperature relationship.
- **Digital sensors** that report temperature over OneWire, I2C, or another bus.
- **Analog modules** that output a voltage proportional to temperature.

The final sensor type, interface, and waterproofing must be confirmed from the datasheet.

## 3. Required Components

| Component | Notes |
|---|---|
| Waterproof temperature probe | Model **TBC** |
| Interface board or module (if required) | **TBC** |
| Pull-up resistor (for some digital probes) | Value **TBC** |
| Power supply suitable for the module | **TBC** |
| Waterproof cable and connector | **TBC** |
| Reference thermometer | Method **TBC** |
| Multimeter | For supply and signal checks |

## 4. Wiring and Pin Configuration

| Signal | ESP32 connection | Status |
|---|---|---|
| Sensor supply (VCC) | **TBC** | Confirm voltage |
| Ground (GND) | Common ground | Confirm grounding |
| Data/analog output | **TBC** | Confirm interface |
| Pull-up resistor (if required) | **TBC** | Depends on sensor |
| Probe cable/connector | **TBC** | Confirm waterproofing |

**Before wiring:**

- Confirm output voltage is within the ESP32's **3.3 V** input range. Use level shifting if required.
- Digital probes may require a pull-up resistor; its value is **TBC**.
- Waterproofing at the probe cable entry is critical. The exact enclosure method is **TBC**.
- Keep the probe cable away from power switching noise where possible.

## 5. Required Libraries

| Interface | Library |
|---|---|
| Analog thermistor/RTD | No special library may be required; ADC reading only |
| OneWire digital sensor | Library **TBC** |
| I2C digital sensor | Library **TBC** |
| Sensor-vendor library | **TBC** |

Add libraries only after the sensor model and interface are confirmed.

## 6. Sample Code

The following is an **analog template only**. It compiles with the pin unconfigured and reports that configuration is pending. If the confirmed sensor uses a digital protocol, replace this template with the confirmed driver.

```cpp
#include <Arduino.h>

// TODO: set after the confirmed wiring and sensor interface are documented.
constexpr int PIN_TEMPERATURE = -1;
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
  if (PIN_TEMPERATURE < 0) {
    Serial.println("temperature: pin not configured (To Be Confirmed)");
  } else {
    Serial.print("temperature_raw=");
    Serial.println(readAverage(PIN_TEMPERATURE));
  }
  delay(5000);
}
```

The conversion from raw value to degrees Celsius depends on the confirmed sensor type and circuit. That conversion is **TBC** and must not be guessed.

## 7. Calibration Procedure

1. Confirm whether the selected sensor requires calibration or only verification.
2. Prepare a reference thermometer and a stable water bath; the reference method is **TBC**.
3. Compare the sensor reading with the reference at the required points.
4. Follow the shared procedure in [`../calibration/CALIBRATION_GUIDE.md`](../calibration/CALIBRATION_GUIDE.md).
5. Record reference values, sensor values, date, and operator.
6. If the sensor is digital and factory-calibrated, record the verification result instead of an adjustment.

## 8. Measurement Range and Accuracy

| Property | Value |
|---|---|
| Measurement range | **TBC** |
| Resolution | **TBC** |
| Accuracy | **TBC** |
| Response time | **TBC** |
| Operating temperature | **TBC** |
| Probe immersion depth | **TBC** |
| Cable/connector rating | **TBC** |

These values must be copied from the confirmed sensor datasheet. They are not assumed here.

## 9. Testing Procedure

1. Verify supply voltage and ground before connecting the signal line.
2. Immerse the probe in a safe reference water sample.
3. Allow enough time for the probe and water to reach thermal equilibrium.
4. Compare the reading with a reference thermometer.
5. Observe the response when the water temperature changes.
6. Record the test result, date, and equipment identifiers.
7. Repeat and confirm the reading is stable.

## 10. Common Errors

| Error | Cause | Action |
|---|---|---|
| Reading stuck | Wrong interface, missing pull-up, or disconnected probe | Check wiring and interface requirements |
| Slow response | Probe not immersed deeply enough or thermal lag | Confirm immersion depth and wait for equilibrium |
| Unstable reading | Poor grounding or cable noise | Improve grounding; move cable away from noise |
| Reading offset | Probe not calibrated or reference mismatch | Verify against a reference thermometer |
| Water ingress | Damaged cable or connector | Replace or reseal the probe assembly |
| Sensor damaged | Wrong supply polarity or voltage | Verify wiring against datasheet |

## 11. Troubleshooting

- [ ] Confirm the exact sensor model and datasheet.
- [ ] Confirm whether the interface is analog, OneWire, I2C, or another bus.
- [ ] Confirm supply voltage and required pull-up resistor.
- [ ] Confirm output voltage is safe for 3.3 V logic.
- [ ] Confirm probe waterproofing and immersion limits.
- [ ] Verify against a reference thermometer.
- [ ] Check cable continuity and connector condition.
- [ ] Replace the probe only after wiring and calibration are ruled out.

## 12. Open Items

- Sensor model and datasheet
- Interface and pin assignment
- Library or driver
- Pull-up resistor value (if required)
- Conversion formula or factory calibration data
- Verification/calibration method
- Probe maintenance and replacement interval
