# IRSL: Indian Road Simulation Library

![Status](https://img.shields.io/badge/Status-Work_in_Progress-yellow)
![Platform](https://img.shields.io/badge/Platform-MATLAB-orange)
![Event](https://img.shields.io/badge/SIH_2025-Participant-blue)

**Problem Statement:** 25100 - Accelerating High-Fidelity Road Network Modeling for Indian Traffic Simulations.

---

## 📖 Context & Origin
This project was originally initiated as a submission for the **Smart India Hackathon 2025** by **Team IRSL**. It addresses the limitations of standard traffic simulators, which often fail to capture the chaotic nature of Indian roads.

**Current Status:** The project is now being actively developed as an open-source library to fully realize the goals of modeling potholes, erratic driving, and unstructured traffic scenarios.

---

## 🚀 Overview
**IRSL** is a MATLAB-based library designed to introduce realistic "chaos" into traffic simulations. Unlike global tools that assume perfect lane discipline, IRSL natively integrates with **MATLAB Driving Scenario Designer**.

### How it Works
The library acts as a wrapper around MATLAB's automated driving toolbox, injecting non-ideal behaviors and obstacles programmatically.

```mermaid
graph TD
    User[User / Researcher] -->|Define Parameters| Script[User Script<br>(e.g., test.m)]
    Script -->|Calls| Lib{IRSL Library}
    
    subgraph Modules
        Lib -->|Generates| RD[RashDriving Module<br>(Erratic Behavior)]
        Lib -->|Generates| BR[Barricade Module<br>(Construction Zones)]
        Lib -->|Generates| BL[Block Module<br>(Obstacles)]
    end
    
    subgraph MATLAB Backend
        RD -->|Spline Trajectories| Engine[Driving Scenario Designer]
        BR -->|Object Placement| Engine
        BL -->|Geometry| Engine
    end
    
    Engine -->|Output| Visual[Real-time Simulation]
    Engine -->|Output| Data[Collision & Velocity Logs]
