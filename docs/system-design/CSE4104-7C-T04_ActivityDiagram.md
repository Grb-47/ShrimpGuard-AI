# ShrimpGuard AI — UML Activity Diagram

**Course:** CSE4104  
**Assignment:** Week 04 — System Design & Software Architecture  
**Official Team Name:** CSE4104-7C-T04 · **Section:** 7C  
**Project Title:** ShrimpGuard AI — AI-Powered Shrimp Farm Water Quality & Environmental Risk Monitoring System  
**Core Feature:** Sensor Reading Collection and Environmental Risk Analysis Workflow

---

## 1. UML Activity Diagram

> The diagram uses Mermaid `flowchart TD` syntax to represent a UML Activity Diagram. Solid rectangular nodes are activities, diamond nodes are decisions, cylinder nodes are persistent data stores, and rounded nodes are start/end states.

```mermaid
flowchart TD
    A([Farmer opens Flutter app]) --> B[Select owned farm and pond]
    B --> C{ESP32 Bluetooth connection available}

    C -- No --> M0{Farmer has a manual ammonia test-kit result}
    M0 -- No --> E0([End: no reading available for analysis])
    M0 -- Yes --> M2[Farmer performs manual ammonia test-kit measurement]
    M2 --> M1[Enter ammonia value, unit, kit name and recorded time]
    M1 --> M3{Value numeric and unit present}
    M3 -- No --> M4[Show validation message and allow re-entry]
    M4 --> M0
    M3 -- Yes --> S2[Prepare POST /api/v1/readings/manual]

    C -- Yes --> D[Receive sensor payload from ESP32 over Bluetooth]
    D --> E{pH, dissolved oxygen, temperature and salinity complete and parseable}
    E -- No --> X1[Mark reading incomplete and show validation message]
    X1 --> M0
    E -- Yes --> F[Display sensor values with units, device identity and timestamp]
    F --> S1[Prepare POST /api/v1/readings]

    S1 --> N1[Node.js verifies pond ownership, request schema, units and timestamps]
    S2 --> N1
    N1 --> V{Data validation passed}
    V -- No --> X2[Return controlled client error and store nothing]
    X2 --> E1([End: no persisted reading])
    V -- Yes --> P1[(PostgreSQL: insert accepted readings into their source tables)]

    P1 --> H1[Node.js gathers pond context and recent readings or history]
    H1 --> H2[Call internal FastAPI POST /analyze]
    H2 --> R1{Valid reading data available and expert thresholds configured}
    R1 -- No --> R2[Return not_configured or no-valid-input status without a risk level]
    R2 --> E2([End: do not classify or store a risk report])
    R1 -- Yes --> R3[Rule engine evaluates thresholds, trends and anomalies]
    R3 --> G{Gemini API configured and available}

    G -- Yes --> G1[Gemini drafts explanation_bn and recommendations_bn from validated risk result]
    G1 --> W1[(PostgreSQL: insert risk_reports with validated Bengali text)]
    G -- No --> G2[Preserve rule-based result and mark Bengali text unavailable or pending]
    G2 --> W2[(PostgreSQL: insert risk_reports without AI-generated text)]

    W1 --> T{Configured notification condition met}
    W2 --> T
    T -- Yes --> T1[(PostgreSQL: insert in-app notifications linked to user, pond and risk report)]
    T -- No --> D2[Node.js returns stored report and notification state]
    T1 --> D2
    D2 --> D3([Display risk result and Bengali text or fallback state to farmer])
    D3 --> E3([End])
```

## 2. Technical Explanation

The workflow begins with the farmer selecting an owned farm and pond in the Flutter application. Bluetooth availability is checked before any sensor payload is accepted. When connected, the ESP32 supplies the four confirmed sensor parameters — pH, dissolved oxygen, temperature, and salinity — each with a unit and timestamp. Ammonia is a **separate, optional manual test-kit input**; it is never represented as an ESP32 sensor measurement. If Bluetooth is unavailable, the farmer may still record a manual ammonia result, but no analysis is performed when no valid reading is available.

Node.js validates pond ownership, request structure, units, and timestamps before persisting only the accepted source rows: `sensor_readings` for ESP32 data and/or `manual_test_readings` for ammonia data. Node.js then assembles pond context, recent readings, and available history and calls the internal Python FastAPI service at `POST /analyze`. Flutter and React never call FastAPI directly.

FastAPI checks that valid input data and expert-validated thresholds are available. If thresholds are not configured, it returns `not_configured`; if there is no valid input, no classification is attempted. In either case no risk level is presented or persisted, because `risk_reports.risk_level` is `NOT NULL` in the canonical schema. Otherwise, the rule engine classifies environmental risk from configured thresholds, available trends, and anomalies. Gemini is called only **after** this result exists and drafts the Bengali `explanation_bn` and `recommendations_bn` text; a Gemini timeout or failure leaves the rule-based result unchanged and marks the text unavailable or pending.

The Node.js service stores the completed analysis in `risk_reports`. If the configured notification condition is met, an in-app `notifications` row is created. The exact notification trigger condition remains **To Be Confirmed** in the SRS, so this diagram represents it as a decision rather than inventing a threshold. Finally, Node.js returns the stored report and notification state to Flutter for display. This document describes **planned** behavior; the current repository contains foundation skeletons, not a fully implemented workflow.
