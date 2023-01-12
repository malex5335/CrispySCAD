use <../libs/threads.scad>
use <../libs/dyson_adapter.scad>

dyson_adapter();
difference() {
    union() {
        hull() {
            hollow_cylinder(diameter = 35);
            translate([0,0,-5]) {
                hollow_cylinder(diameter = 18);
            }
        }
        translate([0,0, -20]) {
            vacuum_thread();
        }
    }
    translate([0,0,-5]){
        cylinder(d = 18, h = 15);
    }
}

module vacuum_thread() {
    // first create a threaded rod
    height = 15;
    difference() {
        ScrewThread(outer_diam=22.7, height=height, pitch=0, tooth_angle=30, tolerance=0.4, tip_height=0, tooth_height=0, tip_min_fract=0);
        cylinder(h=height, d=17.5, $fn=100);
    }
}

module hollow_cylinder(diameter = 18, thickness = 2, height = 1) {
    difference() {
        cylinder(d = diameter, h = height, $fn=100);
        cylinder(d = diameter-thickness, h = height, $fn=100);
    }
}
