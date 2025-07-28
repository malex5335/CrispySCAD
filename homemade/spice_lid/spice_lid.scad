cup();

module cup() {
    $fn = 50;
    outer_radius = 25;
    inner_radius = 23.5;
    height = 15;
    thickness = 1;
    difference() {
        union() {
            cylinder(1, r = outer_radius);
            cylinder(height, r = inner_radius);
        }
        translate([0,0,thickness]) {
            cylinder(height, r = inner_radius-0.5);
        }
        hole_circle(1, 0, thickness);
        hole_circle(5, 5, thickness);
        hole_circle(10, 10, thickness);
    }
}

module hole_circle(amount, distance, thickness) {
    degree = 360/amount;
    hole_radius = 1;
    for ( i = [1:1:amount] ) {
        rotate([0,0,degree*i]) {
            translate([0,distance,0]) {
                cylinder(thickness, r = hole_radius);
            }
        }
    }
}