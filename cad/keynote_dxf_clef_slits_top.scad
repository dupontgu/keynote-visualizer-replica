module top_slits() {
    dxf_file = "keynote_dxf_clef_holes_single_screw_top.dxf";
    left_slits_layer = "slits";
    right_slits_layer = "slits";
    left_hole_layer = "screw_holes";
    right_hole_layer = "right_screw_holes";

    include <keynote_chassis_slit_base.scad>
}

top_slits();