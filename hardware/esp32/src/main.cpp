// ShrimpGuard AI - ESP32 firmware skeleton
//
// IMPORTANT:
// No sensor model or pin number has been confirmed. The pin constants are
// intentionally set to -1 so the firmware reports "not configured" instead
// of reading an invented pin. Update them only after the hardware pin map is
// confirmed and documented.
//
// Bluetooth transport is not implemented yet. The protocol, service UUIDs,
// and payload format are To Be Confirmed.

#include <Arduino.h>

namespace {

constexpr int PIN_PH = -1;           // TODO: confirmed analog/digital pin
constexpr int PIN_DO = -1;           // TODO: confirmed analog/digital pin
constexpr int PIN_TEMPERATURE = -1;  // TODO: confirmed analog/digital pin
constexpr int PIN_SALINITY = -1;     // TODO: confirmed analog/digital pin

constexpr int SAMPLES = 10;
constexpr unsigned long READ_INTERVAL_MS = 5000;
constexpr unsigned long SERIAL_BAUD = 115200;

bool isConfigured(int pin) {
  return pin >= 0;
}

int readAverage(int pin) {
  long total = 0;
  for (int i = 0; i < SAMPLES; i++) {
    total += analogRead(pin);
    delay(10);
  }
  return static_cast<int>(total / SAMPLES);
}

void reportUnconfigured(const char* name) {
  Serial.print(name);
  Serial.println(": pin not configured (To Be Confirmed)");
}

}  // namespace

void setup() {
  Serial.begin(SERIAL_BAUD);
  delay(1000);

  Serial.println();
  Serial.println("ShrimpGuard AI - ESP32 firmware skeleton");
  Serial.println("Hardware pin map: To Be Confirmed");
  Serial.println("Bluetooth transport: To Be Confirmed");

  if (!isConfigured(PIN_PH) || !isConfigured(PIN_DO) ||
      !isConfigured(PIN_TEMPERATURE) || !isConfigured(PIN_SALINITY)) {
    Serial.println("WARNING: One or more sensor pins are unconfigured.");
  }
}

void loop() {
  if (isConfigured(PIN_PH)) {
    Serial.print("ph_raw=");
    Serial.println(readAverage(PIN_PH));
  } else {
    reportUnconfigured("ph");
  }

  if (isConfigured(PIN_DO)) {
    Serial.print("do_raw=");
    Serial.println(readAverage(PIN_DO));
  } else {
    reportUnconfigured("dissolved_oxygen");
  }

  if (isConfigured(PIN_TEMPERATURE)) {
    Serial.print("temperature_raw=");
    Serial.println(readAverage(PIN_TEMPERATURE));
  } else {
    reportUnconfigured("temperature");
  }

  if (isConfigured(PIN_SALINITY)) {
    Serial.print("salinity_raw=");
    Serial.println(readAverage(PIN_SALINITY));
  } else {
    reportUnconfigured("salinity");
  }

  Serial.println("---");
  delay(READ_INTERVAL_MS);
}
