use <../libs/threads.scad>

// first create a threaded rod
height = 15;
difference() {
    ScrewThread(outer_diam=22.7, height=height, pitch=0, tooth_angle=30, tolerance=0.4, tip_height=0, tooth_height=0, tip_min_fract=0);
    cylinder(h=height, d=17, $fn=100);
}