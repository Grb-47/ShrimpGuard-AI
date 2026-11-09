# ShrimpGuard AI — Hardware Overview

**Status:** Week 02 foundation
**Rule:** No sensor model, pin number, interface, range, or calibration solution is invented in this repository. Unknown values are marked **To Be Confirmed (TBC)**.

---

## 1. Purpose

This document is the entry point for the ShrimpGuard AI hardware layer. It explains the component inventory, the data path, the documentation map, and the open decisions that must be resolved before firmware and PCB/wiring work can be finalized.

## 2. Component Inventory

| Component | Purpose | Quantity | Status |
|---|---|---|---|
| ESP32 development board | Reads sensors, packages data, exposes Bluetooth link | 1 per pond device | Board model **TBC** |
| pH sensor | Measures water acidity/alkalinity | 1 per device | Model/interface **TBC** |
| Dissolved oxygen (DO) sensor | Measures oxygen available in water | 1 per device | Model/interface **TBC** |
| Temperature sensor | Measures water temperature | 1 per device | Model/interface **TBC** |
| Salinity sensor | Measures salt concentration | 1 per device | Model/interface **TBC** |
| Manual ammonia test kit | Farmer-entered ammonia measurement | Manual | Kit brand/range **TBC** |
| Turbidity sensor | Optional/future water clarity measurement | 0–1 | Optional/future; model **TBC** |
| Power supply | Powers the ESP32 and sensors | 1 per device | Voltage/current **TBC** |
| Enclosure and probes | Field protection and waterproofing | As required | **TBC** |
| Calibration solutions | Reference points for sensor calibration | As required | Types/values **TBC** |

## 3. Data Path

```text
Water → Sensors → ESP32 → Bluetooth → Flutter farmer app → Node.js API → PostgreSQL
                                                              ↓
                                                   Python FastAPI risk service
                                                              ↓
                                                        Gemini explanation
```

The ESP32 does not call the internet in the current architecture. It sends readings to the Flutter application over Bluetooth. The mobile application is responsible for upload to the backend.

## 4. Documentation Map

| Document | Contents |
|---|---|
| [`../esp32/ESP32_SETUP.md`](../esp32/ESP32_SETUP.md) | ESP32 setup, toolchain, firmware structure, Bluetooth planning |
| [`../sensors/PH_SENSOR.md`](../sensors/PH_SENSOR.md) | pH sensor guide |
| [`../sensors/DO_SENSOR.md`](../sensors/DO_SENSOR.md) | Dissolved oxygen sensor guide |
| [`../sensors/TEMPERATURE_SENSOR.md`](../sensors/TEMPERATURE_SENSOR.md) | Temperature sensor guide |
| [`../sensors/SALINITY_SENSOR.md`](../sensors/SALINITY_SENSOR.md) | Salinity sensor guide |
| [`../calibration/CALIBRATION_GUIDE.md`](../calibration/CALIBRATION_GUIDE.md) | Shared calibration procedure and record keeping |

## 5. Electrical and Safety Notes

- The ESP32 uses **3.3 V logic**. Sensor output voltage must be checked against the ESP32 input limits before connection.
- Some sensor interfaces require 5 V, isolated supplies, or RS485/ADC modules. These requirements depend on the selected sensor and are **TBC**.
- Do not connect a sensor to the ESP32 until its datasheet and output characteristics are confirmed.
- Water and electronics must be physically separated. Probe cables, connectors, and enclosures must be suitable for humid farm conditions; exact IP rating is **TBC**.
- Use a stable power supply. Brownouts can corrupt readings or reset the ESP32.
- Never calibrate or wire sensors while the system is powered in a wet environment without appropriate protection.

## 6. Open Hardware Decisions

| Decision | Owner | Status |
|---|---|---|
| Final ESP32 board model and revision | Hardware lead | TBC |
| Sensor models, interfaces, and voltage requirements | Hardware lead | TBC |
| Pin map and cable lengths | Hardware lead | TBC |
| Power supply and enclosure design | Hardware lead | TBC |
| Bluetooth profile, service UUIDs, and payload format | Hardware + mobile | TBC |
| Calibration solutions and schedule | Hardware lead + expert | TBC |
| Expert validation of water-quality thresholds | Domain expert | TBC |

These decisions must be recorded here and in the relevant sensor document before implementation is considered complete.
