# 🇮🇳 IRSL — Indian Road Simulation Library

![Status](https://img.shields.io/badge/Status-Work_in_Progress-yellow)
![Platform](https://img.shields.io/badge/Platform-MATLAB-orange)
![Event](https://img.shields.io/badge/Smart%20India%20Hackathon-2025-blue)
![Domain](https://img.shields.io/badge/Domain-Autonomous%20Driving%20%7C%20Smart%20Cities-brightgreen)

> [cite_start]**Problem Statement (SIH 2025):** > **25100 — Accelerating High-Fidelity Road Network Modeling for Indian Traffic Simulations** [cite: 1, 2, 3]

---

## 📌 Introduction

**IRSL (Indian Road Simulation Library)** is a MATLAB-based simulation framework designed to model the **non-ideal, unstructured, and chaotic nature of Indian road traffic**.

Most existing traffic simulators assume:
- Perfect lane discipline  
- Predictable, rule-following drivers  
- Structured and well-maintained road infrastructure  

[cite_start]These assumptions do not hold in real Indian driving environments[cite: 25].

IRSL explicitly violates these assumptions to enable **realistic, stress-inducing traffic simulations** for:
- ADAS validation  
- Autonomous driving research  
- Smart city traffic planning  

---

## 📖 Context & Origin

[cite_start]IRSL was originally initiated as a submission for the **Smart India Hackathon (SIH) 2025** by **Team IRSL**[cite: 1, 7, 8].

### Motivation

Current traffic simulators fail to realistically represent:
- [cite_start]Rash and erratic driving behavior [cite: 25]
- [cite_start]Temporary barricades and construction zones [cite: 25]
- Informal lane usage  
- Sudden and unplanned road obstructions  

As a result, autonomy systems validated on such simulators often fail when deployed on Indian roads.

### Current Status

IRSL is now being actively developed as an **open-source MATLAB research library**, with emphasis on:
- Realism  
- Extensibility  
- Reproducibility  

---

## 🚀 Project Overview

IRSL integrates directly with:
- [cite_start]**MATLAB Driving Scenario Designer** [cite: 30]
- **Automated Driving Toolbox**

It acts as a **behavioral and obstacle abstraction layer**, injecting controlled chaos into otherwise idealized simulations.

### Core Objectives
- [cite_start]Introduce Indian-road realism into simulations [cite: 28]
- Enable repeatable yet configurable scenarios  
- Support academic research, hackathons, and prototyping  

---

## 🧩 Implemented Modules

[cite_start]IRSL follows a modular architecture, where each module encapsulates a specific real-world Indian road phenomenon[cite: 59].

### 1️⃣ Rash Driving Module — `RashDriving.m`
Simulates erratic, irrational, and non-rule-based driving behavior.

* **Behavior Modeled:**
    * [cite_start]Sudden lane deviations [cite: 52]
    * Non-linear trajectories
    * Variable acceleration and braking
    * Ignoring lane centers and traffic discipline
* **Technical Design:**
    * Spline-based trajectory perturbation
    * Lane center offset modeling
    * Velocity variation over time
    * Collision-aware simulation termination
* **Outputs:**
    * Real-time path visualization
    * Velocity profiling
    * Collision and event logs
* **Applications:**
    * Trajectory planner stress testing
    * Perception robustness evaluation
    * Failure-case generation for autonomous systems

### 2️⃣ Barricade Module — `Barricade.m`
[cite_start]Models temporary construction barricades commonly found on Indian roads[cite: 28].

* **Behavior Modeled:**
    * Partial lane blockage
    * Narrowed road corridors
    * Sudden appearance of construction zones
* **Technical Design:**
    * Procedural yellow–black striped geometry
    * Custom placement via `[x, y]` coordinates
    * Adjustable barricade width
    * Bounding-box collision detection
* **Applications:**
    * Construction-zone navigation testing
    * Obstacle avoidance validation
    * Dynamic road-layout simulation

### 3️⃣ Block Module — `Block.m`
Simulates solid road obstructions such as debris, concrete blocks, or broken infrastructure.

* **Behavior Modeled:**
    * Sudden road blockage
    * Partial or complete lane obstruction
* **Technical Design:**
    * Rectangular geometry modeling
    * Batch placement using `[x, y, length, width]`
    * Lightweight integration with existing scenarios
* **Applications:**
    * Emergency braking validation
    * Rerouting logic testing
    * Failure-case and edge-case simulation

---

## 🧠 Algorithmic Design (High-Level)

The system prioritizes interpretability, reproducibility, and research transparency.

| Component | Design Approach |
| :--- | :--- |
| **Erratic Driving** | Spline-based trajectory perturbation |
| **Obstacle Modeling** | Procedural geometry generation |
| **Collision Detection** | Bounding-box intersection |
| **Control Logic** | Rule-based behavioral modeling |
| **Output** | MATLAB scenario state, logs, visualization |

---

## ⚙️ Installation & Usage

### 🔧 Prerequisites
* MATLAB R2023b or later (recommended)
* Automated Driving Toolbox

### 📦 Setup

1.  Clone the repository:
    ```bash
    git clone [https://github.com/your-username/IRSL.git](https://github.com/your-username/IRSL.git)
    ```
2.  Install the library:
    ```matlab
    cd IRSL
    install
    ```
    *(Output: ✅ IRSL library successfully added to MATLAB path)*

### ▶️ Running Simulations

**Rash Driving Scenario:**
```matlab
[scenario, egoVehicle] = RashDriving();
