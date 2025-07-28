$fn = 200;
difference() {
    union() {
        cylinder(1, r = 25);
        cylinder(15, r = 24);
    }
    translate([0,0,1]) {
        cylinder(15, r = 23.5);
    }
}