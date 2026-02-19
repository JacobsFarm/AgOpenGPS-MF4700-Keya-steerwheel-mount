// --- Instellingen ---
speling = 0.2; 
$fn = 30;      

// --- Weergave opties ---
toon_joystick = true; 
toon_uitsnedes = true; 

// --- Hoofdlogica ---

if (toon_joystick && toon_uitsnedes) {
    // 1. Definitieve versie: Joystick MIN uitsnedes
    difference() {
        joystick_body();
        alle_uitsnedes(); 
    }
} 
else if (toon_joystick) {
    // 2. Alleen het origineel
    joystick_body();
} 
else if (toon_uitsnedes) {
    // 3. Alleen de mallen (transparant rood door de #)
    #alle_uitsnedes();
}

// --- De Verzamelmodule (Hier beheer je alle gaten!) ---

module alle_uitsnedes() {
    // Hier zet je alles wat eruit gesneden moet worden
    
    shaft_geometry(extra_d = speling);
    
    cable_shaft_geometry(extra_d = speling);
    
    bodem_vlakker();
    
    // Jouw nieuwe gat (Cilinder 16.2mm)
    // Pas hier direct de positie aan
    translate([20, 0, 155]) 
        rotate([90, 90, 0]) 
        gat_cilinder(d=19.3, h=50);
       
    // --- GAT 2 (Het nieuwe gat) ---
    // Ik heb hem nu even symmetrisch aan de andere kant gezet (-20)
    translate([-10, 0, 165]) 
        rotate([90, 90, 0]) 
        gat_cilinder(d=19.3, h=50);
}

// --- Losse Vorm Modules ---

module gat_cilinder(d=16.2, h=50) {
    // Generiek gemaakt zodat je hem vaker kunt gebruiken
    cylinder(h = h, d = d, center = true, $fn = 60);
}

module bodem_vlakker() {
    translate([-20, 0, 17.7]) 
        cube([100, 100, 10], center = true);
}

module joystick_body() {
    translate([3, -5, 20]) 
    scale([1, 1, 1.2]) 
        // Let op: pad controleren
        import("E:/3d print files/mf joystick/best_14cm.stl", convexity=10);
}

module cable_shaft_geometry(extra_d = 0) {
    d = 8 + extra_d;
    r_bocht = 12;
    extra_lengte = 30; 
    
    translate([0, -10, 50]) {
        cylinder(h = 100, d = d);
        
        translate([0, -r_bocht, 0])
        rotate([0, 270, 0])
        rotate([0, 0, 90])
        render() // Render is hier goed voor complexe bochten
        rotate_extrude(angle = 90) {
            translate([r_bocht, 0])
            circle(d = d);
        }

        translate([0, -r_bocht, -r_bocht])
        rotate([90, 0, 0])
        cylinder(h = extra_lengte, d = d);
    }
}

module shaft_geometry(extra_d = 0) {
    d = 10 + extra_d;
    h_cilinder = 100;
    b = 5 + extra_d;
    l = 10 + extra_d;
    h_blok = 20;

    union() {
        cylinder(h = h_cilinder, d = d); 
        translate([0, 0, h_cilinder + (h_blok / 2)]) {
            rotate([0, 0, 90]) cube([b, l, h_blok], center = true);
        }
    }
}
