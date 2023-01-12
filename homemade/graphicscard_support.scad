support();

module support() {
    cube([10,80,2]);
    hull() {
        rotate([90,0,0]){
            cube([10,80,2]);
        }
        translate([0,-1.5,40.33333]) {
            rotate([225,0,0]){
                cube([10,55,2]);
            }
        }
    }
}