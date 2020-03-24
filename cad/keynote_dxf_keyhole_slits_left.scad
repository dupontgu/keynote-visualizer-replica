module left_slits() {
    left_slits_layer = "slits";
    right_slits_layer = "slits_bottom";
    dxf_file = "keynote_keyholes_left.dxf";
    left_hole_layer = "left_screw";
    right_hole_layer = "left_screw";

    include <keynote_chassis_slit_base.scad>
}

left_slits();



