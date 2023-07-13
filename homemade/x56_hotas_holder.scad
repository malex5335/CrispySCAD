union() {
    $fn = 50;
    length = 165;
    space = 10;
    diameter = 5;
    translate([space,0,15]) {
        pin(50, diameter);
        translate([length,0,0]) {
            pin(50, diameter);
            //translate([-25,0,0]) {
            //    pin(20, diameter);
            //}
        }
        //translate([25,0,0]) {
        //    pin(20, diameter);
        //}
    }
    translate([space + length,0,15]) {
        pin(50, diameter);
    }
    holder(length, space);
}


module holder(length = 75, space = 5) {
    length = length + 2*space;
    width = 20;
    buffer = 2;
    difference() {
        cube([length, width + buffer, width + buffer]);
        translate([0,1,1]) {
            cube([length, width, width]);
        }
        translate([0,0,-1]) {
            cube([length,15,10]);
        }
    }
}

module pin(height = 50, diameter = 5) {
    rotate([90,0,0]) {
        cylinder(h = height, d = diameter, center = false);
    }
}