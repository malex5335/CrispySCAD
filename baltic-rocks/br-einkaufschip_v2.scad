include <br-logo.scad>

difference() {
    height = 2.125;
    cylinder(d=23.25, h=height, center=true, $fn=100);
    translate([0,2,height/6]) {
        br_logo(size=22, height=height, name=false, slogan=false);
    }
    translate([0,2,-height/6]) {
        rotate([0,180,0]) {
            br_name(size=4, height=height, split_line=true);
        }
    }
}
