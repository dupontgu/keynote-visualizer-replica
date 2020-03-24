module center_slits() {
    left_slits_layer = "slits";
    right_slits_layer = "slits_bottom";
    dxf_file = "keynote_keyholes_center.dxf";
    left_hole_layer = "center_screw";
    right_hole_layer = "center_screw";

    include <keynote_chassis_slit_base.scad>
}

center_slits();
