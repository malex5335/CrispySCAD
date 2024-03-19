cube([98,26,1]);
translate([23,9,0]) {
    usb_port();
}
rotate([270,0,0]) {
    cube([98,14,1]);
}

module usb_port() {
    rotate([180,0,0]) {
        translate([0,-2,0]) {
            cube([21,2,14]);
        }
    }
}