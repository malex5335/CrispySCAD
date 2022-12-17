/**
 * This scad file creates keyacaps with engraved text to be easily 3D-printed.
 * The goal of this project is to create KeyCaps for all localizations due to the low
 * availability of KeyCaps for non-english keyboards.
 * All Keycaps will be created with DCS-profile only.
 *
 * Variables:
 * row - the row where the keycap will be placed
 *       1 = Numbers-row,
 *       2 = tabulator-row
 *       3 = caps row
 *       4 = shift-row | space row
 *       5 = F-Keys
 * space - if the keycap is a spacebar (row will be ignored)
 * size - the size of the keycap in units
 *       1 = default size
 *       1.25 = size of the ctrl-key
 *       ...
 * tl - the text on the top-left of the keycap
 * tc - the text on the top-center of the keycap
 * tr - the text on the top-right of the keycap
 * bl - the text on the bottom-left of the keycap
 * bc - the text on the bottom-center of the keycap
 * br - the text on the bottom-right of the keycap
 * fc - the text on the front-center of the keycap (ninja-text)
 *
 * use spaces in the text to position it right
 */

keyCap(row=5, tl="", tc="1!", tr="", bl="", bc="", br="", fc="F1", size=1, space=false); // edit this line to create your own keycap

/**
* example implementations:
* keyCap(row=5, size=1, tm="Esc"); // creates a keycap for the escape-key in the F-Row
* keyCap(row=1, size=2, tm="<--"); // creates a keycap for the backspace-key in the Numbers-Row
* keyCap(row=3, size=1.75, tm="CAPS-Lock"); // creates a keycap for the caps-lock-key in the Caps-Row
* keyCap(space=true, size=6.25); // creates a keycap for the space-key in the Space-Row
*/


// Code below here

font = "M+ 1p";
font_size = 5;
font_detail = 25;

unit = 18.161; // size of 1 unit in mm
heights = [11, 11, 11, 11, 12]; // rows 1-5
angles_front = [17, 10, 10, 10, 12]; // rows 1-5
angles_back = [8, 8, 8, 2, 8]; // rows 1-5
angles_left = [12, 12, 12, 12, 12]; // rows 1-5
angles_right = [12, 12, 12, 12, 12]; // rows 1-5
angles_top = [-1, 3, 7, 16, -6]; // rows 1-5
stem_starts = [2.9, 1.2, 1.3, 1.6, 1.4]; // rows 1-5
wall_thickness = 2;
stem_support_height = 3;
stem_thickness = 1.2;
stem_width = 4;
cherry_diameter = 6;

$fn = 100; // number of facets; bigger number = smoother edges

module keyCap(row=1,space=false,size=1,tl="",tc="",tr="",bl="",bc="",br="",fm="") {
    engravedCap(row, size, tl, tc, tr, bl, bc, br, fc, space);
    cherryStem(row, size);
    supportStem(row, size);
}

module engravedCap(row,size, tl, tc, tr, bl, bc, br, fc, space) {
    difference() {
        baseCap(row, size, space);
        printText(row, size, tl, tc, tr, bl, bc, br, fc);
    }
}

module baseCap(row,size,space) {
    width = unit * size;
    depth = unit;
    index = row-1;
    height = heights[index];
    difference() {
        angledCap(width, depth, height, index, size, space);
        translate([0, 0, -wall_thickness]) {
            width = width - wall_thickness;
            depth = depth - wall_thickness;
            angledCap(width, depth, height, index, size, space - wall_thickness/2);
        }
    }
}

module angledCap(width, depth, height, index, size, space, inner=0) {
    angle_front = angles_front[index];
    angle_back = angles_back[index];
    angle_left = angles_left[index];
    angle_right = angles_right[index];
    angle_top = angles_top[index];
    difference() {
        cube([width, depth, height], center = true);
        // back
        rotate([angle_back,0,0]) {
            translate([0,depth/1.33-(angle_back*0.1) + inner, 0]) {
                cube([width*1.5, depth/2, height*4], center = true);
            }
        }
        // front 13.7
        rotate([angle_front,0,180]) {
            translate([0,depth/1.33-(angle_front*0.1) + inner*10, 0]) {
                cube([width*1.5, depth/2, height*4], center = true);
            }
        }
        multiplicator = width / unit >= 3 ? 0.9 : 1.8;
        // left
        rotate([angle_left,0,90]) {
            translate([0,width/1.94-(angle_left*0.1)+ wall_thickness*multiplicator + inner/3, 0]) {
                cube([width*1.5, depth/2, height*4], center = true);
            }
        }
        // right
        rotate([angle_right,0,270]) {
            translate([0,width/1.94-(angle_right*0.1)+ wall_thickness*multiplicator + inner/3, 0]) {
                cube([width*1.5, depth/2, height*4], center = true);
            }
        }
        // top
        rotate([angle_top+90,0,180]) {
            translate([0,8.3-(angle_top*0.1) + inner, 0]) {
                cube([width*1.5, depth/2, height*4], center = true);
            }
        }
        if(!space) {
            diameter = pow(size, 3)*50;
            // cylinder top
            rotate([angle_top+90,0,180]) {
                translate([0,diameter/2 +  cos(angle_top)+0.3,-depth/2]) {
                    cylinder(d=diameter, h=height*2, $fn=200);
                }
            }
        }
    }
}

module cherryStem(row, size) {
    index = row - 1;
    stem_height = heights[index];
    stem_start = stem_starts[index];
    inner_width = unit*size - wall_thickness*2;
    union() {
        difference() {
            translate([0, 0, -stem_start-heights[index]/3]){
                cylinder(d = cherry_diameter, h = heights[index] , center = false);
            }
            translate([0, 0, - 2]) {
                cube([stem_width, stem_thickness, stem_height], center = true);
                rotate(90) {
                    cube([stem_width, stem_thickness, stem_height], center = true);
                }
            }
            translate([0, 0, -10]) {
                cube([inner_width, inner_width, stem_height], center = true);
            }
            
            if(!space) {
                diameter = pow(size, 3)*50;
                angle_top = angles_top[index];
                // cylinder top
                rotate([angle_top+90,0,180]) {
                    translate([0,diameter/2 +  cos(angle_top)-0.5,-unit/2]) {
                        cylinder(d=diameter, h=unit, $fn=200);
                    }
                }
            }
        }
    }
}

module supportStem(row, size) {
    if(size >= 2 && size < 6.25) {
        translate([2*cherry_diameter, 0, 0]) {
            cherryStem(row, size);
        }
        translate([-2*cherry_diameter, 0, 0]) {
            cherryStem(row, size);
        }
    } else if(size == 6.25) {
        translate([50, 0, 0]) {
            cherryStem(row, size);
        }
        translate([-50, 0, 0]) {
            cherryStem(row, size);
        }
    }
}

module printText(row,size,tl,tc,tr,bl,bc,br,fc) {
    padding = 2.2;
    corner_pos = -(unit*size)/ 2;
    letter_height = 10;
    index = row-1;
    angle_top = angles_top[index]*1.1;
    strong_angle = angle_top * 0.02;
    zPos = 1.7;
    // left
    translate([corner_pos + padding, padding,zPos - strong_angle]) {
        rotate([-angle_top,13,0])  {
            linear_extrude(height=letter_height) {
                    text(text=tl, size=font_size, font=font, halign="left", valign="bottom", $fn = font_detail);
            }
        }
    }
    translate([corner_pos + padding,-padding/3,zPos + strong_angle]) {
        rotate([-angle_top,13,0])  {
            linear_extrude(height=letter_height) {
                    text(text=bl, size=font_size, font=font, halign="left", valign="top", $fn = font_detail);
            }
        }
    }

    // center
    translate([0, padding,zPos-1 - strong_angle]) {
        rotate([-angle_top,0,0])  {
            linear_extrude(height=letter_height) {
                text(text = tc, size = font_size, font = font, halign = "center", valign = "bottom", $fn = font_detail);
            }
        }
    }
    translate([0,-padding/2,zPos-1 + strong_angle]) {
        rotate([-angle_top,0,0])  {
            linear_extrude(height=letter_height) {
                text(text = bc, size = font_size, font = font, halign = "center", valign = "top", $fn = font_detail);
            }
        }
    }
    // right
    translate([-corner_pos - padding,padding,zPos - strong_angle]) {
        rotate([-angle_top,-13,0])  {
            linear_extrude(height=letter_height) {
                text(text = tr, size = font_size, font = font, halign = "right", valign = "bottom", $fn = font_detail);
            }
        }
    }
    translate([-corner_pos-padding,-padding/2,zPos + strong_angle]) {
        rotate([-angle_top,-13,0])  {
            linear_extrude(height=letter_height) {
                text(text = br, size = font_size, font = font, halign = "right", valign = "top", $fn = font_detail);
            }
        }
    }
    // front
    angle_front = angles_front[index];
    distance_top = abs(angle_top)*0.1;
    translate([0,0,angle_top > 0 ? distance_top : -distance_top]){
        translate([0,-7.5,0]) {
            rotate([90-angle_front,0,0])
                linear_extrude(height=letter_height) {
                    text(text = fc, size = font_size-2, font = font, halign = "center", valign = "top", $fn = font_detail);
                }
        }
    }
}
