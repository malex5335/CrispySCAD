// length of the extension; at least 0.7 cm || 0.28 inches
length = 1;
// true = cm,  false = inches
metricUnit = true;
// use less material
light_mode = true;

gpu_extension(length * (metricUnit ? 10 : 25.4));

module gpu_extension(height) {
    $fn = 50;
    width = 140;
    length = 244;
    difference() {
        union() {
            cube([width, length, height]);
            stems(
                side_distance = 22,
                top_distance = 16,
                width = width,
                length = length,
                z_diff = height);
        }
        translate([5.1, 22, 0]) {
            gpu_space(height);
        }
        sockets(
            side_distance = 22,
            top_distance = 16,
            width = width,
            length = length,
            z_diff = 0);
        if(light_mode) {
            remove_options(width, length, height);
        }
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
        click_stem();
    }
    translate([ width/2,
                length-top_distance,
                z_diff]) {
        stub_stem();
    }
    translate([ width-side_distance,
                length-top_distance,
                z_diff]) {
        click_stem();
    }
    // middle
    translate([ 91,
                146,
                z_diff]) {
        click_stem();
    }
    // bottom
    translate([ side_distance,
                top_distance,
                z_diff]) {
        click_stem();
    }
    translate([ width/2,
                top_distance,
                z_diff]) {
        stub_stem();
    }
    translate([ width-side_distance,
                top_distance,
                z_diff]) {
        click_stem();
    }
}

module gpu_space(height) {
    roundedcube(size = [75,155,height], radius = 5);
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
        click_socket();
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
    side_spacer = 5.1;
    union() {
        if(top_side) {
            translate([side_spacer,length - 63,0]) {
                roundedcube(size = [width - side_spacer * 2,42,height], radius = 5);
            }
        }
        if(left_side) {
            translate([100,22,0]) {
                roundedcube(size = [40 - side_spacer ,159 - side_spacer ,height], radius = 5);
            }
        }
    }
}

module click_stem() {
    diameter = 3.6;
    radius = diameter / 2;
    totalHeight = 7.15;
    cylinder(d=diameter, h=totalHeight - radius);
    translate([0,0,totalHeight - radius]) {
        sphere(radius);
    }
}

module click_socket() {
    cylinder(d=3.6, h=4);
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
    cylinder(d=5.2, h=5.3);
}

module roundedcube(size = [1,1,1], radius = 5) {
    minkowski() {
        diameter = radius * 2;
        cube([
            size[0] - diameter,
            size[1] - diameter,
            size[2]]);
        translate([radius,radius]) {
            cylinder(r=radius,h=size[2]);
        }
    }
}