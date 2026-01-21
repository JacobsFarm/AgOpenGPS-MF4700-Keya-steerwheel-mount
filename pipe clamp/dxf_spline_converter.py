import ezdxf
from ezdxf import recover
import os
import sys

# ==========================================
# CONFIGURATION / PARAMETERS
# ==========================================

# Path to the input DXF file. 
# You can change this here, or pass a file path when calling the function.
DEFAULT_INPUT_FILE = "example_file.dxf"

# Precision for flattening splines. 
# Lower value = more points (smoother curve), higher file size.
# 0.01 is very smooth, 0.1 is standard, 1.0 is rough.
FLATTENING_PRECISION = 0.1 

# Suffix added to the output file to distinguish it from the original.
OUTPUT_SUFFIX = "_openscad_ready"

# ==========================================
# MAIN SCRIPT
# ==========================================

def convert_splines_to_polylines(input_path, precision=FLATTENING_PRECISION):
    """
    Reads a DXF file, converts all SPLINE entities to LWPOLYLINE entities,
    and saves the result as a new file.
    """
    
    # 1. Validate input
    if not os.path.exists(input_path):
        print(f"[Error] File not found: {input_path}")
        return

    # Construct output path
    base, ext = os.path.splitext(input_path)
    output_path = f"{base}{OUTPUT_SUFFIX}{ext}"

    try:
        print(f"Processing: {input_path} ...")

        # 2. Load the DXF file with error recovery
        doc, auditor = recover.readfile(input_path)
        if auditor.has_errors:
            print(f"[Warning] Found {len(auditor.errors)} errors in source file. Attempting recovery.")

        msp = doc.modelspace()

        # 3. Find Splines
        splines = msp.query('SPLINE')
        if not splines:
            print("No SPLINE entities found in this file. Nothing to convert.")
            return

        print(f"Found {len(splines)} splines. Converting with precision {precision}...")

        # 4. Convert Splines
        count = 0
        for spline in splines:
            # Flatten spline to points
            # 'distance' is the maximum distance from the approximation line to the curve
            try:
                points = spline.flattening(distance=precision)
                
                # Create a new polyline with these points
                msp.add_lwpolyline(points, dxfattribs={
                    'layer': spline.dxf.layer,
                    'color': spline.dxf.color
                })
                
                # Remove the original spline
                spline.destroy()
                count += 1
            except Exception as e:
                print(f"[Warning] Could not convert a spline: {e}")

        # 5. Save output
        doc.saveas(output_path)
        print("-" * 30)
        print(f"Success! Converted {count} splines.")
        print(f"Saved as: {output_path}")
        print("-" * 30)

    except Exception as e:
        print(f"[Critical Error] An error occurred: {e}")

# ==========================================
# EXECUTION
# ==========================================

if __name__ == "__main__":
    # Uses the configuration variable at the top
    # Or replace 'DEFAULT_INPUT_FILE' with a specific path string if testing
    
    file_to_process = DEFAULT_INPUT_FILE
    
    # Optional: Allow passing filename via command line
    # Usage: python script.py my_file.dxf
    if len(sys.argv) > 1:
        file_to_process = sys.argv[1]

    convert_splines_to_polylines(file_to_process)
