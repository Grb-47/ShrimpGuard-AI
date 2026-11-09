# ESP32 Setup Guide

**Project:** ShrimpGuard AI
**Status:** Week 02 foundation
**Board:** To Be Confirmed (TBC)

---

## 1. Introduction

The ESP32 is the edge controller for ShrimpGuard AI. It reads the water-quality sensors, performs basic validation, and sends readings to the Flutter farmer application over Bluetooth. This guide covers the development environment, firmware layout, configuration placeholders, flashing, and testing.

> The exact ESP32 board model, pin map, power design, and Bluetooth protocol are **not yet confirmed**. No pin numbers or electrical specifications are invented here.

## 2. Prerequisites

- ESP32 development board (model **TBC**)
- USB cable and drivers for the board's USB-to-serial chip (**TBC**)
- Computer with VS Code
- PlatformIO extension for VS Code, or Arduino IDE
- Confirmed sensor wiring from the individual sensor documents
- Stable power supply (**TBC**)

## 3. Toolchain

### Recommended: PlatformIO

1. Install the PlatformIO IDE extension in VS Code.
2. Open the `hardware/esp32` folder.
3. Edit `platformio.ini` and replace the placeholder board with the confirmed board ID.
4. Build and upload.

### Alternative: Arduino IDE

1. Install Arduino IDE.
2. Install the ESP32 board support package.
3. Select the confirmed board and port.
4. Paste or open the firmware source.

The exact ESP32 core version is **TBC**.

## 4. Project Files

```text
hardware/esp32/
├── platformio.ini   Build configuration (board placeholder)
├── ESP32_SETUP.md   This guide
└── src/
    └── main.cpp     Firmware skeleton
```

## 5. Board and Pin Planning

| Item | Value |
|---|---|
| ESP32 board model | **TBC** |
| USB-to-serial chip | **TBC** |
| pH sensor input | **TBC** |
| DO sensor input | **TBC** |
| Temperature sensor input | **TBC** |
| Salinity sensor input | **TBC** |
| Turbidity sensor input (future) | **TBC** |
| Power input | **TBC** |
| Status LED | **TBC** |

### Pin planning rules

- Use pins supported by the confirmed board and avoid strapping pins unless their boot behavior is understood.
- ESP32 logic is 3.3 V; verify every sensor output level before connection.
- Analog-capable pins are required for analog sensors. The ADC channel mapping depends on the board.
- Some pins are input-only or have boot-time behavior. Confirm against the board datasheet.

## 6. Power

- The ESP32 and sensors must share a stable, correctly rated supply. Voltage and current requirements are **TBC**.
- Sensor current draw can exceed the board regulator capability. An external supply may be required; this decision is **TBC**.
- Use decoupling and appropriate grounding. Avoid powering sensors directly from a GPIO pin.
- In the field, use a protected enclosure and cable strain relief.

## 7. Firmware Structure

The skeleton in `src/main.cpp`:

1. Initializes serial logging.
2. Checks whether sensor pins have been confirmed.
3. Reads and averages configured analog inputs.
4. Prints a structured line for development.
5. Leaves a clear placeholder for the Bluetooth transport.

The Bluetooth profile, service UUIDs, payload encoding, and pairing behavior are **TBC**. Do not assume BLE or Classic Bluetooth until the mobile team confirms the protocol.

## 8. Suggested Reading Payload

A future payload should include at least:

| Field | Notes |
|---|---|
| `device_serial` | Confirmed device identifier |
| `sensor_type` | `ph`, `dissolved_oxygen`, `temperature`, `salinity` |
| `value` | Numeric reading |
| `unit` | Unit for the parameter |
| `recorded_at` | Device timestamp or uptime-based marker |
| `quality` | `valid`, `suspect`, `invalid` |
| `firmware_version` | Firmware identifier |

The exact JSON schema and timestamp strategy are **TBC**.

## 9. Build and Flash

1. Confirm the board ID and pins.
2. Connect the board with a data-capable USB cable.
3. Select the correct port.
4. Build the project.
5. Upload the firmware.
6. Open the serial monitor at the configured baud rate.

The default skeleton uses `115200` baud for logging. Confirm that this does not conflict with any confirmed sensor interface.

## 10. Testing Procedure

1. Power the board without sensors and confirm it boots and logs.
2. Connect one sensor at a time.
3. Verify the raw ADC value changes when the probe condition changes.
4. Compare readings with a reference measurement where safe.
5. Confirm that unconfigured pins are reported rather than read.
6. Record the test date, board, firmware version, and sensor details.
7. Repeat for each sensor.

## 11. Common Errors

| Symptom | Likely cause | Action |
|---|---|---|
| Board not detected | Missing USB driver or charge-only cable | Install driver; use a data cable |
| Upload fails | Wrong board/port or boot mode issue | Confirm board ID and port; follow board boot procedure |
| Random resets | Insufficient power or brownout | Check supply and wiring; power sensors externally if required |
| Noisy analog readings | Poor grounding, long cables, pump noise | Shorten cables, improve grounding, average samples |
| Unconfigured pin warning | Pin constants are still `-1` | Complete the confirmed pin map |
| Sensor value stuck | Sensor not powered or wrong interface | Check datasheet, supply, and signal type |

## 12. Troubleshooting Checklist

- [ ] Board model confirmed and recorded
- [ ] Correct board selected in the toolchain
- [ ] Data-capable USB cable and driver
- [ ] Stable power supply
- [ ] Sensor datasheets available
- [ ] Pin map confirmed and documented
- [ ] Output voltage compatible with 3.3 V logic
- [ ] Serial monitor baud rate matches firmware
- [ ] One sensor tested at a time
- [ ] Readings validated against a reference where possible
- [ ] Bluetooth protocol confirmed with the mobile team

## 13. Open Items

- Final board model, revision, and pin map
- Power architecture and enclosure
- Bluetooth profile and payload schema
- Sensor libraries and drivers
- Calibration storage on the device (if any)
- Firmware update mechanism
- Watchdog and error-recovery policy
