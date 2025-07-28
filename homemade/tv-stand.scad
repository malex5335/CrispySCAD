height=50;
width=60;
depth=220;
holeHeight=height;
holeWidth=30;
holeDepth=80;

difference() {
    cube([width,depth,height]);
    translate([(width-holeWidth)/2,(depth/2-holeDepth)/2,0]) {
        cube([holeWidth,holeDepth,holeHeight]);
    }
    translate([(width-holeWidth)/2,(depth*1.5-holeDepth)/2,0]) {
        cube([holeWidth,holeDepth,holeHeight]);
    }
}