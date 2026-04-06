show_full_shaft = true;
show_bottom_clamp = true;
show_top_clamp = true;
show_mounted_shaft = true;

mounting_hole_diameter = 8.4;
washer_diameter = 16.2;
washer_thickness = 2.1;

top_screw_diameter = 5;
top_shaft_diameter = 12;
top_material_thickness = 5;

shaft_width_start_bottom = 85.5;
shaft_width_middle = 92.5;
shaft_width_start_top = 75.5; 
shaft_width_end_top = 82.5; 

shaft_length = 60;
shaft_segment_height = 60;

taper_x_minus_bottom = 3; 
taper_x_minus_top = 3;    

bottom_clamp_thickness = 55;
bottom_shaft_overlap = 35;
top_clamp_thickness = 55;
top_shaft_overlap = 35;

overhang_plus_y = 35;
overhang_minus_y = 70;

hole_x_offset_left = 16;
hole_x_offset_right = 16;
hole_y_offset_minus = 13;
hole_y_offset_plus = 15;
hole_5mm_y_offset = 44;

mounted_shaft_diameter = 48;
mounted_shaft_height = 50;

if (show_full_shaft) {
    combined_shaft();
}

if (show_bottom_clamp) {
    bottom_clamp();
}

if (show_top_clamp) {
    top_clamp();
}

if (show_mounted_shaft) {
    mounted_shaft_display();
}

module mounted_shaft_display() {
    z_pos_top = (shaft_segment_height * 2) - top_shaft_overlap;
    y_min_total = -(shaft_width_start_bottom/2 + overhang_minus_y);
    y_holes_5mm = y_min_total + hole_5mm_y_offset;
    
    translate([shaft_length/2, y_holes_5mm, z_pos_top + top_clamp_thickness])
        %cylinder(h=mounted_shaft_height, d=mounted_shaft_diameter, $fn=50);
}

module combined_shaft() {
    // Alleen de taper_bottom wordt toegepast op het onderste segment
    shaft_segment_shape(shaft_width_start_bottom, shaft_width_middle, 0, taper_x_minus_bottom, 0, true);
    // Alleen de taper_top wordt toegepast op het bovenste segment
    shaft_segment_shape(shaft_width_start_top, shaft_width_end_top, shaft_segment_height, 0, taper_x_minus_top, true);
}

module bottom_clamp() {
    z_pos_bottom = -bottom_clamp_thickness + bottom_shaft_overlap;
    y_min_total = -(shaft_width_start_bottom/2 + overhang_minus_y);
    y_max_total = (shaft_width_start_bottom/2 + overhang_plus_y);
    
    difference() {
        clamp_base_shape(shaft_width_start_bottom, z_pos_bottom, bottom_clamp_thickness);
        combined_shaft_solid();
        
        translate([shaft_length/2 - hole_x_offset_left, y_min_total + hole_y_offset_minus, 0])
            mounting_hole(z_pos_bottom, bottom_clamp_thickness, false);
        translate([shaft_length/2 + hole_x_offset_right, y_min_total + hole_y_offset_minus, 0])
            mounting_hole(z_pos_bottom, bottom_clamp_thickness, false);
        translate([shaft_length/2 - hole_x_offset_left, y_max_total - hole_y_offset_plus, 0])
            mounting_hole(z_pos_bottom, bottom_clamp_thickness, false);
        translate([shaft_length/2 + hole_x_offset_right, y_max_total - hole_y_offset_plus, 0])
            mounting_hole(z_pos_bottom, bottom_clamp_thickness, false);
    }
}

module top_clamp() {
    z_pos_top = (shaft_segment_height * 2) - top_shaft_overlap;
    y_min_total = -(shaft_width_start_bottom/2 + overhang_minus_y);
    y_max_total = (shaft_width_start_bottom/2 + overhang_plus_y);
    y_holes_5mm = y_min_total + hole_5mm_y_offset;
    
    difference() {
        clamp_base_shape(shaft_width_start_bottom, z_pos_top, top_clamp_thickness);
        combined_shaft_solid();
        
        x_pos_holes = [shaft_length/2 - hole_x_offset_left, shaft_length/2 + hole_x_offset_right];
        for (x = x_pos_holes) {
            translate([x, y_holes_5mm, z_pos_top - 1])
                cylinder(h = top_clamp_thickness - top_material_thickness + 1, d = top_shaft_diameter, $fn=50);
            translate([x, y_holes_5mm, z_pos_top + top_clamp_thickness - top_material_thickness])
                cylinder(h = top_material_thickness + 1, d = top_screw_diameter, $fn=50);
        }
            
        translate([shaft_length/2 - hole_x_offset_left, y_min_total + hole_y_offset_minus, 0])
            mounting_hole(z_pos_top, top_clamp_thickness, true);
        translate([shaft_length/2 + hole_x_offset_right, y_min_total + hole_y_offset_minus, 0])
            mounting_hole(z_pos_top, top_clamp_thickness, true);
        translate([shaft_length/2 - hole_x_offset_left, y_max_total - hole_y_offset_plus, 0])
            mounting_hole(z_pos_top, top_clamp_thickness, true);
        translate([shaft_length/2 + hole_x_offset_right, y_max_total - hole_y_offset_plus, 0])
            mounting_hole(z_pos_top, top_clamp_thickness, true);
    }
}

module mounting_hole(z_start, thickness, is_top) {
    translate([0, 0, z_start - 1])
        cylinder(h=thickness + 2, d=mounting_hole_diameter, $fn=50);
    
    if (is_top) {
        translate([0, 0, z_start + thickness - 2])
            cylinder(h=washer_thickness, d=washer_diameter, $fn=50);
    } else {
        translate([0, 0, z_start - 0.1])
            cylinder(h=washer_thickness, d=washer_diameter, $fn=50);
    }
}

module combined_shaft_solid() {
    shaft_segment_shape(shaft_width_start_bottom, shaft_width_middle, 0, taper_x_minus_bottom, 0, false);
    shaft_segment_shape(shaft_width_start_top, shaft_width_end_top, shaft_segment_height, 0, taper_x_minus_top, false);
}

module clamp_base_shape(width_shaft, z_pos, thickness) {
    translate([0, -(width_shaft/2 + overhang_minus_y), z_pos])
        cube([shaft_length, width_shaft + overhang_minus_y + overhang_plus_y, thickness]);
}

// Aangepast: ontvangt nu taper_b (bottom) en taper_t (top)
module shaft_segment_shape(w_start, w_end, z_offset, taper_b, taper_t, is_transparent) {
    if (is_transparent) {
        %shaft_polyhedron(w_start, w_end, z_offset, taper_b, taper_t);
    } else {
        shaft_polyhedron(w_start, w_end, z_offset, taper_b, taper_t);
    }
}

// Aangepast: Z-coördinaten op x=0 compenseren nu met taper_b en taper_t
module shaft_polyhedron(w_start, w_end, z_offset, taper_b, taper_t) {
    polyhedron(
        points = [
            [0, -w_start/2, z_offset + taper_b], // 0: Linksonder-voor (aangepast voor bottom taper)
            [shaft_length, -w_end/2, z_offset],  // 1: Rechtsonder-voor
            [shaft_length, w_end/2, z_offset],   // 2: Rechtsonder-achter
            [0, w_start/2, z_offset + taper_b],  // 3: Linksonder-achter (aangepast voor bottom taper)
            [0, -w_start/2, z_offset + shaft_segment_height - taper_t], // 4: Linksboven-voor (aangepast voor top taper)
            [shaft_length, -w_end/2, z_offset + shaft_segment_height],  // 5: Rechtsboven-voor
            [shaft_length, w_end/2, z_offset + shaft_segment_height],   // 6: Rechtsboven-achter
            [0, w_start/2, z_offset + shaft_segment_height - taper_t]   // 7: Linksboven-achter (aangepast voor top taper)
        ],
        faces = [
            [0, 1, 2, 3],
            [4, 5, 1, 0],
            [7, 6, 5, 4],
            [3, 2, 6, 7],
            [0, 3, 7, 4],
            [1, 5, 6, 2]
        ]
    );
}
