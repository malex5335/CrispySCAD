// length of the extension in cm; at least 2 cm (~0.8 inches)
length = 2;
// change if click-mechanism does not fit or is too loose
socket_height = 5.8;
// detail
$fn = 50;
// don't change, 240 is default value
width = 240;
// don't change, 325 is default value
height = 325;

whole_model(length*10);

module whole_model(length) {
    difference() {
        panel(length);
        scale_size = 0.88;
        distance_modifier = (1-scale_size)/2;
        translate([width*distance_modifier,height*distance_modifier,0]) {
            scale([scale_size,scale_size,1]) {
                panel(length);
            }
        }
        sockets();
        translate([0,0,length]) {
            mirror([0,0,90]) {
                sockets();
            }
        }
    }
    
}

module panel(length) {
    difference() {
        cube([width,height,length]);
        side_panel_length = 183.5;
        translate([-(side_panel_length-width)/2,0,0]) {
            side_panel(side_panel_length, 16, length);
        }
    }
}

module sockets() {
    // top
    translate([width-9,0,0]) {
        translate([0,95,0]) {
            rotate([0,0,90]) {
                click_socket();
            }
        }
        translate([0,height-44,0]) {
            rotate([0,0,90]) {
                click_socket();
            }
        }
    }
    // bottom
    translate([26,0,0]) {
        translate([0,11,0]) {
            click_socket();
        }
        translate([0,height-8,0]) {
            click_socket();
        }
    }
}

module side_panel(carving_length, depth, thickness){
    translate([0,depth,thickness]) {
        rotate([90,90,0]) {
            triangle_length = depth;
            translate([0,triangle_length,0]) {
                cube_length = carving_length - triangle_length * 2;
                rotate([90,-90,90]) {
                    rectangular_triangle(triangle_length, thickness);
                }
                cube([thickness,cube_length,depth]);
                translate([0,cube_length + triangle_length,triangle_length]) {
                    rotate([90,180,90]) {
                        rectangular_triangle(triangle_length, thickness);
                    }
                }
            }
        }
    }
}

module rectangular_triangle(length, thickness) {
    difference() {
        cube([length, length, thickness]);
        rotate([0,0,45]) {
            cube([length*2, length, thickness]);
        }
    }
}

module click_socket() {
    depth = 15;
    holding_plate = 14.9;
    holder_thickness = 0.8;
    inner_chamber = 12.3;
    inlay = 1;
    hook_depth = 1.4;
    rotate([90,0,0]){
        translate([-holding_plate / 2, 0, -socket_height/2]){
            translate([holding_plate/2 - inner_chamber/2,holder_thickness + inlay,0]) {
                cube([inner_chamber,depth,socket_height]);
            }
            inside_width = inner_chamber - hook_depth * 2;
            translate([(holding_plate - inside_width) / 2,0,0]) {
                cube([inside_width, inlay + holder_thickness,socket_height]);
            }
            cube([holding_plate,inlay,socket_height]);
        }
    }
}