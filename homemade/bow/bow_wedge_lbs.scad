// false if to use custom sizes
use_predefined_lbs = true;
// text label and predefines variables (available: 35, 37, 38, 40, 42, 44, 46, 50, 51, 54, 57, 59, 61)
lbs = 57;
// width of the grove in the bow-arm where the body rests
height = 20.5;
// arm length up to screw on the inner side
depth_1 = 13.0;
// body length up to screw on the inner side
depth_2 = 17.0;
// visible screw length between arm and body
width_1 = 12.2;
// longest distance between bow-arm and body
width_2 = 14.3;
// font size of the lbs text (more lbs = lower number)
text_size = 10;
// change if text is not visible (more lbs = higher number)
text_angle = 15.55;
// how many millimeters to lift the label
text_lift = 0;

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
        text_angle,
        text_lift
    );
}

module wedge(
    height = 20.5,
    depth_1 = 13.0,
    width_1 = getValue("width_1", measurements),
    depth_2 = 17.0,
    width_2 = getValue("width_2", measurements),
    text_size = getValue("text_size", measurements),
    text_angle = getValue("text_angle", measurements),
    text_lift = getValue("text_lift", measurements)
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
                    translate([0,text_lift,text_lift/2]) {
                    #linear_extrude(2) {
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
}


function getValue(key, map) = map[getTuple(getKey(key),map)][1];

function getTuple(key, map) = search([key],map)[0];

function getKey(key) = str(lbs,"_",key);

measurements = [

    ["35_width_1", 13.8],
    ["35_width_2", 15.6],
    ["35_text_size", 10],
    ["35_text_angle", 14.5],
    ["35_text_lift", 0.3],

    ["37_width_1", 13],
    ["37_width_2", 15],
    ["37_text_size", 10],
    ["37_text_angle", 15],
    ["37_text_lift", 0.3],

    ["38_width_1", 12.2],
    ["38_width_2", 14.3],
    ["38_text_size", 10],
    ["38_text_angle", 15.55],
    ["38_text_lift", 0.3],

    ["40_width_1", 11.7],
    ["40_width_2", 13.6],
    ["40_text_size", 10],
    ["40_text_angle", 16.4],
    ["40_text_lift", 0.3],

    ["42_width_1", 10.91],
    ["42_width_2", 12.6],
    ["42_text_size", 10],
    ["42_text_angle", 17.5],
    ["42_text_lift", 0.3],

    ["44_width_1", 10.1],
    ["44_width_2", 11.5],
    ["44_text_size", 9],
    ["44_text_angle", 19.5],
    ["44_text_lift", 0.3],

    ["46_width_1", 9.3],
    ["46_width_2", 10.5],
    ["46_text_size", 7],
    ["46_text_angle", 21],
    ["46_text_lift", 0.3],

    ["50_width_1", 7.8],
    ["50_width_2", 8.6],
    ["50_text_size", 7],
    ["50_text_angle", 25],
    ["50_text_lift", 0.5],

    ["51_width_1", 7.4],
    ["51_width_2", 8.1],
    ["51_text_size", 6],
    ["51_text_angle", 27.2],
    ["51_text_lift", 0.5],

    ["54_width_1", 6.5],
    ["54_width_2", 6.9],
    ["54_text_size", 5],
    ["54_text_angle", 30.7],
    ["54_text_lift", 1.2],

    ["57_width_1", 5.5],
    ["57_width_2", 5.7],
    ["57_text_size", 4],
    ["57_text_angle", 35.2],
    ["57_text_lift", 1.2],

    ["59_width_1", 4.6],
    ["59_width_2", 4.6],
    ["59_text_size", 4],
    ["59_text_angle", 41],
    ["59_text_lift", 1.2],

    ["61_width_1", 3.6],
    ["61_width_2", 3.6],
    ["61_text_size", 3.5],
    ["61_text_angle", 50],
    ["61_text_lift", 1.2],
];