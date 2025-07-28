$fn = 200;
difference() {
    union() {
        cylinder(1, r = 25.5);
        cylinder(17, r = 25);
    }
    translate([0,0,1]) {
        cylinder(17, r = 24.5);
    }
}