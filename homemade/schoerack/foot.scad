height=10;
diameter=60;
screwBodyDiameter=4;
screwHeadDiameter=9;
screwPlatformHeight=3;
rotation=3;

difference() {
    $fn=100;
    cylinder(h=height*2, d=diameter);
    translate([0,0,screwPlatformHeight]) {
        cylinder(h=height*2, d=screwHeadDiameter);
    }
    cylinder(h=height*2, d=screwBodyDiameter);
    translate([0,0,height*2 + rotation/2]) {
        rotate([0,rotation,0]) {
            cube([diameter*2,diameter*2,height*2], center=true);
        }
    }
}