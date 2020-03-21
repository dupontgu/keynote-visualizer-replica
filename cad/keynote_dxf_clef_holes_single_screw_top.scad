module top_assembly() {
    // stilts == "standoffs", pegs that sit against the acrylic to keep the assembly at the correct distance
    stilt_locations = [
        // x, y, anchor_x, anchor_y
        // x and y define the center point of the stilt
        // the anchor coords tell where the stilt's platform originates from
        [60, 124, 10, 124],
        [60, 0, 20, 30],
        [5, 155, 5, 100],
    ];

    dxf_file = "keynote_dxf_clef_holes_single_screw_top.dxf";

    include <keynote_chassis_base.scad>
}

top_assembly();




