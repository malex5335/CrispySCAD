cube([98,26,1]);
translate([32,9,0]) {
    usb_port();
}
rotate([270,0,0]) {
    cube([98,13,1]);
}

module usb_port() {
    h = 20;
    w = 11;
    translate([w/2,0,-h/2]) {
        cube([w,2,h], true);
    }
}