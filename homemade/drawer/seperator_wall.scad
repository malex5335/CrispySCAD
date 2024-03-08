width = 230;
height = 160;
wall_thickness = 10;
wall_depth = 15;
connector_depth = wall_depth*0.8;
hexagon_size = 25;
connector_spacing_p = 4;
enable_cutout = false;
left_connector = false;
right_connector = true;

difference() {
    wiggle_percent = connector_spacing_p/100;
    cube([wall_thickness,width,height], true);
    translate([0,-(width/2-wall_depth),0]) {
        scale([1+wiggle_percent,1+wiggle_percent,1]) {
            if(right_connector) {
                connector();
            }
        }
    }
    translate([0,(width/2-wall_depth),0]) {
        rotate([0,0,180]) {
            scale([1+wiggle_percent,1+wiggle_percent,1]) {
                if(left_connector) {
                    connector();
                }
            }
        }
    }
    if(enable_cutout) {
        hexagon_wall(hexagon_size);
    }
}

module connector() {
    connector_thickness = wall_thickness * 0.5;
    wall_diff = connector_thickness*0.2;
    translate([-connector_thickness/2,-wall_depth,-height/2]) {
        difference() {
            cube([connector_thickness,wall_depth,height]);
            cube([wall_diff,connector_depth,height]);
            translate([connector_thickness-wall_diff,0,0]){
                cube([wall_diff,connector_depth,height]);
            }
            triangle_rad = 1.15;
            translate([0,connector_depth + triangle_rad/(wall_diff*2.1),0]) {
                triangle(height, triangle_rad);
                translate([connector_thickness,0,0]) {
                    triangle(height, triangle_rad);
                }
            }
        }
    }
}

module triangle(height, triangle_rad) {
    rotate([0,0,90]) {
        cylinder(h=height, r=triangle_rad, $fn=3);
    }
}

module hexagon_wall(size = 15) {
    intersection() {
        cutout_area();
        translate([0,-width/2,-height/2]) {
            count_w = width / (size * 2);
            for(w_i = [0 : count_w]) {
                count_h = height / (size * 2);
                for(h_i = [0 : count_h]) {
                    buffer_h = h_i % 2 * size;
                    buffer = buffer_h;
                    translate([0,w_i*size*2+buffer,h_i*size*2]) {
                        hexagon(size);
                    }
                }
            }
        }
    }
}

module hexagon(size = 15) {
    rotate([0,90,0]) {
        cylinder(h=wall_thickness, r=size, $fn=6, center=true);
    }
}

module cutout_area() {
    h = height - wall_depth*2.1;
    w = width - wall_depth*2.1;
    cube([wall_thickness,w,h], center = true);
}