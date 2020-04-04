use <keynote_dxf_clef_holes_single_screw_top.scad>
use <keynote_dxf_clef_holes_single_screw_bottom.scad>
use <keynote_dxf_clef_slits_top.scad>
use <keynote_dxf_clef_slits_bottom.scad>
use <keynote_dxf_keyhole_screw_left.scad>
use <keynote_dxf_keyhole_slits_left.scad>
use <keynote_dxf_keyhole_screw_center.scad>
use <keynote_dxf_keyhole_slits_center.scad>
use <keynote_dxf_keyhole_screw_right.scad>
use <keynote_dxf_keyhole_slits_right.scad>
use <led_holder_v11.scad>
use <pcb_holder.scad>

// relative placements are approximate! values are arbitrary!
// TODO mock LED

bottom_y_offset = -99;
slits_z_offset = -8;

top_assembly();
color("orange") translate([8.5, 18, 6]) rotate([0, 0, -135])  {
    led_holder();
}

color("blue") translate([0, bottom_y_offset, 0]) {
    bottom_assembly();
}

color("green") translate([0, 0, slits_z_offset]) {
    top_slits();
}

color("red") translate([0, bottom_y_offset, slits_z_offset]) {
    bottom_slits();
}

translate([70, 50, 0]) {
    color("cyan") left_assembly();
    color ("magenta") translate([0, 0, slits_z_offset]) left_slits(); 
    translate([110, 0, 0]) {
        color("grey") center_assembly();
        color ("black") translate([0, 0, slits_z_offset]) center_slits(); 
    }

    translate([215, 0, 0]) {
        color("olive") right_assembly();
        color ("lime") translate([0, 0, slits_z_offset]) right_slits(); 
    }
}

translate([150, -70, 0]) {
    color("purple") pcb_holder();
}

