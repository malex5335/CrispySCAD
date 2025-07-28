$fn = 200;
outer_radius = 25;
inner_radius = 23.5;
height = 15;
difference() {
    union() {
        cylinder(1, r = outer_radius);
        cylinder(height, r = inner_radius);
    }
    translate([0,0,1]) {
        cylinder(height, r = inner_radius-0.5);
    }
}