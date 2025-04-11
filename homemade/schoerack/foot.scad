height=32;
diameter=60;
screwBodyDiameter=4;
screwHeadDiameter=9;
screwPlatformHeight=3;

difference() {
    $fn=100;
    cylinder(h=height, d=diameter);
    translate([0,0,screwPlatformHeight]) {
        cylinder(h=height, d=screwHeadDiameter);
    }
    cylinder(h=height, d=screwBodyDiameter);
}