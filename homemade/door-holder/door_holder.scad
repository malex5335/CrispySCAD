width = 35;
height = 16;
depth = 15;
thickness = 3;
difference() {
    cube([depth + thickness,width,height + 1]);
    translate([1,0,0]) {
        cube([depth,width,height]);
    }
    width_2 = 4;
    translate([depth,width/2 - width_2/2,5]) {
        cube([thickness,width_2,1]);
    }
}