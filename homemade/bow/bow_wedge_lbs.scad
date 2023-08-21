// false if to use custom sizes
use_predefined_lbs = true;
// text label and predefines variables (available: 35)
lbs = 35;
// width of the grove in the bow-arm where the body rests
height = 20.5;
// arm length up to screw on the inner side
depth_1 = 13.0;
// body length up to screw on the inner side
depth_2 = 17.0;
// visible screw length between arm and body
width_1 = 12.2;
// longest distance between bow-arm and body
width_2 = 14.5;
// font size of the lbs text (more lbs = lower number)
text_size = 10;
// change if text is not visible (more lbs = lower number)
text_angle = 15.55;

if(use_predefined_lbs) {
    wedge();
} else {
    wedge(
        height,
        depth_1,
        width_1,
        depth_2,
        width_2,
        text_size,
        text_angle
    );
}

module wedge(
    height = getValue("height", measurements),
    depth_1 = getValue("depth_1", measurements),
    width_1 = getValue("width_1", measurements),
    depth_2 = getValue("depth_2", measurements),
    width_2 = getValue("width_2", measurements),
    text_size = getValue("text_size", measurements),
    text_angle = getValue("text_angle", measurements)
 ) {
    difference() {
        hull() {
            hull_ratio = 0.99999;
            translate([width_2 - width_1, 0, 0]) {
                cube([width_1, depth_1, height]);
            }
            cube_1_touchpoint_diff = depth_1 * hull_ratio;
            cube_1_touchpoint = depth_1 - cube_1_touchpoint_diff;
            translate([0, cube_1_touchpoint_diff, 0]) {
                cube([width_1, cube_1_touchpoint, height]);
            }
            cube_2_touchpoint_diff = width_2 * hull_ratio;
            cube_2_touchpoint = width_2 - cube_2_touchpoint_diff;
            translate([cube_2_touchpoint_diff, 0, 0]) {
                cube([cube_2_touchpoint, depth_2, height]);
            }
        }
        translate([width_2/2,depth_1,height/2]) {
            rotate([text_angle,-90,-90]) {
                linear_extrude(2) {
                    text(
                        str(lbs),
                        font = "Roboto:style=Black",
                        size = text_size,
                        halign = "center",
                        valign = "center"
                    );
                }
            }
        }
    }
}

function getValue(key, map) = map[getTuple(getKey(key),map)][1];

function getTuple(key, map) = search([key],map)[0];

function getKey(key) = str(lbs,"_",key);

measurements = [
    ["35_height", 20.5],
    ["35_depth_1", 13.0],
    ["35_width_1", 12.2],
    ["35_depth_2", 17.0],
    ["35_width_2", 14.5],
    ["35_text_size", 10],
    ["35_text_angle", 15.55]
];