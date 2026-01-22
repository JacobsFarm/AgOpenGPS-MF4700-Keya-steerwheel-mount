## Configuration & Parameters

The model is fully customizable. You can modify the following variables at the top of the `.scad` file to suit your needs.

![PXL_20260122_123735240](https://github.com/user-attachments/assets/5f94d530-6f5a-4595-866e-7de0eb7ad897)
![PXL_20260122_123745819](https://github.com/user-attachments/assets/7804ae1a-e1db-4bc6-8e11-fb55a3784f18)

### 1. Visibility & Print Toggles

These toggles control what parts are rendered in the preview window.

| Variable | Description |
| :--- | :--- |
| `show_front_clamp` | Enables rendering of the front piece (with the logo). |
| `show_back_clamp` | Enables rendering of the rear piece (with the RAM ball). |
| `show_logo` | Displays the logo as a solid object (useful for alignment or multi-material setup). |
| `show_ref_rod` | Shows a transparent rod to visualize the fit of the clamp on the pipe. |

### 2. Main Geometry

* **`cylinder_diameter`**: The exact diameter of the pipe or rod you are mounting to.
* **`block_width` / `height` / `depth`**: The overall dimensions of the clamp body.
* **`gap`**: The distance between the two halves. This allows the bolts to tighten the clamp onto the rod securely.
* **`tolerance`**: Adds a tiny bit of extra room around the rod for easier fitment.

### 3. Hardware (Bolts & Recesses)

* **`bolt_diameter`**: Size of the screw holes (Standard: `8mm` for M8 hardware).
* **`bolt_margin_v`**: Sets how far the bolts are positioned from the top and bottom edges.
* **`recess_diameter`**: The width of the hole for the bolt head or nut (counterbore).
* **`recess_depth`**: How deep the bolt head or nut is sunken into the block.

### 4. RAM Mount & Logo Fit

* **`ball_diameter`**: The diameter of the mounting ball (Default is `25mm` / 1").
* **`ball_distance`**: Distance from the clamp face to the center of the ball.
* **`logo_tolerance`**: Increases the size of the logo cutout. A value of `0.1` to `0.3` is recommended to ensure a separate printed logo fits into the engraving.

---

## Module Overview

The script is modular, allowing you to edit specific parts of the geometry without breaking the rest:

* **`front_clamp()`**: Manages the front block. It uses a `difference()` operation to subtract the rod cylinder, bolt holes, and the logo simultaneously.
* **`back_clamp()`**: Manages the rear block. It includes a unique internal reinforcement rib (configured via `wall_thickness`) to ensure the RAM ball doesn't snap off under vibration.
* **`ram_ball()`**: Generates the mounting sphere and the supporting neck.
* **`logo_overlay()`**: Handles the DXF import. It uses `offset(r = logo_tolerance)` to expand the 2D path before extruding, creating the necessary clearance for inlays.
* **`bolt_holes()`** & **`bolt_recesses()`**: Shared utility modules that ensure both halves of the clamp have perfectly aligned mounting points.
