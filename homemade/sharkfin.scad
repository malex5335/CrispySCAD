include <../basic_forms/math_forms.scad>

union() {
    fin_holder(height = 3);
    rotate([0,270,90]) {
        translate([2,11,0]) {
            fin();
        }
    }
}

module fin(length = 10, height = 2) {
    difference() {
        cube([length, length, height], center=true);
        translate([10.5,4,0]){
            rotate([0,0,40]) {
                cube([length*2, length*2, height], center=true);
            }
        }
        translate([-13,4,0]){
            rotate([0,0,-15]) {
                cube([length*2, length*2, height], center=true);
            }
        }
    }
}

module fin_holder(diameter = 12, height = 3, opening = 7) {
    difference() {
        hollow_cylinder(diameter = diameter, height = height, wall_thickness = 1);
        rotate([0,0,90]) {
            translate([-opening/2,-diameter/2,0]) {
                cube([opening, diameter/2, height], center=false);
            }
        }
    }
}