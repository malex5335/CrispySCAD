border_width = 3;
inner_width = 66;
inner_depth = 40.8;
height = 1;

union() {
    inner_ring();
    translate([0,0,height]) {
        top_lit();
    }
    translate([0,inner_depth/2,height]) {
        latch();
    }
}

module inner_ring() {
    translate([0,0,-2]) {
        difference() {
            cube([inner_width,inner_depth,5], true);
            cube([inner_width-border_width,inner_depth-border_width,5], true);
        }
    }
}

module top_lit() {
    cube([inner_width+border_width,inner_depth+border_width, height], true);
}

module latch() {
    latch_width = inner_width/2.5;
    latch_depth = 7;
    cube([latch_width,latch_depth*2,height], true);
}