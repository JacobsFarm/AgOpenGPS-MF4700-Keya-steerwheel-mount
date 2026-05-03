// --- Spacing Settings ---
step_height = 60; // The height of each layer + spacing

// --- Toggles for additional boxes ---
show_divider_box = true; // Set to false to hide the divider box
show_simple_box = false;  // Set to false to hide the simple box

// --- Assembly with STL files ---

// LAYER 1: The base
color("LimeGreen") {
    import("box_for_agopenbox_Layer_1_box.stl");
}

// LAYER 2: The second layer
translate([0, 0, step_height]) {
    color("Cyan") {
        import("box_for_agopenbox_Layer_2_box.stl");
    }
}

// LAYER 3: The third layer
translate([0, 0, step_height * 2]) {
    color("RoyalBlue") {
        import("box_for_agopenbox_Layer_3_box.stl");
    }
}

// LAYER 4: The divider box (Optional)
if (show_divider_box) {
    translate([0, 0, step_height * 3]) {
        color("Orange") {
            import("box_for_agopenbox_divider_box.stl");
        }
    }
}

// LAYER 5: The simple box (Optional)
if (show_simple_box) {
    translate([0, 0, step_height * 4]) {
        color("Yellow") {
            import("box_for_agopenbox_simple_box.stl");
        }
    }
}

// THE LID: Kept at its original exact position
translate([0, 0, step_height * 3 - 88]) {
    color("Magenta") {
        import("box_for_agopenbox_lid.stl");
    }
}
