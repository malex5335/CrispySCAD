board_support();

module board_support() {
    union() {
        width = 163;
        border = 5;
        difference() {
            height = 5;
            partial_size = width / 2 - border * 3;
            cube([width,width,height], center=true);
            translate([border,border,-height/2]) {
                cube([partial_size,partial_size,height]);
            }
            translate([border,-partial_size-border,-height/2]) {
                cube([partial_size,partial_size,height]);
            }
            translate([-partial_size - border, -partial_size - border,-height/2]) {
                cube([partial_size,partial_size,height]);
            }
            translate([-partial_size-border,border,-height/2]) {
                cube([partial_size,partial_size,height]);
            }
        }
        top_hollow_cube();
        // bottom left
        translate([width/2 - border, 0, 0]){
            top_hollow_cube();
        }
        translate([0, width/2 - border, 0]){
            top_hollow_cube();
        }
        translate([width/2 - border, width/2 - border, 0]){
            top_hollow_cube();
        }
        // top right
        translate([-(width/2 - border), 0, 0]){
            top_hollow_cube();
        }
        translate([0, -(width/2 - border), 0]){
            top_hollow_cube();
        }
        translate([-(width/2 - border), -(width/2 - border), 0]){
            top_hollow_cube();
        }
        // corners
        translate([width/2 - border, -(width/2 - border), 0]){
            top_hollow_cube();
        }
        translate([-(width/2 - border), width/2 - border, 0]){
            top_hollow_cube();
        }
    }
}

module top_hollow_cube(diameter = 5, height = 15, top_depth = 5, top_diameter = 3) {
    difference() {
        cylinder(d=diameter, h=height);
        translate([0,0,height-top_depth]){
            cylinder(d=top_diameter, h=top_depth);
        }
    }
}