// --- Settings ---
$fn = 60; 
clearance = 0.2; // Extra space for a proper fit

// Call the module
shaft_geometry(extra_d = clearance);

// --- Modules ---

module shaft_geometry(extra_d = 0) {
    d = 10 + extra_d;
    h_cylinder = 100;
    w = 5 + extra_d;
    l = 10 + extra_d;
    h_block = 20;

    // In preview mode (F5), we show the shaft as a transparent guide
    // When rendering (F6), nothing is generated so the shaft "disappears"
    if ($preview) {
        color([0.6, 0.7, 1.0, 0.5]) draw_shaft(d, h_cylinder, w, l, h_block);
    } 
    // The absence of an 'else' block ensures no geometry is produced during render
}

// Sub-module for the actual geometry
module draw_shaft(d, h_cylinder, w, l, h_block) {
    union() {
        cylinder(h = h_cylinder, d = d); 
        translate([0, 0, h_cylinder + (h_block / 2)]) {
            rotate([0, 0, 90]) {
                cube([w, l, h_block], center = true);
            }
        }
    }
}
