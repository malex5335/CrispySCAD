length = 240;
rod_diameter = 6;
connector_diameter = 2;
connector_height = 5;
shield_diameter = 30;
shield_height = 1;
$fn = 90;

set();
// rod_wrapper(true);
// rod_wrapper(false);
// shield();

module set() {
    rod_wrapper(true);
    translate([shield_diameter*1.05,0,0]) {
        rod_wrapper(false);
    }
    translate([0,shield_diameter*1.05,0]) {
        shield();
        translate([shield_diameter*1.05,0,0]) {
            shield();
        }
    }
}

module rod_wrapper(top_part=true) {
    if(top_part)  {
        difference() {
        rod();
            translate([0,0,length-connector_height]) {
                connector();
            }
        }
    } else {
        rod();
        translate([0,0,length]) {
            connector();
        }
    }
}

module rod(with_shield=true) {
    difference() {
        cylinder(d = rod_diameter, h = length, center = false);
        cube_size = rod_diameter/4;
        cube_distance = rod_diameter/2-cube_size/2;
        translate([0,0,length/2]) {
            translate([0,cube_distance,0]) {
                cube([cube_size,cube_size,length], center=true);
            }
            translate([0,-cube_distance,0]) {
                cube([cube_size,cube_size,length], center=true);
            }
            translate([cube_distance,0,0]) {
                cube([cube_size,cube_size,length], center=true);
            }
            translate([-cube_distance,0,0]) {
                cube([cube_size,cube_size,length], center=true);
            }
        }
    }
    if(with_shield) {
        shield();
    }
}

module shield() {
    difference() {
        union() {
            cylinder(d = shield_diameter, h = shield_height, center = false);
            spikes();
            rotate([0,0,45]) {
                spikes();
            }
        }
        rod(with_shield=false);
    }
}

module connector() {
    translate([0,0,connector_height/2]) {
        cylinder(d = connector_diameter, h = connector_height, center = true);
    }
}

module spikes() {
    translate([shield_diameter/3,0,0]) {
        spike();
    }
    translate([-shield_diameter/3,0,0]) {
        spike();
    }
    translate([0,shield_diameter/3,0]) {
        spike();
    }
    translate([0,-shield_diameter/3,0]) {
        spike();
    }
}

module spike(distance) {
    height = 5;
    translate([0,0,height/2]) {
        cylinder(h = height, r1 = 1, r2 = 0, center = true);
    }
}