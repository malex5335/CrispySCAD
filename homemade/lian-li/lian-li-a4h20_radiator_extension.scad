// length of the extension in cm; at least 2 cm (~0.8 inches)
length = 3;
// change if click-mechanism does not fit or is too loose
socket_height = 5.8;
// split model in 2 parts for smaller printers
split_model = true;
// detail
$fn = 50;
// don't change, 140 is default value
width = 140;
// don't change, 323.5 is default value
height = 323.5;

whole_model(length, split_model);

module whole_model(length, split_model) {
    true_length = length * 10;
    if(split_model) {
        // top part
        translate([20, -140, 0]) {
            difference() {
                radiator_extension(true_length);
                cube([width,height/2,true_length + 10]);
            }
        }
        // bottom part
        difference() {
            radiator_extension(true_length);
            translate([0, height / 2, 0]) {
                cube([width,height/2,true_length + 10]);
            }

        }
    } else {
        radiator_extension(true_length);
    }
}

module radiator_extension(length) {
    length = max(length, 20);
    difference() {
        union(){
            cube([width, height, length]);
            translate([ width/2,
                9,
                length]) {
                stub_stem();
            }
        }
        side_distance = 17;
        top_distance = 8;
        stems(
            side_distance = side_distance,
            top_distance = top_distance,
            width = width,
            length = height,
            z_diff = length
        );
        sockets(
            side_distance = side_distance,
            top_distance = top_distance,
            width = width,
            length = height,
            z_diff = 0
        );
        clearance(width, height, length);
        radiator_anchors(width, height);
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

module sockets(
side_distance,
top_distance,
width,
length,
z_diff) {
    // bottom
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

    // top
    translate([ side_distance,
            length-top_distance,
        z_diff]) {
        click_socket();
    }
    translate([ width-side_distance,
            length-top_distance,
        z_diff]) {
        click_socket();
    }
}

module clearance(width, length, height) {
    back_front_distance = 14;
    left_right_distance = 7;
    translate([left_right_distance, back_front_distance,0]){
        cube([width-left_right_distance*2, length-back_front_distance*2, height]);
    }
}

module radiator_anchors(width, length) {
    slot_width = 74;
    slot_height = 9;
    outer_distance = 5.1;
    translate([(width-slot_width) / 2,outer_distance,0]) {
        cube([slot_width,slot_height,2]);
    }
    y_diff = length-slot_height-outer_distance;
    translate([(width-slot_width) / 2,y_diff,0]) {
        cube([slot_width,slot_height,2]);
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