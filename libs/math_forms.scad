module equal_triangle(length=5, height=2) {
    rotate([0,0,90]) {
        cylinder(d = length, h = height, center = false, $fn = 3);
    }
}

module parallelogram(width = 10, length = 10, height = 2, distortion = 5) {
    start = 0;
    distortedWidth = width + distortion;
    distortedStart = start + distortion;
    width = start + width;
    CubePoints = [
            [ distortedStart, start, start],    //0
            [ distortedWidth, start, start ],   //1
            [ width, length, start ],            //2
            [ start, length, start ],            //3
            [ distortedStart, start,  height ], //4
            [ distortedWidth, start,  height ], //5
            [ width,  length,  height ],         //6
            [ start,  length,  height ]          //7
        ];

    CubeFaces = [
            [0,1,2,3],  // bottom
            [4,5,1,0],  // front
            [7,6,5,4],  // top
            [5,6,2,1],  // right
            [6,7,3,2],  // back
            [7,4,0,3]   // left
    ];

    polyhedron( CubePoints, CubeFaces );
}

module hollow_cylinder(diameter = 10, height = 10, wall_thickness = 2, detail = 100) {
    difference() {
        cylinder(d = diameter, h = height, center = false, $fn = detail);
        cylinder(d = diameter - wall_thickness * 2, h = height, center = false, $fn = detail);
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