union() {
    $fn = 50;
    difference() {
        cube([130, 80, 40], true);
        cube([110, 60, 50], true);
        cube([140, 60, 20], true);
        cube([125, 115, 34], true);
    }
    translate([125/2+10,0,15]){
        borehole();
    }
    translate([-125/2-10,0,15]){
        borehole();
    }
}


module borehole() {
    x = 20;
    y = 80;
    z = 5;
    hole = 5;
    translate([-x/2,-y/2,0]) {
        difference() {
            cube([x,y,z]);
            translate([x/2,y/4,0]) {
                cylinder(d=hole,h=z);
            }
            translate([x/2,y/4*3,0]) {
                cylinder(d=hole,h=z);
            }
        }
    }
}