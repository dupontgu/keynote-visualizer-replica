include <constants.scad>;

module stilt_socket() {
    radius = socket_radius;
    difference() {
        hull() {
            cylinder(r=radius, h=socket_height, $fn = 100);
            translate([-radius/2, -radius*1.5, 0]) cube(size=[radius, radius, socket_height]);
        }
        translate([0, 0, -2]) cylinder(r=stilt_radius + 0.4, h=socket_height + 10, $fn = 100);
        translate([0, -socket_radius/2, 0]) socket_screw_hole();
    }
}

stilt_socket();