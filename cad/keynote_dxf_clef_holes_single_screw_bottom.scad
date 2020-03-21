module bottom_assembly() {
    // stilts == "standoffs", pegs that sit against the acrylic to keep the assembly at the correct distance
    stilt_locations = [
        // x, y, anchor_x, anchor_y
        // x and y define the center point of the stilt
        // the anchor coords tell where the stilt's platform originates from
        [60, 54, 10, 84],
        [60, 10, 10, 10],
        [5, -20, 5, 10],
    ];

    dxf_file = "keynote_dxf_clef_holes_single_screw_bottom.dxf";

    include <keynote_chassis_base.scad>
}

bottom_assembly();



