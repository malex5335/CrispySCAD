use <../libs/threads.scad>
 big_d = 15;
big_h = 12;

small_d = 12;
small_h = 17;

total = 130;

$fn = 100;
difference() {
    union() {
        translate([0,0,big_h]) {
            difference() {
                cylinder(d=big_d, h=total-big_h);
            }
        }
        M12Screw(d=big_d, h=big_h);
    }
    rotate([0,0,200]) {
        union() {
            translate([0,0,small_h]) {
                cylinder(d=small_d, h=total-small_h);
            }
            M12Screw(d=small_d, h=small_h);
        }
    }
}

module M12Screw(d, h) {
    ScrewThread(outer_diam=d, height=h, pitch=1.75, tooth_angle=30, tooth_height=1.6);
}