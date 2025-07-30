// should match the outer diameter of Your jar opening
outer_diameter = 50;
// should match the outer diameter of Your jar opening minus the thickness of it's wall
inner_diameter = 47;
// how deep this insert will go into Your jar
height = 15;
// how many circles of holes (additionally to 1 in the middle) will be created
hole_circles = 2;
// how far apart the circles will be created to each other
hole_circle_distance = 5;
// the amount of holes in each row will be this number * the row counter
hole_count_multiplier = 5;
// the higher the more round (i.e. make it hexagonal by typing 6)
resolution = 100;

lid();

module lid() {
    wall_thickness = 1;
    difference() {
        union() {
            cylinder(1, d = outer_diameter, $fn = resolution);
            cylinder(height, d = inner_diameter, $fn = resolution);
        }
        translate([0,0,wall_thickness]) {
            cylinder(height, d = inner_diameter-1, $fn = resolution);
        }
        hole_circle(1, 0, wall_thickness);
        for ( i = [1:1:hole_circles]) {
            hole_circle(hole_count_multiplier*i, hole_circle_distance*i, wall_thickness);
        }
    }
}

module hole_circle(amount, distance, thickness) {
    degree = 360/amount;
    hole_radius = 1;
    for ( i = [1:1:amount] ) {
        rotate([0,0,degree*i]) {
            translate([0,distance,0]) {
                cylinder(thickness, r = hole_radius, $fn = 25);
            }
        }
    }
}