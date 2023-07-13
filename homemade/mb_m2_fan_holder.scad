difference() {
    cube([103,45,12]);
    cube([9,38.7,12]);
    translate([94,6.3,0]) {
        cube([9,38.7,12]);
    }
    translate([0,0,2]) {
        cube([10,45,10]);
        translate([93,0,0]) {
            cube([10,45,10]);
        }
    }
    translate([10.7,1,0]) {
        cube([40.5,41,10]);
        translate([2,3,0]) {
            cube([36,36,12]);
        }
        translate([40.5,0,0]) {
            cube([40.5,41,10]);
            translate([2,3,0]) {
                cube([36,36,12]);
            }
        }
    }
    translate([13.5,0,2]) {
        cube([76,45,8]);
    }
    translate([3,42,0]) {
        cylinder(r=2, h=2, $fn=50);
    }
    translate([100,3,0]) {
        cylinder(r=2, h=2, $fn=50);
    }
}