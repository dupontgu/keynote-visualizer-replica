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

extruded_stilts(stilt_locations);