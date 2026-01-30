//--- DISPLAY & EXPORT SETTINGS ---
// Set to 'true' to visualize or 'false' to hide during STL export (F6)
show_top_mold    = true;
show_bottom_mold = true;
show_dashboard   = true; // Reference geometry only; will not be part of the final print
show_cable_hook  = true; // Toggle for the cable hook accessory

// --- DASHBOARD DIMENSIONS ---
// Core dimensions of the dashboard part the mold fits around
front_width = 73; // b_v
rear_width  = 58; // b_a
dash_length = 70; // l
dash_height = 55; // d

// --- THICKNESS & TOLERANCE ---
side_wall   = 25; // Thickness of the mold side walls
top_wall    = 10; // Thickness of the top/bottom plates
clearance   = 0.3; // Small gap for fitment tolerance
mold_height = 25; // Height of the vertical mold section

// --- CABLE HOOK PARAMETERS ---
// Dimensions for the accessory hook module
inner_width     = 14;
height_left     = 28;    
height_right    = 14;   
thickness       = 5;           
depth           = 15;          
resolution      = 50;
foot_length     = 13;      
foot_thickness  = 4;        
foot_rounding_h = 10;

// --- EXTRA HOLE SETTINGS ---
// Utility hole for wiring or mounting
extra_hole_diameter = 12;
extra_hole_x_offset = 12;
extra_hole_y_offset = 35;

// Settings for Keya motor pin recess
extra_ring_diameter = 25;
extra_ring_depth    = -1; // Set to -1 to disable

// --- BOLT & WASHER SETTINGS ---
bolt_diameter      = 8;
bolt_clearance     = 0.4;
hole_diameter      = bolt_diameter + bolt_clearance;
hole_edge_distance = 14;
washer_diameter    = 16.2; // 16.2 for standard, 24.2 for fender washer
washer_depth       = 2.0;

// --- REAR RIGHT (RR) ADJUSTMENT ---
// Manual offsets for fine-tuning bolt hole alignment
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

if (show_cable_hook) {
    // Placement: [x, y, z] | Rotation: [degrees_x, degrees_y, degrees_z]
    translate([-49, 70, -10]) { 
        rotate([0, 0, 270]) {
            cable_hook();
        }
    }
}

// --- MODULES ---

// Generates the cable hook / foot accessory
module cable_hook() {
    union() {
        difference() {
            union() {
                // Left leg
                cube([thickness, height_left + thickness, depth]);
                // Right leg
                translate([inner_width + thickness, 0, 0])
                    cube([thickness, height_right + thickness, depth]);
                // Top bridge connection
                cube([inner_width + (2 * thickness), thickness, depth]);
                // Outer rounding
                translate([thickness + inner_width/2, 0, 0])
                    scale([1, 0.5, 1]) 
                    cylinder(h = depth, r = (inner_width/2) + thickness, $fn=resolution);
            }
            // Inner hollow section
            translate([thickness, thickness, -1]) {
                cube([inner_width, max(height_left, height_right) + 5, depth + 2]);
                translate([inner_width/2, 0, 1])
                    scale([1, 0.5, 1])
                    cylinder(h = depth, r = inner_width/2, $fn=resolution);
            }
        }
        // Foot plate with reinforcement
        translate([thickness, height_left + thickness, 0]) {
            translate([0, -foot_thickness, 0])
                cube([foot_length, foot_thickness, depth]);
            linear_extrude(height = depth)
                polygon(points=[[0, -foot_thickness], [foot_length, -foot_thickness], [0, -foot_thickness - foot_rounding_h]]);
        }
    }
}

// Generates the basic dashboard reference shape
module dashboard(b_v, b_a, l, d) {
    hull() {
        translate([0, 0, 0]) cube([b_v, 0.01, d]);
        translate([(b_v - b_a) / 2, l, 0]) cube([b_a, 0.01, d]);
    }
}

// TOP MOLD (Includes washer recesses and hexagonal cutout)
module top_mold(b_v, b_a, l, d, z_wand, t_wand, gap, m_h) {
    start_z = d - m_h;
    total_height = m_h + t_wand;
    top_z = start_z + total_height;
    rear_offset = (b_v - b_a) / 2;

    difference() {
        // 1. Main mold body
        translate([-z_wand - gap, 0, start_z]) 
            dashboard(b_v + (z_wand + gap) * 2, b_a + (z_wand + gap) * 2, l, total_height);
        
        // 2. Dashboard cutout (with clearance)
        translate([-gap, -1, -1]) 
            dashboard(b_v + gap * 2, b_a + gap * 2, l + 2, d + 2);
        
        // 3. Trim bottom
        translate([-200, -1, -100 + start_z]) cube([400, l + 2, 100]);
        
        // 4. Hexagonal cutout
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
            translate([p[0], p[1], start_z - 1]) cylinder(d = hole_diameter, h = total_height + 2, $fn = 50);
            translate([p[0], p[1], top_z - washer_depth]) cylinder(d = washer_diameter, h = washer_depth + 0.1, $fn = 60);
        }

        // 6. Utility hole
        translate([-extra_hole_x_offset, extra_hole_y_offset, start_z - 1]) cylinder(d = extra_hole_diameter, h = total_height + 2, $fn = 50);
        
        if (extra_ring_depth > 0) {
            translate([-extra_hole_x_offset, extra_hole_y_offset, top_z - extra_ring_depth]) cylinder(d = extra_ring_diameter, h = extra_ring_depth + 0.1, $fn = 60);
        }
    }
}

// BOTTOM MOLD (Includes center access cutout)
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
        
        // 3. Trim top
        translate([-200, -1, m_h]) cube([400, l + 2, 100]);
        
        // 4. Center access cutout
        translate([(b_v/2) - 15, -1, start_z - 1]) cube([30, 31, total_height + 2]);
        
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
            translate([p[0], p[1], start_z - 1]) cylinder(d = hole_diameter, h = total_height + 2, $fn = 50);
            translate([p[0], p[1], bottom_z - 0.1]) cylinder(d = washer_diameter, h = washer_depth + 0.1, $fn = 60);
        }

        // 6. Utility hole
        translate([-extra_hole_x_offset, extra_hole_y_offset, start_z - 1]) cylinder(d = extra_hole_diameter, h = total_height + 2, $fn = 50);
    }
}
