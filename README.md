MF4700-Keya-Steering-Mount

Parametric OpenSCAD mount for Keya steering motors on Massey Ferguson consoles. Designed for AgOpenGPS on the MF 4700 Series (4707, 4708, 4709, 4710) and 4700 M-Series (4708 M, 4709 M, 4710 M).
🚜 Compatibility

    Massey Ferguson 4700 Global Series: 4707, 4708, 4709, 4710.

    Massey Ferguson 4700 M-Series: 4708 M, 4709 M, 4710 M.

    Motor: Keya Brushless Electric Steering Motor.

<img width="578" height="465" alt="mf steerwheel" src="https://github.com/user-attachments/assets/9b9d3c3b-5674-43dd-a152-267c512f25a5" />
<img width="520" height="458" alt="mf steerwheel 3" src="https://github.com/user-attachments/assets/8ca1f74a-65d1-49f8-aede-9fadd3997553" />
<img width="567" height="438" alt="mf steerwheel 2" src="https://github.com/user-attachments/assets/5196b219-f83a-4a21-a3a6-277d7856ace3" />

![PXL_20260116_161837571(1)](https://github.com/user-attachments/assets/6a119f3a-2b5a-412f-9d60-54cc49c7b51a)
![PXL_20260116_161953877](https://github.com/user-attachments/assets/0b34046c-415d-4cc6-b676-576f6aae8176)

🛠 Features

    Two-Piece Design: Includes top and bottom clamp molds for a secure, no-drill installation on the steering column.

    High Strength: 25mm side walls and 10mm top plates for maximum torque resistance.

    Hardware Ready: Optimized for M8 bolts with integrated recesses for standard or fender washers.

    Utility Hole: 12mm extra hole for wiring or sensors.

    Parametric: Adjust clearance (standard 0.3mm) or dimensions via OpenSCAD for a perfect fit.

## 🖨 How to Export for Printing

Since this model contains multiple parts, you need to toggle the visibility in OpenSCAD before rendering your STL files:

* **Top Part**
  * Set `show_top_mold = true` and `show_bottom_mold = false`.
  * Press **F6** to render and **F7** to save as STL.

* **Bottom Part**
  * Set `show_top_mold = false` and `show_bottom_mold = true`.
  * Press **F6** to render and **F7** to save as STL.

* **Dashboard Reference**
  * The `show_dashboard` toggle is for visualization only. 
  * It is automatically excluded from the final render (using the `%` background operator).

📦 Files

    MF4700-keya_steerwheel-mount.scad: The source model.

    top_mold.stl: Printable top section.

    bottom_mold.stl: Printable bottom section.
