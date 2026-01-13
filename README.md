# 🇮🇳 IRSL — Indian Road Simulation Library

![Status](https://img.shields.io/badge/Status-Work_in_Progress-yellow)
![Platform](https://img.shields.io/badge/Platform-MATLAB-orange)
![Event](https://img.shields.io/badge/Smart%20India%20Hackathon-2025-blue)
![Domain](https://img.shields.io/badge/Domain-Autonomous%20Driving%20%7C%20Smart%20Cities-brightgreen)

> **Problem Statement (SIH 2025):**  
> **25100 — Accelerating High-Fidelity Road Network Modeling for Indian Traffic Simulations**

---

## 📌 Introduction

**IRSL (Indian Road Simulation Library)** is a MATLAB-based simulation framework designed to model the **non-ideal, unstructured, and chaotic nature of Indian road traffic**.

Most existing traffic simulators assume:
- Perfect lane discipline  
- Predictable, rule-following drivers  
- Structured and well-maintained road infrastructure  

These assumptions do not hold in real Indian driving environments.

IRSL explicitly violates these assumptions to enable **realistic, stress-inducing traffic simulations** for:
- ADAS validation  
- Autonomous driving research  
- Smart city traffic planning  

---

## 📖 Context & Origin

IRSL was originally initiated as a submission for the **Smart India Hackathon (SIH) 2025** by **Team IRSL**.

### Motivation

Current traffic simulators fail to realistically represent:
- Rash and erratic driving behavior  
- Temporary barricades and construction zones  
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
- **MATLAB Driving Scenario Designer**
- **Automated Driving Toolbox**

It acts as a **behavioral and obstacle abstraction layer**, injecting controlled chaos into otherwise idealized simulations.

### Core Objectives
- Introduce Indian-road realism into simulations  
- Enable repeatable yet configurable scenarios  
- Support academic research, hackathons, and prototyping  

---

## ⚙️ System Architecture

```mermaid
graph TD
    User[User / Researcher] -->|Define Parameters| Script[User Script<br>(test.m)]
    Script -->|Calls| Lib{IRSL Library}
    
    subgraph IRSL Modules
        Lib --> RD[RashDriving<br>Erratic Vehicle Behavior]
        Lib --> BR[Barricade<br>Construction Zones]
        Lib --> BL[Block<br>Road Obstacles]
    end
    
    subgraph MATLAB Engine
        RD -->|Spline Trajectories| Engine[Driving Scenario Designer]
        BR -->|Procedural Geometry| Engine
        BL -->|Collision Objects| Engine
    end
    
    Engine -->|Visualization| Visual[Real-Time Simulation]
    Engine -->|Logs| Data[Velocity • Collision • Events]
