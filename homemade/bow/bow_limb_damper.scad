inner_width = 21;
length = 80;
outer_width = 35;
height = 9;

damper();

module damper() {
    union() {
        translate([0,0,height]) {
            top(45, 8, 9);
        }
        base();
        translate([0,0,-height]) {
            bottom(25, 8, 9);
        }
    }
}

module base() {
    cube([inner_width,length,height]);
}

module top(fidgy_width, fidgy_length, fidgy_height) {
    translate([-(fidgy_width-inner_width)/2,0,0]) {
        translate([0,fidgy_length*0.5,0]) {
            fidgy(fidgy_width,fidgy_length,fidgy_height);
        }
        translate([0,fidgy_length*2.5,0]) {
            fidgy(fidgy_width,fidgy_length,fidgy_height);
        }
        translate([0,fidgy_length*4.5,0]) {
            fidgy(fidgy_width,fidgy_length,fidgy_height);
        }
        translate([0,fidgy_length*6.5,0]) {
            fidgy(fidgy_width,fidgy_length,fidgy_height);
        }
        translate([0,fidgy_length*8.5,0]) {
            fidgy(fidgy_width,fidgy_length,fidgy_height);
        }
    }
}

module bottom(fidgy_width, fidgy_length, fidgy_height) {
    translate([fidgy_width-inner_width/5,0,height]) {
        rotate([0,180,0]) {
            top(25, fidgy_length, fidgy_height);
        }
    }
}

module fidgy(w, l, h) {
    union() {
        cube([w,l,h]);
        translate([0,l,(5*1.5)-(h*0.11)]) {
            rotate([90,90,0]) {
                #cylinder(h=l,r=5, $fn=3);
            }
            translate([w,0,0]) {
                rotate([90,90,0]) {
                    #cylinder(h=l,r=5, $fn=3);
                }
            }
        }
    }
}