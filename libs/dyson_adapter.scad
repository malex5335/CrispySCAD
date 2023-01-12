module dyson_adapter() {
    difference() {
        union() {
            height = 83;
            diameter = 35;
            cylinder(d=diameter, h=height, $fn=100);
            h2 = height-36;
            translate([0,0,17]) {
                rounded_cylinder(
                    d1 = diameter+17,
                    d2 = diameter, 
                    h = h2
                );
            }
            translate([0,14.5,34.4]){
                rotate([90,0,0]){
                    clicker();
                }
            }
        }
        cylinder(d=33, h=83, $fn=100);
        translate([0,26,34.4]){
            rotate([90,0,0]){
                clicker_outline(height= 20, thickness = 3);
            }
        }
    }
    translate([0,12,0]){
        cylinder_hull();
    }
}

module rounded_cylinder(d1, d2, h) {
    hull() {
        cylinder(d=d1, h=30, $fn=100);
        translate([0,0,-h+30]) {
            cylinder(d=d2, h=1, $fn=100);
        }
    }
}

module clicker_shadow(thickness = 0) {
    width = 17.2 + thickness;
    hull() {
        circle(d=width);
        translate([0,53-width,0]){
            square(size=width, center = true);
        }
    }
}

module clicker_outline(height=1, thickness = 3) {
    linear_extrude(height) {
        difference() {
            clicker_shadow(thickness=thickness);
            clicker_shadow(thickness=0);
        }
    }
}

module clicker(height = 5) {
    translate([0,34,-3.8]){
        rotate([8,0,0]) {
            cylinder(h = height, d=13.6, $fn = 100);
        }
    }
}

module cylinder_hull(height = 83, diameter = 24.4) {
    translate([0,0,height/2]) {
        difference() {
            cube([diameter,2,height], center = true);
            translate([0,1.5,0]) {
                cube([diameter,2,height], center = true);
            }
        }
    }
}
