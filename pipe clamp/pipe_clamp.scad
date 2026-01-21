// --- RENDER SETTINGS ---
show_front_clamp = true;
show_back_clamp  = true;
show_logo        = true; 
show_ref_rod     = true;

// --- PARAMETERS ---
cylinder_diameter = 42;
block_height      = 50;
block_depth       = 60;
block_width       = 80;
gap               = 4;
tolerance         = 0.0; 

bolt_diameter     = 8.2; 
bolt_margin_v     = 10; // Vertical margin for bolts

recess_diameter   = 16.2; 
recess_depth      = 2.2;  

ball_diameter     = 25; 
neck_diameter     = 17;
neck_height       = 20;
ball_distance     = 20; 

$fn = 50; 

logo_tolerance = -0.1; 

// --- CALCULATIONS ---
x_pos_bolt = (cylinder_diameter / 2) + ((block_width - cylinder_diameter) / 4);

// --- MODULES ---

// Imports and positions the Massey Ferguson logo
module logo_overlay() {
    translate([block_width - 84, 29, -33]) { 
        rotate([90, 0, 180]) { 
            // We gebruiken 'center = true' voor de extrusie
            linear_extrude(height = 5, center = true) {
                // Offset voegt de speling toe aan de 2D vorm
                offset(r = logo_tolerance) { 
                    resize([51, 35], auto = true) {
                        translate([-110, 160]) 
                            import("masseyfergusonlogo.dxf", convexity = 10);
                    }
                }
            }
        }
    }
}

// Visual reference for the rod/cylinder being clamped
module reference_rod(d) {
    translate([0, 0, -80])
        %cylinder(h = 200, d = d, center=false);
}

// RAM-style mounting ball
module ram_ball() {
    union() {
        sphere(d = ball_diameter);
        translate([0, 0, -ball_diameter/2 - neck_height/4])
            cylinder(d = neck_diameter, h = neck_height, center = true);
    }
}

// Through-holes for the clamping bolts
module bolt_holes() {
    z_low = bolt_margin_v;
    z_high = block_height - bolt_margin_v;
    hole_len = block_depth * 3; 

    for (x = [-x_pos_bolt, x_pos_bolt]) {
        for (z = [z_low, z_high]) {
            translate([x, 0, z])
                rotate([90, 0, 0])
                cylinder(h = hole_len, d = bolt_diameter, center = true);
        }
    }
}

// Recesses for bolt heads or nuts
module bolt_recesses(face_y_position) {
    z_low = bolt_margin_v;
    z_high = block_height - bolt_margin_v;
    cut_height = recess_depth * 2;

    for (x = [-x_pos_bolt, x_pos_bolt]) {
        for (z = [z_low, z_high]) {
            translate([x, face_y_position, z])
                rotate([90, 0, 0])
                cylinder(h = cut_height, d = recess_diameter, center = true);
        }
    }
}

// Front half of the clamp with logo engraving
module front_clamp() {
    half_depth = (block_depth - gap) / 2;
    y_shift = (gap / 2) + (half_depth / 2);
    outer_y = y_shift + (half_depth / 2);

    difference() {
        translate([0, y_shift, block_height / 2])
            cube([block_width, half_depth, block_height], center = true);

        translate([0, 0, -1]) 
            cylinder(h = block_height + 2, d = cylinder_diameter + tolerance);
            
        bolt_holes();
        bolt_recesses(outer_y);
        logo_overlay();
    }
}

// Back half of the clamp with RAM ball and reinforcement
module back_clamp() {
    half_depth = (block_depth - gap) / 2;
    y_shift = (gap / 2) + (half_depth / 2);
    outer_y = - (y_shift + (half_depth / 2));
    wall_thickness = 9; 

    difference() {
        union() {
            translate([0, -y_shift, block_height / 2])
                cube([block_width, half_depth, block_height], center = true);
            
            translate([0, outer_y - ball_distance, block_height / 2])
                rotate([90, 0, 0]) 
                ram_ball();

            // Internal reinforcement rib
            translate([0, -35, block_height / 2])
                cube([wall_thickness, 35, 25], center = true);
        }

        translate([0, 0, -1]) 
            cylinder(h = block_height + 2, d = cylinder_diameter + tolerance);
            
        bolt_holes();
        bolt_recesses(outer_y);
    }
}

// --- EXECUTION ---

if (show_ref_rod) {
    reference_rod(cylinder_diameter);
}

if (show_front_clamp) {
    color("Cyan") front_clamp();
}

if (show_back_clamp) {
    color("RoyalBlue") back_clamp();
}

if (show_logo) {
    color("Red") logo_overlay();
}
