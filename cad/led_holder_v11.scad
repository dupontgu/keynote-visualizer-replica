LED_HOLE = 5.4;
CYL_HEIGHT = 14;
BASE_HEIGHT = 6;
M3_HOLE = 3.5;
M3_NUT_R = 3.4;
SCREW_DISTANCE = 10;

module mainHull() {
    union() {
        cylinder(r=5, h=CYL_HEIGHT, center=false, $fn=160);
        translate([SCREW_DISTANCE, 0, 0]) {
            cylinder(r=4, h=BASE_HEIGHT, center=false,$fn=160);
        }

        hull() {
            cylinder(r=5, h=BASE_HEIGHT, center=false, $fn=160);
            translate([SCREW_DISTANCE, 0, 0]) {
                cylinder(r=5, h=BASE_HEIGHT, center=false,$fn=160);
            }
        }
    }
}

module led_holder() {
    difference() {
        mainHull();
        // holes
        translate([0, 0, -2]) {
            cylinder(r=3, h=CYL_HEIGHT + 4, center=false, $fn=160);
        }
        translate([SCREW_DISTANCE, 0, 2]) {
            cylinder(r=M3_NUT_R, h=CYL_HEIGHT, center=false, $fn=6);
        }
        translate([SCREW_DISTANCE, 0, -2]) {
            cylinder(r=M3_HOLE/2, h=CYL_HEIGHT + 1, center=false, $fn=160);
        }
    }
}

led_holder();

