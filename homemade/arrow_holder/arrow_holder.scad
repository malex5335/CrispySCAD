length = 240;
rod_diameter = 6;
connector_diameter = 2;
connector_height = 30;
shield_diameter = 30;
shield_height = 1;
$fn = 50;
use_spikes = true;
fitting_scale = 1.05;

// set();
// rod();
shield(true);

module set() {
    rod();
    translate([shield_diameter*1.05,0,0]) {
        shield(true);
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
        translate([0,0,length-connector_height/2]) {
            //shield();
        }
    }
}

module shield(removeable=false) {
    difference() {
        union() {
            cylinder(d = shield_diameter, h = shield_height, center = false);
            if(use_spikes) {
            spikes();
                rotate([0,0,45]) {
                    spikes();
                }
            }
        }
        if(removeable) {
            scale([fitting_scale,1,1]) {
                rod(false);
            }
            scale([1,fitting_scale,1]) {
                rod(false);
            }
        }
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