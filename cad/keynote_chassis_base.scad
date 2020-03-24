include <constants.scad>

module center_holes() {
    import (file = dxf_file, layer=center_hole_layer, $fn = 60);
}

module left_holes() {
    import (file = dxf_file, layer=left_hole_layer, $fn = 60);
}

module right_holes() {
    import (file = dxf_file, layer=right_hole_layer, $fn = 60);
}

module stilt(x, y) {
    translate([x, y, 0]){
        circle(r=stilt_radius, $fn=60);
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
        difference() {
            linear_extrude(height = stilt_height + platform_height, center=false, convexity=10, twist=0) {
                stilt(stilt_locations[i][x_index], stilt_locations[i][y_index]);
            }
            translate([stilt_locations[i][x_index], stilt_locations[i][y_index] + 5, stilt_height + platform_height - (2 * socket_screw_height)]) socket_screw_hole();
        }
    }
}

linear_extrude(height=platform_height, center=false, convexity=10, twist=0) {
    difference() {
        union() {
            offset(3) {
                hull() center_holes();
                hull() left_holes();
                hull() right_holes();
            }
            stilt_platforms(stilt_locations);
        }
        union() {
            center_holes();
            left_holes();
            right_holes();
        }
    }
}

extruted_stilts(stilt_locations);