// --- Render Options ---
show_box = true;        // Set to true to render the bottom enclosure
show_lid = false;       // Set to true to render the top lid

// --- Wall Cutout Options ---
open_front = false;      // Set to true to open the long front wall (Y-axis)
open_left_side = true;   // Set to true to open the short left wall (X-axis)
open_right_side = false; // Set to true to open the short right wall (X-axis)

// --- Hook Options (Side Wall X+) ---
enable_side_hook = true;        // Set to true to attach the hook to the X+ wall
haak_totale_hoogte = 60;        // Totale hoogte van de haak
haak_gat_diameter = 17.5;       // De breedte van de binnenste opening
haak_boog_top_hoogte = 50;      // Hoogte vanaf de bodem tot het topje van de binnenste boog
haak_linker_been_lengte = 40;   // Lengte van de buitenkant van de linkerhaak
haak_linker_wand_dikte = 12;    // Dikte van de linker arm (het korte stuk)
haak_rechter_wand_dikte = 3;    // Dikte van de rechter arm (deze smelt samen met de box wand)
haak_afschuining = 5;           // Grootte van het schuine kantje linksboven

// --- Dimensions ---
L = 180;                // Outer length of the box (X-as)
W = 175;                // Outer width of the box (Y-as)
H_box = 60;             // Height of the bottom box part
H_lid = 5;              // Total thickness of the lid
wall = 4;               // Outer wall thickness
bottom_thickness = 2;   // Thickness of the bottom floor
R = 6;                  // Outer corner radius

// --- M8 Stacking Options ---
m8_hole_D = 8.5;         // Clearance hole for M8 threaded rod (draadeind)
m8_head_D = 19.5;        // Diameter of the M8 bolt head / nut recess (flush fit)
m8_head_H = 10;           // Depth of the recess cut into the bottom
corner_post_D = 24;      // Increased diameter of the corner posts to fit M8 recess
corner_post_inset = 12;  // Inset of the corner posts so the recess doesn't break outer walls

// --- Inner Dummy Box ---
inner_box_L = 228;      // Length of the inner reference box
inner_box_W = 130;      // Width of the inner reference box
inner_box_H = 55;       // Height of the inner reference box

// Offsets to move the inner transparent box
inner_box_offset_x = -40; // Move left (-) or right (+)
inner_box_offset_y = 0;   // Move front (-) or back (+)
inner_box_offset_z = 0;   // Move up (+) from the floor

// --- Glands X-axis (Sides) ---
show_gland_1 = true;    // Toggle gland 1 (Left)
gland_1_D    = 20.4;    // Diameter of gland 1

show_gland_2 = false;    // Toggle gland 2 (Right)
gland_2_D    = 28.5;    // Diameter of gland 2

// --- Glands Y-axis (Front & Back) ---
show_gland_y_front_left  = false;
gland_y_front_left_D     = 12.5;

show_gland_y_front_right = false;
gland_y_front_right_D    = 16.2;

show_gland_y_back_left   = false;
gland_y_back_left_D      = 20.4;

show_gland_y_back_right  = false;
gland_y_back_right_D     = 16.2;

gland_y_spacing = 40;   // Center-to-center distance between Y-axis holes

// --- Lip & Seal ---
lip_h = 0;              // Height of the interlocking lip
lip_offset = 2;         // Thickness/offset of the inner lip
fit_tolerance = 0.2;    // Extra clearance between lid and box

// --- Mounting Posts & Screws ---
show_mid_pillars = false; // Extra pillars in the middle (Y-axis walls)
show_end_pillars = false; // Extra pillars in the middle (X-axis walls)

post_D = 15;            // Diameter of the solid screw posts (Mid-pillars only now)
insert_D = 8.5;         // Diameter of the heat insert hole (for mid-pillars)
screw_D = 3.7;          // Diameter of the Lid screw hole (for mid-pillars)
head_D = 7.6;           // Diameter of the screw head top
head_depth = 2.5;       // Depth of the screw head chamfer
fillet_D = 6;           // Diameter of the fillet between posts and walls

// --- Mounting Feet ---
enable_front_foot = false; 
enable_back_foot = false;  
foot_width = 30;
foot_length = 20;
screw_hole_diameter = 4.5;
gusset_height = 15;

// --- Resolution ---
$fn = 60;

// --- Modules ---

module outer_profile() {
    offset(r=R) square([L - 2*R, W - 2*R], center=true);
}

module raw_cavity() {
    difference() {
        offset(r=R - wall) square([L - 2*R, W - 2*R], center=true);
        
        // M8 Corner pillars (Moved inward and made thicker)
        for(i = [-1, 1], j = [-1, 1]) {
            translate([i*(L/2 - corner_post_inset), j*(W/2 - corner_post_inset)])
                circle(d=corner_post_D);
        }
        
        // Mid pillars on long sides
        if (show_mid_pillars) {
            for(j = [-1, 1]) {
                translate([0, j*(W/2 - R)])
                    circle(d=post_D);
            }
        }

        // Mid pillars on short sides
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
            // Flat Base Plate
            translate([0, -foot_width/2, 0])
                cube([foot_length, foot_width, bottom_thickness]);
            
            // Front Gusset
            translate([0, -foot_width/2 + wall/2, 0])
                rotate([90, 0, 0])
                linear_extrude(wall, center=true)
                polygon(points=[
                    [-0.1, 0], 
                    [foot_length, 0], 
                    [foot_length, bottom_thickness], 
                    [-0.1, gusset_height + bottom_thickness]
                ]);
                
            // Back Gusset
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
        
        // Centered Screw Hole
        translate([foot_length/2, 0, -1])
            cylinder(d=screw_hole_diameter, h=bottom_thickness + 2);
    }
}

module haak_2d_profiel() {
    difference() {
        // Basisblok
        square([haak_linker_wand_dikte + haak_rechter_wand_dikte + haak_gat_diameter, haak_totale_hoogte]);

        // Lege ruimte onder de linker arm wegsnijden
        translate([-1, -1])
            square([haak_linker_wand_dikte + 1, haak_totale_hoogte - haak_linker_been_lengte + 1]);

        // U-vormige uitsparing
        translate([haak_linker_wand_dikte, -1])
            square([haak_gat_diameter, haak_boog_top_hoogte - (haak_gat_diameter/2) + 1]);

        // Ronde bovenkant van de uitsparing
        translate([haak_linker_wand_dikte + (haak_gat_diameter/2), haak_boog_top_hoogte - (haak_gat_diameter/2)])
            circle(d=haak_gat_diameter, $fn=100);

        // Afschuining linksboven
        translate([0, haak_totale_hoogte])
            polygon([ [-1, 1], [-1, -haak_afschuining], [haak_afschuining, 1] ]);
    }
}

module enclosure_box() {
    gland_z = bottom_thickness + (H_box - bottom_thickness) / 2;
    difference() {
        union() {
            // Bottom Floor
            linear_extrude(bottom_thickness)
                outer_profile();
            
            // Walls
            translate([0, 0, bottom_thickness])
                linear_extrude(H_box - lip_h - bottom_thickness)
                    difference() {
                        outer_profile();
                        cavity_profile();
                    }

            // Lip for the lid
            translate([0, 0, H_box - lip_h])
                linear_extrude(lip_h)
                    lip_profile();
                    
            // --- External Hook Integration on X+ side ---
            if (enable_side_hook) {
                haak_breedte = haak_linker_wand_dikte + haak_rechter_wand_dikte + haak_gat_diameter;
                
                // Lengte van de extrusie (W = 170 mm, gelijk aan de muur). 
                // Pas dit aan naar 180 als je hem langer wilt maken.
                haak_lengte = W; 
                
                // Spiegelen zodat de platte wand tegen de box aan zit, 
                // en op de X-as verschuiven naar de rand van de box.
                translate([L/2 + haak_breedte - haak_rechter_wand_dikte, 0, 0]) 
                    mirror([1, 0, 0])
                    rotate([90, 0, 0]) 
                    linear_extrude(height=haak_lengte, center=true)
                        haak_2d_profiel();
            }
                    
            // --- External Mounting Feet Integration ---
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
        }

        // M8 Corner stacking holes & bottom recesses
        for(i = [-1, 1], j = [-1, 1]) {
            translate([i*(L/2 - corner_post_inset), j*(W/2 - corner_post_inset), 0]) {
                // Through hole for M8 threaded rod
                translate([0, 0, -1])
                    cylinder(d=m8_hole_D, h=H_box + 2);
                
                // Recess for the bolt head from the bottom
                translate([0, 0, -0.01])
                    cylinder(d=m8_head_D, h=m8_head_H);
            }
        }
        
        // Long side pillar screw holes (optional)
        if (show_mid_pillars) {
            for(j = [-1, 1]) {
                translate([0, j*(W/2 - R), bottom_thickness])
                    cylinder(d=insert_D, h=H_box + 1);
            }
        }

        // Short side pillar screw holes (optional)
        if (show_end_pillars) {
            for(i = [-1, 1]) {
                translate([i*(L/2 - R), 0, bottom_thickness])
                    cylinder(d=insert_D, h=H_box + 1);
            }
        }
        
        // Gland holes
        if (show_gland_1) {
            translate([-L/2, 0, gland_z])
                rotate([0, 90, 0])
                cylinder(d=gland_1_D, h=wall * 4, center=true);
        }
            
        if (show_gland_2) {
            translate([L/2, 0, gland_z])
                rotate([0, 90, 0])
                cylinder(d=gland_2_D, h=wall * 4, center=true);
        }
            
        if (show_gland_y_front_left) {
            translate([-gland_y_spacing/2, -W/2, gland_z])
                rotate([90, 0, 0])
                cylinder(d=gland_y_front_left_D, h=wall * 4, center=true);
        }
            
        if (show_gland_y_front_right) {
            translate([gland_y_spacing/2, -W/2, gland_z])
                rotate([90, 0, 0])
                cylinder(d=gland_y_front_right_D, h=wall * 4, center=true);
        }
            
        if (show_gland_y_back_left) {
            translate([-gland_y_spacing/2, W/2, gland_z])
                rotate([90, 0, 0])
                cylinder(d=gland_y_back_left_D, h=wall * 4, center=true);
        }
            
        if (show_gland_y_back_right) {
            translate([gland_y_spacing/2, W/2, gland_z])
                rotate([90, 0, 0])
                cylinder(d=gland_y_back_right_D, h=wall * 4, center=true);
        }
        
        // --- Cutouts ---
        
        // Front Wall Cutout (Long side)
        if (open_front) {
            cutout_margin = 20; 
            cutout_width_x = (L - 2*R) - corner_post_D - cutout_margin;
            
            translate([0, -W/2, bottom_thickness])
                translate([0, 0, (H_box + 10) / 2])
                    cube([cutout_width_x, wall * 5, H_box + 10], center=true);
        }
        
        // Left Side Wall Cutout (Short side)
        if (open_left_side) {
            cutout_margin_y = 10; 
            cutout_width_y = (W - 2*R) - corner_post_D - cutout_margin_y;
            
            translate([-L/2, 0, bottom_thickness])
                translate([0, 0, (H_box + 10) / 2])
                    cube([wall * 5, cutout_width_y, H_box + 10], center=true);
        }

        // Right Side Wall Cutout (Short side)
        if (open_right_side) {
            cutout_margin_y = 20; 
            cutout_width_y = (W - 2*R) - corner_post_D - cutout_margin_y;
            
            translate([L/2, 0, bottom_thickness])
                translate([0, 0, (H_box + 10) / 2])
                    cube([wall * 5, cutout_width_y, H_box + 10], center=true);
        }
    }
}

module enclosure_lid() {
    difference() {
        linear_extrude(H_lid)
            outer_profile();
            
        // Lip cutout
        translate([0, 0, -0.1])
            linear_extrude(lip_h + 0.2)
                offset(r=lip_offset + fit_tolerance) cavity_profile();
                
        // Corner M8 through holes for stacking
        for(i = [-1, 1], j = [-1, 1]) {
            translate([i*(L/2 - corner_post_inset), j*(W/2 - corner_post_inset), -1]) {
                cylinder(d=m8_hole_D, h=H_lid + 2);
            }
        }
        
        // Mid-pillar screw holes (Long sides)
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

        // Mid-pillar screw holes (Short sides)
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

// --- Execution ---
if (show_box) {
    color("green") enclosure_box();
}

if (show_lid) {
    translate([0, 0, H_box + 25]) 
        color("Orange") enclosure_lid();
}

// --- Inner Transparent Reference Box ---
if (show_box) {
    %translate([inner_box_offset_x, inner_box_offset_y, bottom_thickness + (inner_box_H / 2) + inner_box_offset_z])
        cube([inner_box_L, inner_box_W, inner_box_H], center=true);
}