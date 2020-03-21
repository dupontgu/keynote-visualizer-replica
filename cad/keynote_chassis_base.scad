platform_height = 3;
stilt_height = 16;

x_index = 0;
y_index = 1;
anchor_x_index = 2;
anchor_y_index = 3;

module led_holes() {
    import (file = dxf_file, layer="led_holes", $fn = 60);
}

module left_screw_holes() {
    import (file = dxf_file, layer="screw_holes", $fn = 60);
}

module right_screw_holes() {
    import (file = dxf_file, layer="right_screw_holes", $fn = 60);
}

module stilt(x, y) {
    translate([x, y, 0]){
        circle(r=4, $fn=60);
    }
}

module stilt_platforms(stilt_locations) {
    for (i=[0:len(stilt_locations) - 1]) {
        offset(r = 4) {
            hull() {
                stilt(stilt_locations[i][x_index], stilt_locations[i][y_index]);
                stilt(stilt_locations[i][anchor_x_index], stilt_locations[i][anchor_y_index]);
            }
        }
    }
}

module extruted_stilts(stilt_locations) {
    for (i=[0:len(stilt_locations) - 1]) {
        linear_extrude(height = stilt_height + platform_height, center=false, convexity=10, twist=0) {
            stilt(stilt_locations[i][x_index], stilt_locations[i][y_index]);
        }
    }
}

linear_extrude(height=platform_height, center=false, convexity=10, twist=0) {
    difference() {
        union() {
            offset(3) {
                hull() led_holes();
                hull() left_screw_holes();
                hull() right_screw_holes();
            }
            stilt_platforms(stilt_locations);
        }
        union() {
            led_holes();
            left_screw_holes();
            right_screw_holes();
        }
    }
}

extruted_stilts(stilt_locations);