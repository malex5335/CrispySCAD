// length of the extension in cm; at least 2 cm (~0.8 inches)
length = 2;
// change if click-mechanism does not fit or is too loose
socket_height = 5.8;
// distance from the outside, to fit GPU width in mm
side_spacer = 5.1;
// split model in 2 parts for smaller printers
split_model = true;
// detail
$fn = 50;
// don't change, 140 is default value
width = 140;
// don't change, 244 is default value
height = 244;

whole_model(length, split_model);

module whole_model(length, split_model) {
    true_length = length * 10;
    if(split_model) {
        // top part
        translate([20, -50, 0]) {
            difference() {
                gpu_extension(true_length);
                cube([width,height/2,true_length + 10]);
            }
        }
        // bottom part
        difference() {
            gpu_extension(true_length);
            translate([0, height / 2, 0]) {
                cube([width,height/2,true_length + 10]);
            }
            
        }
    } else {
        gpu_extension(true_length);
    }
}

module gpu_extension(length) {
    length = max(length, 20);
    difference() {
        union(){
            cube([width, height, length]);
            // stub top
            translate([ width/2,
                        height-16,
                        length]) {
                stub_stem();
            }
            // stub bottom
            translate([ width/2,
                        16,
                        length]) {
                stub_stem();
            }
        }
        stems(
            side_distance = 22,
            top_distance = 16,
            width = width,
            length = height,
            z_diff = length);
        translate([side_spacer, 22, 0]) {
            gpu_space(length);
        }
        sockets(
            side_distance = 22,
            top_distance = 16,
            width = width,
            length = height,
            z_diff = 0);
        remove_options(width, height, length);
        mirroring_side_panels_style(length);
    }
}

module stems(
        side_distance,
        top_distance,
        width,
        length,
        z_diff) {
    // top
    translate([ side_distance,
                length-top_distance,
                z_diff]) {
        rotate([180,0,0]){
            click_socket();
        }
    }
    translate([ width-side_distance,
                length-top_distance,
                z_diff]) {
        
        rotate([180,0,0]){
            click_socket();
        }
    }
    // middle
    translate([ 91,
                146,
                z_diff]) {
        
        rotate([180,0,90]){
            click_socket();
        }
    }
    // bottom
    translate([ side_distance,
                top_distance,
                z_diff]) {
        
        rotate([180,0,0]){
            click_socket();
        }
    }
    translate([ width-side_distance,
                top_distance,
                z_diff]) {
        
        rotate([180,0,0]){
            click_socket();
        }
    }
}

module gpu_space(height) {
    roundedcube(size = [86 - side_spacer,155,height], radius = 5);
}

module sockets(
        side_distance,
        top_distance,
        width,
        length,
        z_diff) {
    // top
    translate([ side_distance,
                top_distance,
                z_diff]) {
        click_socket();
    }
    translate([ width/2,
                top_distance,
                z_diff]) {
        stub_socket();
    }
    translate([ width-side_distance,
                top_distance,
                z_diff]) {
        click_socket();
    }
    
    // middle
    translate([ 91,
                146,
                z_diff]) {
        rotate([0,0,90]) {
            click_socket();
        }
    }
    
    // bottom
    translate([ side_distance,
                length-top_distance,
                z_diff]) {
        click_socket();
    }
    translate([ width/2,
                length-top_distance,
                z_diff]) {
        stub_socket();
    }
    translate([ width-side_distance,
                length-top_distance,
                z_diff]) {
        click_socket();
    }
}

module remove_options(width, length, height) {
    top_side = true;
    left_side = true;
    union() {
        if(top_side) {
            translate([side_spacer,length - 63,0]) {
                roundedcube(size = [width - side_spacer * 2,44.5 - side_spacer,height], radius = 5);
            }
        }
        if(left_side) {
            translate([96 ,22,0]) {
                roundedcube(size = [44- side_spacer,155,height], radius = 5);
            }
        }
    }
}

module mirroring_side_panels_style(height) {
    total_length = 244;
    total_width = 140;
    side_panel_height = 16;
    carving_length = 187;
    thickness = 1.8;
    translate([0,(total_length - carving_length) / 2,height - side_panel_height]){
        side_panel(carving_length, side_panel_height, thickness);
    }
    translate([total_width - thickness,(total_length - carving_length) / 2,height-side_panel_height]){
        side_panel(carving_length, side_panel_height, thickness + 0.2);
    }
}

module side_panel(carving_length, depth, thickness){
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

module stub_stem() {
    diameter = 5;
    radius = diameter / 2;
    totalHeight = 5.1;
    cylinder(d=diameter, h=totalHeight - radius);
    translate([0,0,totalHeight - radius]) {
        sphere(radius);
    }
}

module stub_socket() {
    cylinder(d=6, h=10);
}

module roundedcube(size = [1,1,1], radius = 5) {
    radius = min(size[0]/2-0.01, size[1]/2-0.01, radius);
    minkowski() {
        diameter = radius * 2;
        cube([
            size[0] - diameter,
            size[1] - diameter,
            size[2]/2]);
        translate([radius,radius]) {
            cylinder(r=radius,h=size[2]/2);
        }
    }
}