module right_slits() {
    left_slits_layer = "slits";
    right_slits_layer = "slits_bottom";
    dxf_file = "keynote_keyholes_right.dxf";
    left_hole_layer = "right_screw";
    right_hole_layer = "right_screw";

    include <keynote_chassis_slit_base.scad>
}

right_slits();
