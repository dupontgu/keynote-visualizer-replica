files=(
    "keynote_dxf_clef_holes_single_screw_bottom"
    "keynote_dxf_clef_holes_single_screw_top"
    "keynote_dxf_clef_slits_top"
    "keynote_dxf_clef_slits_bottom"
    "led_holder_v11"
)

for i in "${files[@]}"
do
    echo "building file: $i"
    openscad -o ${i}.stl ${i}.scad
done

echo "rendering previews..."

openscad -o "assembly.png" --imgsize=1000,1000 --viewall "assembly.scad"
openscad -o "assembly_bottom.png" --imgsize=1000,1000 --camera -500,-1000,-1000,0,0,0 --viewall "assembly.scad"