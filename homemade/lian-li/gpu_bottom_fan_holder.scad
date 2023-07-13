union() {
    difference() {
        cube([126, 43, 12]);
        fan_piece();
        translate([41.5, 0, 0]) {
            fan_piece();
            translate([41.5, 0, 0]) {
                fan_piece();
            }
        }
        rotate([0,90,0]) {
            translate([-5,43/3,0]) {
                cylinder(h=126, r=2, $fn=50);
                translate([0,43/3,0]) {
                    cylinder(h=126, r=2, $fn=50);
                }
            }
        }
    }
}

module fan_piece() {
    translate([0.75, 0.75, -1]) {
        cube([41, 41, 12]);
        translate([1.5, 1.5, 0]) {
            cube([38, 38, 13]);
        }
        translate([30, 0, 3]) {
            rotate([90,0,0]) {
                #cylinder(h=5, r=3, $fn=50);
            }
        }
    }
}