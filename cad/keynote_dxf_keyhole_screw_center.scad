module center_assembly() {
    // stilts == "standoffs", pegs that sit against the acrylic to keep the assembly at the correct distance
    stilt_locations = [
        // x, y, anchor_x, anchor_y
        // x and y define the center point of the stilt
        // the anchor coords tell where the stilt's platform originates from
        [24, -40, 24, 10],
        [55, 80, 55, 20],
        [90,-40, 90, 10],
    ];

    dxf_file = "keynote_keyholes_center.dxf";
    center_hole_layer = "center";
    left_hole_layer = "center_screw";
    right_hole_layer = "center_bottom";

    include <keynote_chassis_base.scad>
}

center_assembly();
