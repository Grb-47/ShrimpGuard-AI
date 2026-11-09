# pH Sensor Guide

**Project:** ShrimpGuard AI
**Sensor model:** To Be Confirmed (TBC)
**Interface:** To Be Confirmed (TBC)

> No sensor model, pin number, electrical specification, or calibration solution is invented in this document. Every unknown value is marked **To Be Confirmed (TBC)**.

---

## 1. Introduction

The pH sensor measures the acidity or alkalinity of pond water. pH is one of the core water-quality parameters monitored by ShrimpGuard AI. Readings are collected by the ESP32 and transferred to the Flutter farmer application over Bluetooth.

## 2. Working Principle

The working principle depends on the selected sensor, which is **TBC**. Common pH measurement approaches include:

- A glass-electrode pH probe whose output voltage changes with hydrogen-ion activity.
- A probe plus an analog interface board that amplifies and conditions the electrode signal.
- A digital or RS485 pH module that performs conversion internally.

The final design, probe type, interface type, and output signal must be confirmed from the selected product's datasheet before wiring.

## 3. Required Components

| Component | Notes |
|---|---|
| pH probe/sensor | Model **TBC** |
| Interface board or module (if required) | **TBC** |
| Power supply suitable for the module | **TBC** |
| Connection cable and waterproofing | **TBC** |
| Calibration solutions | Types and values **TBC** |
| Clean water and soft cloth for probe care | Standard handling |
| Multimeter | For verifying supply and output |
| Reference pH measurement (optional) | Method **TBC** |

## 4. Wiring and Pin Configuration

| Signal | ESP32 connection | Status |
|---|---|---|
| Sensor supply (VCC) | **TBC** | Confirm voltage and current |
| Ground (GND) | Common ground | Confirm grounding design |
| Analog/digital output | **TBC** | Confirm signal type and level |
| Temperature compensation signal (if any) | **TBC** | Optional/depends on sensor |
| Probe connector | **TBC** | Confirm connector and waterproofing |

**Before wiring:**

- Confirm the sensor output voltage is within the ESP32's **3.3 V** input range. Use a level shifter or interface module if required.
- Do not power the sensor from a GPIO pin.
- Keep probe cables away from pumps and power cables where possible.
- Do not connect or disconnect probes while powered in a wet environment.

## 5. Required Libraries

| Interface | Library |
|---|---|
| Analog voltage output | No special library may be required; ADC reading only |
| I2C / UART / RS485 / OneWire | Library **TBC** based on confirmed module |
| Sensor-vendor library | **TBC** |

Add libraries only after the sensor model and interface are confirmed.

## 6. Sample Code

The following is an **analog template only**. It compiles with the pin unconfigured and reports that configuration is pending.

```cpp
#include <Arduino.h>

// TODO: set after the confirmed wiring and sensor interface are documented.
constexpr int PIN_PH = -1;
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
  if (PIN_PH < 0) {
    Serial.println("ph: pin not configured (To Be Confirmed)");
  } else {
    Serial.print("ph_raw=");
    Serial.println(readAverage(PIN_PH));
  }
  delay(5000);
}
```

The conversion from raw ADC value to pH depends on the confirmed interface board and calibration. That conversion is **TBC** and must not be guessed.

## 7. Calibration Procedure

1. Confirm the probe is clean and hydrated according to the manufacturer's instructions.
2. Select the required pH calibration solutions; values are **TBC**.
3. Follow the shared procedure in [`../calibration/CALIBRATION_GUIDE.md`](../calibration/CALIBRATION_GUIDE.md).
4. Record the reference solutions, raw values, temperature, date, and operator in `calibration_records`.
5. Verify with an independent reference measurement where possible.

## 8. Measurement Range and Accuracy

| Property | Value |
|---|---|
| Measurement range | **TBC** |
| Resolution | **TBC** |
| Accuracy | **TBC** |
| Response time | **TBC** |
| Operating temperature | **TBC** |
| Recommended storage | **TBC** |

These values must be copied from the confirmed sensor datasheet. They are not assumed here.

## 9. Testing Procedure

1. Verify the supply voltage and ground before connecting the signal line.
2. Connect the probe and interface as confirmed.
3. Read raw values in air and in a safe reference liquid.
4. Confirm the raw value changes in the expected direction when the reference changes.
5. Compare with a reference pH measurement.
6. Record the test result, date, and equipment identifiers.
7. Repeat at least three times and check stability.

## 10. Common Errors

| Error | Cause | Action |
|---|---|---|
| Reading does not change | Probe disconnected, unpowered, or wrong interface | Check power, connector, and signal type |
| Noisy or unstable value | Poor grounding, long cable, pump interference | Improve grounding, shorten cable, average samples |
| Reading drifts | Probe fouling or dry storage | Clean and hydrate per manufacturer guidance |
| Value clipped at maximum | Output exceeds ESP32 ADC range | Use correct interface/level shifting |
| Incorrect pH after calibration | Wrong solutions, contaminated solutions, skipped temperature step | Repeat calibration with confirmed solutions |
| Sensor damaged | Wrong supply polarity or voltage | Verify wiring against datasheet before powering |

## 11. Troubleshooting

- [ ] Confirm the exact sensor model and datasheet.
- [ ] Confirm supply voltage, current, and polarity.
- [ ] Confirm output signal type (analog, I2C, UART, RS485).
- [ ] Confirm output voltage is safe for 3.3 V logic.
- [ ] Confirm the pin map is documented and the firmware constant is updated.
- [ ] Clean the probe according to manufacturer instructions.
- [ ] Recalibrate with confirmed reference solutions.
- [ ] Test with a known reference measurement.
- [ ] Replace the probe only after wiring and calibration are ruled out.

## 12. Open Items

- Sensor model and datasheet
- Interface board and output characteristics
- Pin assignment
- Library or driver
- Calibration solutions and schedule
- Conversion formula from raw value to pH
- Probe maintenance and replacement interval
