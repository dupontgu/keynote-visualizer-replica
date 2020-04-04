files=(
    "keynote_dxf_clef_holes_single_screw_bottom"
    "keynote_dxf_clef_holes_single_screw_top"
    "keynote_dxf_keyhole_screw_left"
    "keynote_dxf_keyhole_screw_right"
    "keynote_dxf_keyhole_screw_center"
    "keynote_dxf_clef_slits_top"
    "keynote_dxf_clef_slits_bottom"
    "keynote_dxf_keyhole_slits_left"
    "keynote_dxf_keyhole_slits_right"
    "keynote_dxf_keyhole_slits_center"
    "led_holder_v11"
    "stilt_socket"
    "pcb_holder"
)

for i in "${files[@]}"
do
    echo "building file: $i"
    openscad -o ${i}.stl ${i}.scad
done

echo "rendering previews..."

openscad -o "assembly.png" --imgsize=1000,1000 --viewall "assembly.scad"
openscad -o "assembly_bottom.png" --imgsize=1000,1000 --camera 1200,400,-500,0,0,0 "assembly.scad"