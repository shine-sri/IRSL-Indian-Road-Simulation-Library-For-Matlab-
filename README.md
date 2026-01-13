# IRSL: Indian Road Simulation Library

![Status](https://img.shields.io/badge/Status-Work_in_Progress-yellow)
![Platform](https://img.shields.io/badge/Platform-MATLAB-orange)
![Event](https://img.shields.io/badge/SIH_2025-Participant-blue)

[cite_start]**Problem Statement:** 25100 - Accelerating High-Fidelity Road Network Modeling for Indian Traffic Simulations[cite: 2, 3].

---

## 📖 Context & Origin
[cite_start]This project was originally initiated as a submission for the **Smart India Hackathon 2025** by **Team IRSL**[cite: 1, 8]. [cite_start]It addresses the limitations of standard traffic simulators, which often fail to capture the chaotic nature of Indian roads[cite: 25].

[cite_start]**Current Status:** The project is now being actively developed as an open-source library to fully realize the goals of modeling potholes, erratic driving, and unstructured traffic scenarios[cite: 28, 52].

---

## 🚀 Overview
**IRSL** is a MATLAB-based library designed to introduce realistic "chaos" into traffic simulations. Unlike global tools that assume perfect lane discipline, IRSL natively integrates with **MATLAB Driving Scenario Designer** to model:
* [cite_start]**Erratic/Rash Driving:** Vehicles that weave through traffic and deviate from lane centers[cite: 57, 191].
* [cite_start]**Road Obstacles:** Temporary construction barricades and debris blocks[cite: 63].
* [cite_start]**Future capabilities:** Potholes, autorickshaws, and Indian road signs.

---

## 🛠️ Features (Current Modules)

The following modules are implemented and functional in the current build:

### 1. Erratic Traffic Simulation (`RashDriving.m`)
[cite_start]Simulates a "Rash" Ego vehicle that deviates from lane centers using spline-based trajectories to interact with other vehicles[cite: 83].
* **Behavior:** Non-linear lane changes and variable speeds.
* **Visualization:** Real-time velocity display and path tracking on the simulation plot.
* **Physics:** Stops simulation upon collision or reaching the destination.

### 2. Barricade Simulation (`Barricade.m`)
[cite_start]Procedurally generates striped barricades (typical of Indian construction zones)[cite: 63, 73].
* **Customization:** Define exact `[x, y]` coordinates and width for obstacles.
* **Visuals:** Renders yellow-black striped warning patterns on the barricades.
* **Safety Logic:** Includes bounding-box collision detection.

### 3. Obstacle Blocks (`Block.m`)
Simulates solid rectangular obstructions (concrete blocks or debris) on the road.
* **Input:** Supports `[x, y, length, width]` array input to place multiple blocks dynamically.

---

## ⚙️ Installation & Usage

### Prerequisites
* MATLAB (R2023b or later recommended)
* [cite_start]Automated Driving Toolbox [cite: 91]

### Setup
1.  Clone the repository:
    ```bash
    git clone [https://github.com/your-username/IRSL.git](https://github.com/your-username/IRSL.git)
    ```
2.  Open MATLAB and navigate to the project folder.
3.  Run the installation script to add the library to your path:
    ```matlab
    install
    ```
    *(Output: ✅ IRSL library installed)*

### Running a Simulation
You can run the provided test script `test.m` or call functions directly in the MATLAB Command Window:

```matlab
% Run the Rash Driving scenario
[scenario, egoVehicle] = RashDriving();

% Run the Barricade scenario with custom obstacles
% Format: [x, y] coordinates
barricade_positions = [20, -2; 40, 2; 60, -1];
width = 2; % meters
[scenario, ego] = Barricade(barricade_positions, width);
