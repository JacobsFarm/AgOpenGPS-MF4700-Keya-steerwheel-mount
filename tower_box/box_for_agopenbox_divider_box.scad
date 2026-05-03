show_box = true;        // Set to true to render the bottom enclosure
show_lid = false;       // Set to true to render the top lid

L = 180;                // Outer length of the box
W = 175;                 // Outer width of the box
H_box = 60;             // Height of the bottom box part
H_lid = 5;              // Total thickness of the lid
wall = 4;               // Outer wall thickness
bottom_thickness = 2;   // Thickness of the bottom floor
R = 6;                  // Outer corner radius

// --- Dividers ---
divider_thickness = 2;   // Thickness of the internal dividers

show_divider_x1 = true;  // Divider parallel to X-axis
divider_x1_pos = -29;    // Y-position of divider x1

show_divider_x2 = true;  // Divider parallel to X-axis
divider_x2_pos = 29;     // Y-position of divider x2

show_divider_y1 = false;  // Divider parallel to Y-axis
divider_y1_pos = -30;    // X-position of divider y1

show_divider_y2 = false;  // Divider parallel to Y-axis
divider_y2_pos = 30;     // X-position of divider y2

m8_hole_D = 8.5;         // Clearance hole for M8 threaded rod (draadeind)
m8_head_D = 19.5;        // Diameter of the M8 bolt head / nut recess (flush fit)
m8_head_H = 0;          // Depth of the recess cut into the bottom
corner_post_D = 24;      // Increased diameter of the corner posts to fit M8 recess
corner_post_inset = 12;  // Inset of the corner posts so the recess doesn't break outer walls
recess_diameter = 16.2;  // Diameter for M8 washer recess in the lid
recess_depth = 2.2;      // Depth for M8 washer recess in the lid

gland_spacing = 30;     // Center-to-center distance between the 4 holes on a side

show_gland_front_1 = false;  gland_front_1_D = 15.5;
show_gland_front_2 = false;  gland_front_2_D = 15.5;
show_gland_front_3 = false;  gland_front_3_D = 20.5;
show_gland_front_4 = false;  gland_front_4_D = 20.5;

show_gland_back_1  = false;  gland_back_1_D = 20.5;
show_gland_back_2  = false;  gland_back_2_D = 20.5;
show_gland_back_3  = false;  gland_back_3_D = 15.5;
show_gland_back_4  = false;  gland_back_4_D = 15.5;

show_gland_left_1  = false;  gland_left_1_D = 15.5;
show_gland_left_2  = false;  gland_left_2_D = 15.5;
show_gland_left_3  = false;  gland_left_3_D = 26.0;
show_gland_left_4  = false;  gland_left_4_D = 15.5;

show_gland_right_1 = false;  gland_right_1_D = 15.5;
show_gland_right_2 = false;  gland_right_2_D = 15.5;
show_gland_right_3 = false;  gland_right_3_D = 15.5;
show_gland_right_4 = false;  gland_right_4_D = 15.5;

lip_h = 0;              // Height of the interlocking lip
lip_offset = 2;         // Thickness/offset of the inner lip
fit_tolerance = 0.2;    // Extra clearance between lid and box

show_mid_pillars = false; // Extra pillars in the middle (Y-axis walls)
show_end_pillars = false; // Extra pillars in the middle (X-axis walls)

post_D = 15;            // Diameter of the solid screw posts (mid-pillars)
insert_D = 8.5;         // Diameter of the heat insert hole (mid-pillars)
screw_D = 3.7;          // Diameter of the Lid screw hole (mid-pillars)
head_D = 7.6;           // Diameter of the screw head top
head_depth = 2.5;       // Depth of the screw head chamfer
fillet_D = 6;           // Diameter of the fillet between posts and walls

enable_front_foot = false; // Front mounting foot
enable_back_foot = false;  // Back mounting foot
foot_width = 30;
foot_length = 20;
screw_hole_diameter = 4.5;
gusset_height = 15;

show_bottom_pegs = false; // Set to true to show the 2 pillars on the floor
peg_D = 4.5;             // Diameter of the pillars
peg_H = 20;              // Height of the pillars
peg_spacing = 120;       // Distance between the centers of the two pillars
peg_offset_x = 0;        // Move both pillars along the X-axis over the floor
peg_offset_y = 35;       // Move both pillars along the Y-axis over the floor

show_bottom_hole = false; // Set to true to cut a movable hole in the floor
bottom_hole_D = 12.0;    // Diameter of the hole
bottom_hole_x = 50;       // Move the hole along the X-axis
bottom_hole_y = 0;       // Move the hole along the Y-axis

// Enable (true/false) | Filename | X | Y | Z (from bottom) | Rot X | Rot Y | Rot Z
show_stl_1  = false;  stl_1_filename  = "model_1.stl"; stl_1_x  = -10; stl_1_y  = -33; stl_1_z  = 0; stl_1_rot_x  = 0; stl_1_rot_y  = 0; stl_1_rot_z  = 90;
show_stl_2  = false;  stl_2_filename  = "model_2.stl"; stl_2_x  = 53;  stl_2_y  = -33; stl_2_z  = 0; stl_2_rot_x  = 0; stl_2_rot_y  = 0; stl_2_rot_z  = 90;
show_stl_3  = false; stl_3_filename  = "model_3.stl"; stl_3_x  = -10;   stl_3_y  = 45;   stl_3_z  = 0; stl_3_rot_x  = 0; stl_3_rot_y  = 0; stl_3_rot_z  = 90;
show_stl_4  = false; stl_4_filename  = "model_4.stl"; stl_4_x  = 53;   stl_4_y  = 45;   stl_4_z  = 0; stl_4_rot_x  = 0; stl_4_rot_y  = 0; stl_4_rot_z  = 90;
show_stl_5  = false; stl_5_filename  = "model_5.stl"; stl_5_x  = 0;   stl_5_y  = 0;   stl_5_z  = 0; stl_5_rot_x  = 0; stl_5_rot_y  = 0; stl_5_rot_z  = 0;
show_stl_6  = false; stl_6_filename  = "model_6.stl"; stl_6_x  = 0;   stl_6_y  = 0;   stl_6_z  = 0; stl_6_rot_x  = 0; stl_6_rot_y  = 0; stl_6_rot_z  = 0;
show_stl_7  = false; stl_7_filename  = "model_7.stl"; stl_7_x  = 0;   stl_7_y  = 0;   stl_7_z  = 0; stl_7_rot_x  = 0; stl_7_rot_y  = 0; stl_7_rot_z  = 0;
show_stl_8  = false; stl_8_filename  = "model_8.stl"; stl_8_x  = 0;   stl_8_y  = 0;   stl_8_z  = 0; stl_8_rot_x  = 0; stl_8_rot_y  = 0; stl_8_rot_z  = 0;
show_stl_9  = false; stl_9_filename  = "model_9.stl"; stl_9_x  = 0;   stl_9_y  = 0;   stl_9_z  = 0; stl_9_rot_x  = 0; stl_9_rot_y  = 0; stl_9_rot_z  = 0;
show_stl_10 = false; stl_10_filename = "model_10.stl";stl_10_x = 0;   stl_10_y = 0;   stl_10_z = 0; stl_10_rot_x = 0; stl_10_rot_y = 0; stl_10_rot_z = 0;
show_stl_11 = false; stl_11_filename = "model_11.stl";stl_11_x = 0;   stl_11_y = 0;   stl_11_z = 0; stl_11_rot_x = 0; stl_11_rot_y = 0; stl_11_rot_z = 0;
show_stl_12 = false; stl_12_filename = "model_12.stl";stl_12_x = 0;   stl_12_y = 0;   stl_12_z = 0; stl_12_rot_x = 0; stl_12_rot_y = 0; stl_12_rot_z = 0;

$fn = 60;

module outer_profile() {
    offset(r=R) square([L - 2*R, W - 2*R], center=true);
}

module raw_cavity() {
    difference() {
        offset(r=R - wall) square([L - 2*R, W - 2*R], center=true);
        
        for(i = [-1, 1], j = [-1, 1]) {
            translate([i*(L/2 - corner_post_inset), j*(W/2 - corner_post_inset)])
                circle(d=corner_post_D);
        }
        
        if (show_mid_pillars) {
            for(j = [-1, 1]) {
                translate([0, j*(W/2 - R)])
                    circle(d=post_D);
            }
        }

        if (show_end_pillars) {
            for(i = [-1, 1]) {
                translate([i*(L/2 - R), 0])
                    circle(d=post_D);
            }
        }
    }
}

module cavity_profile() {
    offset(r=fillet_D/2) 
        offset(r=-fillet_D/2) 
            raw_cavity();
}

module lip_profile() {
    difference() {
        offset(r=lip_offset) cavity_profile();
        cavity_profile();
    }
}

module mounting_foot() {
    difference() {
        union() {
            translate([0, -foot_width/2, 0])
                cube([foot_length, foot_width, bottom_thickness]);
            
            translate([0, -foot_width/2 + wall/2, 0])
                rotate([90, 0, 0])
                linear_extrude(wall, center=true)
                polygon(points=[
                    [-0.1, 0], 
                    [foot_length, 0], 
                    [foot_length, bottom_thickness], 
                    [-0.1, gusset_height + bottom_thickness]
                ]);
                
            translate([0, foot_width/2 - wall/2, 0])
                rotate([90, 0, 0])
                linear_extrude(wall, center=true)
                polygon(points=[
                    [-0.1, 0], 
                    [foot_length, 0], 
                    [foot_length, bottom_thickness], 
                    [-0.1, gusset_height + bottom_thickness]
                ]);
        }
        
        translate([foot_length/2, 0, -1])
            cylinder(d=screw_hole_diameter, h=bottom_thickness + 2);
    }
}

module enclosure_box() {
    gland_z = bottom_thickness + (H_box - bottom_thickness) / 2;
    difference() {
        union() {
            linear_extrude(bottom_thickness)
                outer_profile();
            
            // Walls and dividers
            translate([0, 0, bottom_thickness])
                linear_extrude(H_box - lip_h - bottom_thickness)
                    union() {
                        difference() {
                            outer_profile();
                            cavity_profile();
                        }
                        
                        // Render dividers perfectly constrained to the inside of the cavity
                        intersection() {
                            cavity_profile();
                            union() {
                                if (show_divider_x1) translate([0, divider_x1_pos]) square([L, divider_thickness], center=true);
                                if (show_divider_x2) translate([0, divider_x2_pos]) square([L, divider_thickness], center=true);
                                if (show_divider_y1) translate([divider_y1_pos, 0]) square([divider_thickness, W], center=true);
                                if (show_divider_y2) translate([divider_y2_pos, 0]) square([divider_thickness, W], center=true);
                            }
                        }
                    }

            translate([0, 0, H_box - lip_h])
                linear_extrude(lip_h)
                    lip_profile();
                    
            if (enable_front_foot) {
                translate([0, -W/2, 0])
                    rotate([0, 0, -90])
                    mounting_foot();
            }
            if (enable_back_foot) {
                translate([0, W/2, 0])
                    rotate([0, 0, 90])
                    mounting_foot();
            }
            
            if (show_bottom_pegs) {
                translate([peg_offset_x, peg_offset_y, bottom_thickness]) {
                    translate([-peg_spacing / 2, 0, 0])
                        cylinder(h=peg_H, d=peg_D);
                    translate([peg_spacing / 2, 0, 0])
                        cylinder(h=peg_H, d=peg_D);
                }
            }
            
            if (show_stl_1)  { translate([stl_1_x,  stl_1_y,  bottom_thickness + stl_1_z])  rotate([stl_1_rot_x,  stl_1_rot_y,  stl_1_rot_z])  import(stl_1_filename); }
            if (show_stl_2)  { translate([stl_2_x,  stl_2_y,  bottom_thickness + stl_2_z])  rotate([stl_2_rot_x,  stl_2_rot_y,  stl_2_rot_z])  import(stl_2_filename); }
            if (show_stl_3)  { translate([stl_3_x,  stl_3_y,  bottom_thickness + stl_3_z])  rotate([stl_3_rot_x,  stl_3_rot_y,  stl_3_rot_z])  import(stl_3_filename); }
            if (show_stl_4)  { translate([stl_4_x,  stl_4_y,  bottom_thickness + stl_4_z])  rotate([stl_4_rot_x,  stl_4_rot_y,  stl_4_rot_z])  import(stl_4_filename); }
            if (show_stl_5)  { translate([stl_5_x,  stl_5_y,  bottom_thickness + stl_5_z])  rotate([stl_5_rot_x,  stl_5_rot_y,  stl_5_rot_z])  import(stl_5_filename); }
            if (show_stl_6)  { translate([stl_6_x,  stl_6_y,  bottom_thickness + stl_6_z])  rotate([stl_6_rot_x,  stl_6_rot_y,  stl_6_rot_z])  import(stl_6_filename); }
            if (show_stl_7)  { translate([stl_7_x,  stl_7_y,  bottom_thickness + stl_7_z])  rotate([stl_7_rot_x,  stl_7_rot_y,  stl_7_rot_z])  import(stl_7_filename); }
            if (show_stl_8)  { translate([stl_8_x,  stl_8_y,  bottom_thickness + stl_8_z])  rotate([stl_8_rot_x,  stl_8_rot_y,  stl_8_rot_z])  import(stl_8_filename); }
            if (show_stl_9)  { translate([stl_9_x,  stl_9_y,  bottom_thickness + stl_9_z])  rotate([stl_9_rot_x,  stl_9_rot_y,  stl_9_rot_z])  import(stl_9_filename); }
            if (show_stl_10) { translate([stl_10_x, stl_10_y, bottom_thickness + stl_10_z]) rotate([stl_10_rot_x, stl_10_rot_y, stl_10_rot_z]) import(stl_10_filename); }
            if (show_stl_11) { translate([stl_11_x, stl_11_y, bottom_thickness + stl_11_z]) rotate([stl_11_rot_x, stl_11_rot_y, stl_11_rot_z]) import(stl_11_filename); }
            if (show_stl_12) { translate([stl_12_x, stl_12_y, bottom_thickness + stl_12_z]) rotate([stl_12_rot_x, stl_12_rot_y, stl_12_rot_z]) import(stl_12_filename); }
        }

        if (show_bottom_hole) {
            translate([bottom_hole_x, bottom_hole_y, -1])
                cylinder(d=bottom_hole_D, h=bottom_thickness + 2);
        }

        for(i = [-1, 1], j = [-1, 1]) {
            translate([i*(L/2 - corner_post_inset), j*(W/2 - corner_post_inset), 0]) {
                translate([0, 0, -1])
                    cylinder(d=m8_hole_D, h=H_box + 2);
                
                translate([0, 0, -0.01])
                    cylinder(d=m8_head_D, h=m8_head_H);
                    
                translate([0, 0, H_box - lip_h - recess_depth])
                    cylinder(d=recess_diameter, h=recess_depth + 1);
            }
        }
        
        if (show_mid_pillars) {
            for(j = [-1, 1]) {
                translate([0, j*(W/2 - R), bottom_thickness])
                    cylinder(d=insert_D, h=H_box + 1);
            }
        }

        if (show_end_pillars) {
            for(i = [-1, 1]) {
                translate([i*(L/2 - R), 0, bottom_thickness])
                    cylinder(d=insert_D, h=H_box + 1);
            }
        }
        
        if (show_gland_front_1) { translate([-1.5*gland_spacing, -W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_front_1_D, h=wall * 4, center=true); }
        if (show_gland_front_2) { translate([-0.5*gland_spacing, -W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_front_2_D, h=wall * 4, center=true); }
        if (show_gland_front_3) { translate([ 0.5*gland_spacing, -W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_front_3_D, h=wall * 4, center=true); }
        if (show_gland_front_4) { translate([ 1.5*gland_spacing, -W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_front_4_D, h=wall * 4, center=true); }

        if (show_gland_back_1) { translate([-1.5*gland_spacing, W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_back_1_D, h=wall * 4, center=true); }
        if (show_gland_back_2) { translate([-0.5*gland_spacing, W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_back_2_D, h=wall * 4, center=true); }
        if (show_gland_back_3) { translate([ 0.5*gland_spacing, W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_back_3_D, h=wall * 4, center=true); }
        if (show_gland_back_4) { translate([ 1.5*gland_spacing, W/2, gland_z]) rotate([90, 0, 0]) cylinder(d=gland_back_4_D, h=wall * 4, center=true); }

        if (show_gland_left_1) { translate([-L/2, -1.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_left_1_D, h=wall * 4, center=true); }
        if (show_gland_left_2) { translate([-L/2, -0.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_left_2_D, h=wall * 4, center=true); }
        if (show_gland_left_3) { translate([-L/2,  0.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_left_3_D, h=wall * 4, center=true); }
        if (show_gland_left_4) { translate([-L/2,  1.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_left_4_D, h=wall * 4, center=true); }

        if (show_gland_right_1) { translate([L/2, -1.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_right_1_D, h=wall * 4, center=true); }
        if (show_gland_right_2) { translate([L/2, -0.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_right_2_D, h=wall * 4, center=true); }
        if (show_gland_right_3) { translate([L/2,  0.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_right_3_D, h=wall * 4, center=true); }
        if (show_gland_right_4) { translate([L/2,  1.5*gland_spacing, gland_z]) rotate([0, 90, 0]) cylinder(d=gland_right_4_D, h=wall * 4, center=true); }
    }
}

module enclosure_lid() {
    difference() {
        linear_extrude(H_lid)
            outer_profile();
            
        translate([0, 0, -0.1])
            linear_extrude(lip_h + 0.2)
                offset(r=lip_offset + fit_tolerance) cavity_profile();
                
        for(i = [-1, 1], j = [-1, 1]) {
            translate([i*(L/2 - corner_post_inset), j*(W/2 - corner_post_inset), 0]) {
                translate([0, 0, -1])
                    cylinder(d=m8_hole_D, h=H_lid + 2);
                
                translate([0, 0, H_lid - recess_depth])
                    cylinder(d=recess_diameter, h=recess_depth + 1);
            }
        }
        
        if (show_mid_pillars) {
            for(j = [-1, 1]) {
                translate([0, j*(W/2 - R), 0]) {
                    translate([0, 0, -1])
                        cylinder(d=screw_D, h=H_lid + 2);
                    translate([0, 0, H_lid - head_depth])
                        cylinder(d1=screw_D, d2=head_D, h=head_depth + 0.01);
                }
            }
        }

        if (show_end_pillars) {
            for(i = [-1, 1]) {
                translate([i*(L/2 - R), 0, 0]) {
                    translate([0, 0, -1])
                        cylinder(d=screw_D, h=H_lid + 2);
                    translate([0, 0, H_lid - head_depth])
                        cylinder(d1=screw_D, d2=head_D, h=head_depth + 0.01);
                }
            }
        }
    }
}

if (show_box) {
    color("green") enclosure_box();
}

if (show_lid) {
    translate([0, 0, H_box + 25]) 
        color("Orange") enclosure_lid();
}