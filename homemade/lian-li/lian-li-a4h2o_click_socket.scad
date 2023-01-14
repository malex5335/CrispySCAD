// change if click-mechanism does not fit or is too loose
socket_height = 5.8;

example_socket();

module click_socket() {
    depth = 15;
    holding_plate = 14.9;
    holder_thickness = 0.8;
    inner_chamber = 12.3;
    inlay = 1;
    hook_depth = 1.4;
    rotate([90,0,0]){
        translate([-holding_plate / 2, 0, -socket_height/2]){
            translate([holding_plate/2 - inner_chamber/2,holder_thickness + inlay,0]) {
                cube([inner_chamber,depth,socket_height]);
            }
            inside_width = inner_chamber - hook_depth * 2;
            translate([(holding_plate - inside_width) / 2,0,0]) {
                cube([inside_width, inlay + holder_thickness,socket_height]);
            }
            cube([holding_plate,inlay,socket_height]);
        }
    }
}

module example_socket() {
    example_height = 10;
    difference() {
        translate([0,0,example_height/2]) {
            cube([17,socket_height + 2, example_height], center=true);
        }
        click_socket();
    }
}