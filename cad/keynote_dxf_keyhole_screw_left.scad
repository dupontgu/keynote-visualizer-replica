module left_assembly() {
    // stilts == "standoffs", pegs that sit against the acrylic to keep the assembly at the correct distance
    stilt_locations = [
        // x, y, anchor_x, anchor_y
        // x and y define the center point of the stilt
        // the anchor coords tell where the stilt's platform originates from
        [24, 80, 24, 20],
        [55, -40, 55, 10],
        [90, 80, 90, 20],
    ];

    dxf_file = "keynote_keyholes_left.dxf";
    center_hole_layer = "left";
    left_hole_layer = "left_screw";
    right_hole_layer = "left_bottom";

    include <keynote_chassis_base.scad>
}

left_assembly();



