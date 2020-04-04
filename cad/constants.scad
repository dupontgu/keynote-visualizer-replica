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
    translate([0, 0, socket_screw_height]) rotate([90, 0, 0]) cylinder(r1=2, r2=2.3, h=stilt_radius * 2 + 1, $fn=60);
}

module stilt(x, y) {
    translate([x, y, 0]){
        circle(r=stilt_radius, $fn=60);
    }
}

module stilt_platforms(stilt_locations) {
    for (i=[0:len(stilt_locations) - 1]) {
        offset(r = 4) {
            hull() {
                stilt(stilt_locations[i][x_index], stilt_locations[i][y_index]);
                stilt(stilt_locations[i][anchor_x_index], stilt_locations[i][anchor_y_index]);
            }
        }
    }
}

module extruded_stilts(stilt_locations) {
    for (i=[0:len(stilt_locations) - 1]) {
        difference() {
            linear_extrude(height = stilt_height + platform_height, center=false, convexity=10, twist=0) {
                stilt(stilt_locations[i][x_index], stilt_locations[i][y_index]);
            }
            translate([stilt_locations[i][x_index], stilt_locations[i][y_index] + 5, stilt_height + platform_height - (2 * socket_screw_height)]) socket_screw_hole();
        }
    }
}