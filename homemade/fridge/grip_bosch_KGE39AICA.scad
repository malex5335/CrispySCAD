screw_hole = 4;
screw_head = 9;
length = 310;
width = 20;
depth = 65;
thickness = 12;
buffer_top = 15;
buffer_left = 5;
two_pieces = false;
connector_length = 20;
connector_clearence = 0.05;

fridge_grip();

module fridge_grip() {
    if (two_pieces) {
        translate([depth/2,length/4,0]) {
            grip_connector_wrapper(false);
        }
        half_grip();
        translate([thickness+buffer_left, thickness+buffer_top, 0]) {
            half_grip();
        }
    } else {
        grip();
    }
}

module grip() {
    half_grip(false);
    translate([0,0,width]) {
        rotate([180, 0, 0]) {
            half_grip(false);
        }
    }
}

module half_grip(connector_extrude = true) {
    half_length = length/2;
    intersection() {
        difference() {
            cube([depth,half_length,width]);
            translate([-thickness,-thickness,0]) {
                cube([depth,half_length-depth/2,width]);
                translate([depth/2,length/2-depth/2,0]) {
                    cylinder(h=width, d=depth, $fn=90);
                }
            }
            translate([2,half_length-thickness/2,width/2]) {
                rotate([0,90,0]) {
                    cylinder(h=depth, d=screw_head, $fn=90);
                    translate([0,0,-2]) {
                        cylinder(h=depth, d=screw_hole, $fn=90);
                    }
                }
            }
            if(connector_extrude)  {
            translate([depth-thickness,-connector_length/2,width*0.73]) {
                    rotate([0,90,0]) {
                        grip_connector_wrapper(true);
                    }
                }
            }
        }
        union() {
            translate([depth/2,half_length-depth/2,0]) {
                cylinder(h=width, d=depth, $fn=90);
            }
            cube([depth,half_length-depth/2,width]);
            translate([-depth/2,depth*1.5,0]) {
                cube([depth,depth,width]);
            }
        }
    }
}

module grip_connector_wrapper(extrude = false) {
    connector_height = thickness*0.8;
    connector_width = width*0.5;
    if(extrude) {
        clearence = 1+connector_clearence;
        grip_connector(connector_height*clearence, connector_width*clearence);
    } else {
        grip_connector(connector_height, connector_width);
    }
}

module grip_connector(connector_height, connector_width) {
    triangle(connector_height, connector_width);
    translate([0,connector_length,connector_height]) {
        rotate([180,0,0]) {
            triangle(connector_height, connector_width);
        }
    }
    translate([2.3,3,]) {
        cube([connector_width*0.4,connector_length*0.8,connector_height]);
    }
}

module triangle(height, width) {
    translate([width/2.3,height/3.2,0]) {
        rotate([0,0,90]) {
            cylinder(h=height, d=width, $fn=3);
        }
    }
}