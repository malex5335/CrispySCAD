include <br-logo.scad>

difference() {
    cylinder(d=23.25, h=2.125, center=true, $fn=100);
    translate([0,3,0]) {
        br_logo(size=20, height=2, name=true, slogan=false);
    }
}
