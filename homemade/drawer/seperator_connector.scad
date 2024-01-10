height = 160;
wall_thickness = 10;
wall_depth = 15;
connector_depth = wall_depth*0.8;

union() {
    base();
    translate([0,wall_thickness*2,0]) {
        connector();
    }
    translate([wall_thickness*2,0,0]) {
        rotate([0,0,-90]) {
            connector();
        }
    }
    translate([0,-wall_thickness*2,0]) {
        rotate([0,0,-180]) {
            connector();
        }
    }
    translate([-wall_thickness*2,0,0]) {
        rotate([0,0,90]) {
            connector();
        }
    }
}


module base() {
    cube([wall_thickness,wall_thickness,height], true);
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