/ --- DISPLAY & EXPORT SETTINGS ---
// Set to 'true' to visualize or 'false' to hide during STL export (F6)
show_top_mold    = true; // Enable only this to export the Top part
show_bottom_mold = true; // Enable only this to export the Bottom part
show_dashboard   = true; // Reference geometry only; will not be part of the final print

// --- DASHBOARD DIMENSIONS ---
// The core dimensions of the dashboard part the mold fits around
front_width = 73;  // Width at the front (b_v)
rear_width  = 58;  // Width at the rear (b_a)
dash_length = 70;  // Length from front to back (l)
dash_height = 55;  // Height of the dashboard (d)

// --- THICKNESS & TOLERANCE ---
side_wall   = 25;  // Thickness of the side walls of the mold
top_wall    = 10;  // Thickness of the top/bottom plate
clearance   = 0.3; // Small gap between dashboard and mold for fitment
mold_height = 25;  // Height of the vertical part of the mold

// --- EXTRA HOLE SETTINGS ---
// Settings for an additional utility hole (e.g., for wiring)
extra_hole_diameter = 12;
extra_hole_x_offset = 12; // X-distance from the dashboard edge
extra_hole_y_offset = 35; // Y-distance from the side edge

// settings for recess for pin from keya motor
extra_ring_diameter = 25; // Diameter for the recess ring (top side)
extra_ring_depth    = -1; // Depth of the recess (-1 to disable)

// --- BOLT & WASHER SETTINGS ---
bolt_diameter      = 8;   // Diameter of the M8 bolt
bolt_clearance     = 0.4; // Extra space for the bolt to slide through
hole_diameter      = bolt_diameter + bolt_clearance;
hole_edge_distance = 14;  // Distance from the holes to the mold edge

// Recess for the washer
washer_diameter    = 16.2; // 16.2 for standard washer, 24.2 for fender washer
washer_depth       = 2.0;  // 2.0 for standard washer, 2.4 for fender washer

// --- REAR RIGHT (RR) ADJUSTMENT ---
// Manual offsets to adjust the position of the rear-right bolt hole
rr_x_offset = 0; 
rr_y_offset = 2;

// --- EXECUTION ---

if (show_dashboard) {
    %dashboard(front_width, rear_width, dash_length, dash_height);
}

if (show_top_mold) {
    top_mold(front_width, rear_width, dash_length, dash_height, side_wall, top_wall, clearance, mold_height);
}

if (show_bottom_mold) {
    bottom_mold(front_width, rear_width, dash_length, dash_height, side_wall, top_wall, clearance, mold_height);
}

// --- MODULES ---

// Generates the basic dashboard shape using a hull between two slices
module dashboard(b_v, b_a, l, d) {
    hull() {
        translate([0, 0, 0])
            cube([b_v, 0.01, d]);
        translate([(b_v - b_a) / 2, l, 0])
            cube([b_a, 0.01, d]);
    }
}

// TOP MOLD (Includes washer recesses and the hex cutout)
module top_mold(b_v, b_a, l, d, z_wand, t_wand, gap, m_h) {
    start_z = d - m_h;
    total_height = m_h + t_wand;
    top_z = start_z + total_height;
    rear_offset = (b_v - b_a) / 2;

    difference() {
        // 1. Main mold body
        translate([-z_wand - gap, 0, start_z]) 
            dashboard(b_v + (z_wand + gap) * 2, b_a + (z_wand + gap) * 2, l, total_height);

        // 2. Dashboard cutout (including clearance)
        translate([-gap, -1, -1]) 
            dashboard(b_v + gap * 2, b_a + gap * 2, l + 2, d + 2);

        // 3. Cut off bottom part
        translate([-200, -1, -100 + start_z])
            cube([400, l + 2, 100]);

        // 4. Hexagonal recess
        let(inner_wall_x = -gap) {
            translate([0, 0, start_z - 0.01]) 
            linear_extrude(height = 28.01) 
            polygon([
                [inner_wall_x + 50, 52], [inner_wall_x + 22, 52], [inner_wall_x + 13, 30], 
                [inner_wall_x + 13, 8], [inner_wall_x + 62, 8], [inner_wall_x + 62, 30]
            ]);
        }

        // 5. Bolt holes and washer recesses
        y_front = hole_edge_distance;
        y_rear  = l - hole_edge_distance;
        
        x_left_f  = -gap - (z_wand / 2);
        x_right_f = b_v + gap + (z_wand / 2);
        x_left_r  = rear_offset - gap - (z_wand / 2);
        x_right_r = rear_offset + b_a + gap + (z_wand / 2);

        positions = [
            [x_left_f - rr_x_offset, y_front - rr_y_offset], 
            [x_left_r, y_rear], 
            [x_right_f, y_front], 
            [x_right_r, y_rear]
        ];

        for (p = positions) {
            // Bolt shaft
            translate([p[0], p[1], start_z - 1])
                cylinder(d = hole_diameter, h = total_height + 2, $fn = 50);
            // Washer recess
            translate([p[0], p[1], top_z - washer_depth])
                cylinder(d = washer_diameter, h = washer_depth + 0.1, $fn = 60);
        }

        // 6. Extra utility hole
        translate([-extra_hole_x_offset, extra_hole_y_offset, start_z - 1])
            cylinder(d = extra_hole_diameter, h = total_height + 2, $fn = 50);

        // Extra ring recess (only if depth > 0)
        if (extra_ring_depth > 0) {
            translate([-extra_hole_x_offset, extra_hole_y_offset, top_z - extra_ring_depth])
                cylinder(d = extra_ring_diameter, h = extra_ring_depth + 0.1, $fn = 60);
        }
    }
}

// BOTTOM MOLD (Includes center cutout and bolt holes)
module bottom_mold(b_v, b_a, l, d, z_wand, t_wand, gap, m_h) {
    start_z = -t_wand;
    total_height = m_h + t_wand;
    bottom_z = start_z;
    rear_offset = (b_v - b_a) / 2;

    difference() {
        // 1. Main mold body
        translate([-z_wand - gap, 0, start_z]) 
            dashboard(b_v + (z_wand + gap) * 2, b_a + (z_wand + gap) * 2, l, total_height);

        // 2. Dashboard cutout
        translate([-gap, -1, -1]) 
            dashboard(b_v + gap * 2, b_a + gap * 2, l + 2, d + 2);

        // 3. Cut off top part
        translate([-200, -1, m_h])
            cube([400, l + 2, 100]);

        // 4. Center access cutout
        translate([(b_v/2) - 15, -1, start_z - 1])
            cube([30, 31, total_height + 2]);

        // 5. Bolt holes
        y_front = hole_edge_distance;
        y_rear  = l - hole_edge_distance;
        
        x_left_f  = -gap - (z_wand / 2);
        x_right_f = b_v + gap + (z_wand / 2);
        x_left_r  = rear_offset - gap - (z_wand / 2);
        x_right_r = rear_offset + b_a + gap + (z_wand / 2);

        positions = [
            [x_left_f - rr_x_offset, y_front - rr_y_offset], 
            [x_left_r, y_rear], 
            [x_right_f, y_front], 
            [x_right_r, y_rear]
        ];

        for (p = positions) {
            // Bolt shaft
            translate([p[0], p[1], start_z - 1])
                cylinder(d = hole_diameter, h = total_height + 2, $fn = 50);
            // Optional: Washer recess for bottom (currently matches top logic)
            translate([p[0], p[1], bottom_z - 0.1])
                cylinder(d = washer_diameter, h = washer_depth + 0.1, $fn = 60);
        }

        // 6. Extra utility hole (no recess)
        translate([-extra_hole_x_offset, extra_hole_y_offset, start_z - 1])
            cylinder(d = extra_hole_diameter, h = total_height + 2, $fn = 50);
    }

}
