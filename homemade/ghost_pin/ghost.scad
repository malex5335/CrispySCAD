eye_size = 4;
eye_depth = 1;
eye_distance = 12;
head_diameter = 28;
height = 10;
feet_size = 7;
wall = 2;

difference() {
    ghost();
    translate([0,0,wall]) {
        ghost(head_diameter-wall*2,4);
    }
}

module ghost(width=head_diameter) {
    head(width);
    eyes();
    translate([0,-head_diameter/2,height/2]) {
        body(width);
    }
}

module head(width) {
    cylinder(h=height,d=width);
}

module eyes() {
    $fn = 50;
    translate([-eye_distance/2,0,eye_size-eye_depth]) {
        sphere(r=eye_size);
    }
    translate([eye_distance/2,0,eye_size-eye_depth]) {
        sphere(r=eye_size);
    }
}

module body(width) {
    difference() {
        cube([width,width,height], true);
        feet(width);
    }
}

module feet(width) {
    translate([0,-width/2,-height/2]) {
        triangle(height, feet_size);
        translate([head_diameter/3,0,0]) {
            triangle(height, feet_size);
        }
        translate([-head_diameter/3,0,0]) {
            triangle(height, feet_size);
        }
    }
}

module triangle(height, radius) {
    rotate([0,0,90]) {
        cylinder(height, r=radius, $fn=3);
    }
}