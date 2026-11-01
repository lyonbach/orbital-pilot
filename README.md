# Orbital Pilot

A 3D side-view spaceship landing game built with Godot 4.

You pilot a spacecraft through a side-on, 2D-style view while using real 3D physics to control descent, lateral movement, tilt, fuel, and landing impact.

## Goal

Land gently and upright on the designated landing pad. Excessive impact speed, excessive tilt, or landing outside the pad results in a crash.

## Controls

| Action | Keys |
|---|---|
| Main thrust | `Space`, `W`, or `Up` |
| Lateral thrust left | `A` or `Left` |
| Lateral thrust right | `D` or `Right` |
| Rotate left | `Q` |
| Rotate right | `E` |

## Project structure

```text
scenes/
  main.tscn
  ship.tscn
  landing_pad.tscn
scripts/
  ship.gd
  main_camera.gd
  landing_pad.gd
assets/
```

## Getting started

1. Install Godot 4.x.
2. Open Godot and choose **Import**.
3. Select this repository folder.
4. Open `project.godot`.
5. Press **F5** or click **Play**.

## Development milestone

The initial prototype includes:

- 3D physics-based spacecraft using `RigidBody3D`
- Side-view orthographic camera
- Main and lateral thrust
- Rotation control
- Fuel consumption
- Landing-pad detection
- Impact-speed and tilt checks
- Success and crash feedback
