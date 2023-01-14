// change if sits too loose inside of the case
height = 5;

click_stem_holder();

module click_stem_holder() {
    $fn=50;
    inner_depth = 10;
    inner_size = 8;
    cap_clip();
    inner_center = inner_size / 2;
    pin_width = 0.4;
    difference() {
        union() {
            stabs_width = 1.6;
            stabs_height = 7.5;
            translate([inner_center - 2,0,0]) {
                cube([stabs_width,stabs_height,height]);
            }
            translate([inner_center + pin_width,0,0]) {
                cube([stabs_width,stabs_height,height]);
            }
        }
        translate([inner_center,2.1,0]) {
            cube_width = pin_width*6;
            translate([-cube_width/2,0,0]) {
                cube([cube_width,cube_width*1.4,height]);
            }
            linear_extrude(height) {
                circle(r=pin_width*3);
            }
        }
        
        translate([inner_center,7.5,0]) {
            rotate([0,0,30]) {
                cylinder(h = height, r=3, $fn=3);
            }
        }
    }
}

module cap_clip() {
    hook_depth = 1.4;
    widest_part = 14.9;
    holder_thickness = 0.8;
    inner_depth = 10;
    inner_size = 8;
    difference() {
        union() {
            roundedcube([inner_size,inner_depth,height], 1);
            translate([-3.5,inner_depth - holder_thickness,0]) {
                cube([widest_part,holder_thickness,height]);
            }
            rect_side = 2;
            y_top = inner_depth - rect_side - holder_thickness * 3;
            // left bracket
            translate([0,y_top,0]) {
                rotate([0,0,90]) {
                    rectangular_triangle(rect_side, height);
                }
            }
            // right bracket
            translate([widest_part-5,y_top + rect_side,0]) {
                rotate([0,0,180]) {
                    rectangular_triangle(rect_side, height);
                }
            }
        }
        translate([1,1,0]) {
            roundedcube([inner_size-2,12,height+2], 1);
        }
    }
}

module rectangular_triangle(side_length = 1, height = 1) {
    difference() {
        cube([side_length,side_length,height]);
        rotate([0,0,45]) {
            cube([side_length*1.5,side_length,height]);
        }
    }
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