/**
 * This scad file creates KeyCaps with engraved text to be easily 3D-printed.
 * The goal of this project is to create KeyCaps for all localizations due to the low
 * availability of KeyCaps for non-english and iso keyboards.
 * All Keycaps will be created with DCS-profile and for cherry-stem only.
 */

/*
 * your default 100% keyboard rows from top to bottom:
 *  5
 *  1
 *  2
 *  3
 *  4
 *  4
 */
// the row (1-5) where the keycap will be placed according to DCS-Standard
row = 1;
text_top_left = "";
text_top_center = "Q";
text_top_right = "";
text_bottom_left = "か";
text_bottom_center = "";
text_bottom_right = "@";
text_front_center = "<<";
// the size in units i.e.: 1.25, 2.75
size = 1;
// true if you want a bump instead of a curve
convex = true;
// will generate an iso enter key, ignoring the size
iso_enter = false;
// size of 1 unit in mm
unit = 18.161;
// the font-name to use; make sure you have it installed!
font = "M+ 1p";
// size might need to be updated based on font
font_size = 5;
// a higher value means a cleaner text
font_detail = 25;
// heights of each keycap based on row
heights = [17, 15, 13, 11, 19];
// front angles of each keycap based on row
angles_front = [17, 10, 10, 10, 12];
// back angles of each keycap based on row
angles_back = [8, 8, 8, 2, 8];
// left side angles of each keycap based on row
angles_left = [12, 12, 12, 12, 12];
// right side angles of each keycap based on row
angles_right = [12, 12, 12, 12, 12];
// top angle of each keycap based on row
angles_top = [-1, 3, 7, 16, -6];
wall_thickness = 1;
top_thickness = 3.5;
// to fit a cherry mx switch
stem_thickness = 1.25;
// the complete with & height of the cherry mx stem
stem_width = 4.2;
// each stem is this much mm away from the bottom
stem_heights_diff = [2,2,2,2,2];
stem_stud_diameter = 6;
index = row-1;

$fn = 100; // number of facets; bigger number = smoother edges

engravedCap();
cherryStem();
supportStem();
module engravedCap() {
    width = unit * size;
    depth = unit;
    height = heights[index];
    difference() {
        difference() {
            angledCap(width, depth, height);
            translate([0, 0, - top_thickness]) {
                angledCap(width, depth, height, - wall_thickness);
            }
        }
        printText();
    }
}

module angledCap(width, depth, height, inner=0) {
    angle_front = angles_front[index];
    angle_back = angles_back[index];
    angle_left = angles_left[index];
    angle_right = angles_right[index];
    angle_top = angles_top[index];
    intersection() {
        difference() {
            cube([width, depth, height], center = true);
            // back
            rotate([angle_back,0,0]) {
                translate([0,depth/1.37-(angle_back*0.1) + inner/4, 0]) {
                    cube([width*1.5, depth/2, height*4], center = true);
                }
            }
            // front
            rotate([angle_front,0,180]) {
                translate([0,depth/1.4-(angle_front*0.1) + inner/4, 0]) {
                    cube([width*1.5, depth/2, height*4], center = true);
                }
            }
            multiplicator = width / unit >= 3 ? 1.8 : 3.6;
            side_correction = 1.98;
            // left
            rotate([angle_left,0,90]) {
                translate([0,width/side_correction-(angle_left*0.1)+ multiplicator + inner/3, 0]) {
                    cube([width*1.5, depth/2, height*4], center = true);
                }
            }
            // right
            rotate([angle_right,0,270]) {
                translate([0,width/side_correction-(angle_right*0.1)+ multiplicator + inner/3, 0]) {
                    cube([width*1.5, depth/2, height*4], center = true);
                }
            }
            // top
            rotate([angle_top+90,0,180]) {
                translate([0,8.3-(angle_top*0.1) + inner, 0]) {
                    cube([width*1.5, depth/2, height*4], center = true);
                }
            }
            if(!convex) {
                diameter = pow(size, 3)*50;
                // cylinder top
                rotate([angle_top+90,0,180]) {
                    translate([0,diameter/2 +  cos(angle_top)+0.3,-depth/2]) {
                        cylinder(d=diameter, h=height*2, $fn=200);
                    }
                }
            }
        }
        if(convex) {
            diameter = pow(size, 3)*50;
            magic_number = -diameter/2 + heights[index]*0.15;
            // cylinder top
            rotate([angle_top+90,0,180]) {
                translate([0,magic_number,0]) { // 2.42 -> 2.01429
                    cylinder(d=diameter, h=height*2, $fn=200, center=true);
                }
            }
        }
    }
}

module cherryStem() {
    index = row - 1;
    stem_height = heights[index] - stem_heights_diff[index];
    difference() {
        cylinder(d = stem_stud_diameter, h = stem_height , center = true);
        cylinder(d = stem_stud_diameter, h = stem_height/2 , center = false);
        cube([stem_width, stem_thickness, stem_height], center = true);
        rotate(90) {
            cube([stem_width, stem_thickness, stem_height], center = true);
        }
        if(!convex) {
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

module supportStem() {
    if(size >= 2 && size < 6.25) {
        translate([2*stem_stud_diameter, 0, 0]) {
            cherryStem();
        }
        translate([-2*stem_stud_diameter, 0, 0]) {
            cherryStem();
        }
    } else if(size == 6.25) {
        translate([50, 0, 0]) {
            cherryStem();
        }
        translate([-50, 0, 0]) {
            cherryStem();
        }
    }
}

module printText() {
    padding = 2.4;
    corner_pos = -(unit*size)/ 2;
    letter_height = 10;
    index = row-1;
    angle_top = angles_top[index];
    circle_degree = pow(size, 3)*50 / 8;
    strong_angle = 0;
    letter_degree = convex ? -circle_degree : circle_degree;
    zPos = (convex ? 1.1 : 1.6) - sqrt(abs(angle_top))*0.1;
    // left
    translate([corner_pos + padding, padding/5,zPos - strong_angle]) {
        rotate([-angle_top,letter_degree,0])  {
            linear_extrude(height=letter_height) {
                    text(text=text_top_left, size=font_size, font=font, halign="left", valign="bottom", $fn = font_detail);
            }
        }
    }
    translate([corner_pos + padding,-padding/5,zPos + strong_angle]) {
        rotate([-angle_top,letter_degree,0])  {
            linear_extrude(height=letter_height) {
                    text(text=text_bottom_left, size=font_size, font=font, halign="left", valign="top", $fn = font_detail);
            }
        }
    }

    // center
    translate([0, padding/2,(convex ? zPos : zPos-0.5) - strong_angle]) {
        rotate([-angle_top,0,0])  {
            linear_extrude(height=letter_height) {
                text(text = text_top_center, size = font_size, font = font, halign = "center", valign = "bottom", $fn = font_detail);
            }
        }
    }
    translate([0,-padding/2,(convex ? zPos : zPos-0.5) + strong_angle]) {
        rotate([-angle_top,0,0])  {
            linear_extrude(height=letter_height) {
                text(text = text_bottom_center, size = font_size, font = font, halign = "center", valign = "top", $fn = font_detail);
            }
        }
    }
    // right
    translate([-corner_pos - padding,padding/5,zPos - strong_angle]) {
        rotate([-angle_top,-letter_degree,0])  {
            linear_extrude(height=letter_height) {
                text(text = text_top_right, size = font_size, font = font, halign = "right", valign = "bottom", $fn = font_detail);
            }
        }
    }
    translate([-corner_pos-padding,-padding/5,zPos + strong_angle]) {
        rotate([-angle_top,-letter_degree,0])  {
            linear_extrude(height=letter_height) {
                text(text = text_bottom_right, size = font_size, font = font, halign = "right", valign = "top", $fn = font_detail);
            }
        }
    }
    // front
    angle_front = angles_front[index];
    distance_top = abs(angle_top)*0.1;
    translate([0,0.2,(angle_top > 0 ? distance_top : -distance_top)-0.5]){
        translate([0,-7,0]) {
            rotate([90-angle_front,0,0])
                linear_extrude(height=letter_height) {
                    text(text = text_front_center, size = font_size-2, font = font, halign = "center", valign = "top", $fn = font_detail);
                }
        }
    }
}
