include <constants.scad>

pcb_screw_short_spacing = 48;
pcb_screw_long_spacing = 88;
screw_radius = 1.6;

module screw_holes() {
    translate([0, 0]) circle(r=screw_radius, $fn=60);
    translate([pcb_screw_long_spacing, 0]) circle(r=screw_radius, $fn=60);
    translate([pcb_screw_long_spacing, pcb_screw_short_spacing]) circle(r=screw_radius, $fn=60);
    translate([0, pcb_screw_short_spacing]) circle(r=screw_radius, $fn=60);
}

module pcb_holder() {
    stilt_locations = [
        // x, y, anchor_x, anchor_y
        // x and y define the center point of the stilt
        // the anchor coords tell where the stilt's platform originates from
        [pcb_screw_long_spacing + 20, pcb_screw_short_spacing / 2, pcb_screw_long_spacing + 5, pcb_screw_short_spacing / 2],
        [-20, pcb_screw_short_spacing / 2, -5, pcb_screw_short_spacing / 2],
    ];

    extruded_stilts(stilt_locations);
    linear_extrude(height=platform_height, center=false, convexity=10, twist=0) {
        stilt_platforms(stilt_locations);
        difference() {
            offset(r = 5) hull() screw_holes();
            offset(r = -8) hull() screw_holes();
            screw_holes();
        }
    }
}

pcb_holder();

