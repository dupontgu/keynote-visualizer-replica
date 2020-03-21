platform_height = 2.5;

module left_holes() {
    import (file = dxf_file, layer="screw_holes", $fn = 60);
}

module right_holes() {
    import (file = dxf_file, layer="right_screw_holes", $fn = 60);
}

module slits() {
    import (file = dxf_file, layer="slits", $fn = 60);
}

linear_extrude(height=platform_height, center=false, convexity=10, twist=0) {
    difference() {
        offset(3) {
            hull() slits();
            hull() left_holes();
            hull() right_holes();
        }
        slits();
        left_holes();
        right_holes();
    }
}