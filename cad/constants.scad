platform_height = 3;
stilt_height = 16;
stilt_radius = 5;
back_plate_platform_height = 2.5;
socket_height = stilt_height - 4;
socket_screw_height = socket_height/2;
socket_radius = stilt_radius + 2.5;

x_index = 0;
y_index = 1;
anchor_x_index = 2;
anchor_y_index = 3;

module socket_screw_hole() {
    translate([0, 0, socket_screw_height]) rotate([90, 0, 0]) cylinder(r1=2, r2=2.16, h=stilt_radius * 2 + 1, $fn=60);
}