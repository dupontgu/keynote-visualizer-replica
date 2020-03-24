include <constants.scad>

module left_holes() {
    import (file = dxf_file, layer=left_hole_layer, $fn = 60);
}

module right_holes() {
    import (file = dxf_file, layer=right_hole_layer, $fn = 60);
}

module left_slits() {
    import (file = dxf_file, layer=left_slits_layer, $fn = 60);
}

module right_slits() {
    import (file = dxf_file, layer=right_slits_layer, $fn = 60);
}

linear_extrude(height=back_plate_platform_height, center=false, convexity=10, twist=0) {
    difference() {
        offset(3) {
            hull() left_slits();
            hull() right_slits();
            hull() left_holes();
            hull() right_holes();
        }
        left_slits();
        right_slits();
        left_holes();
        right_holes();
    }
}