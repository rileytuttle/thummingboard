include <openscad-library-manager/BOSL2/std.scad>
include <openscad-library-manager/BOSL2/screws.scad>

$fn=50;

pcb_height_5_row = 60;
pcb_height_4_row = 47;
pcb_width_12_col = 144;
pcb_width_11_col = 131;
pcb_width_10_col = 119;

rows = 5; // [4, 5]
cols = 12; // [10, 11, 12]

// todo set up key value pairs to set up the different robot sizes. for now just assuming 5x12
pcb_size = [pcb_width_12_col, pcb_height_5_row];
pcb_case_gap = 1;
case_edge_thickness = 2;
case_bottom_thickness = 2;
case_size_xy = [pcb_size[0]+pcb_case_gap*2 + case_edge_thickness*2 , pcb_size[1]+pcb_case_gap*2 + case_edge_thickness*2];
// pcb case bottom to pcb bottom standoff.
pcb_standoff_height = 6;
pcb_standoff_diam = 5.5;
pcb_mount_screw = "M2";
pcb_thickness=1.6;
top_switch_thickness = 4;

case_size = [case_size_xy[0], case_size_xy[1], case_bottom_thickness+pcb_standoff_height+pcb_thickness+top_switch_thickness];
key_spacing = 12;

module case()
{
    diff()
    cuboid(case_size, teardrop=true, rounding=3, except = TOP)
    {
        position(TOP) up(0.1)tag_diff("remove", "rm", "kp") cuboid([pcb_size[0]+pcb_case_gap*2, pcb_size[1]+pcb_case_gap*2, case_size[2]-case_bottom_thickness+0.1], rounding = 3, except=[TOP, BOTTOM], anchor=TOP)
        {
            left(2*key_spacing + pcb_case_gap) fwd(key_spacing + pcb_case_gap)
            left(key_spacing * 4) fwd(key_spacing*2)
            position(BACK+RIGHT+BOTTOM)
            grid_copies(n=[2,2], spacing=[key_spacing*4, key_spacing*2])
            {
                tag("rm")
                cyl(d=pcb_standoff_diam, l=pcb_standoff_height, anchor=BOTTOM, chamfer1=-1.5);
            }
            tag("rm") position(BOTTOM+LEFT) right(3*key_spacing/2+pcb_case_gap)
            xcopies(n=2, l=key_spacing)
            cuboid([3, key_spacing*5, pcb_standoff_height], anchor=BOTTOM, rounding=1, except=[TOP, BOTTOM]);
        };
        left(2*key_spacing + case_edge_thickness + pcb_case_gap) fwd(key_spacing + case_edge_thickness + pcb_case_gap)
        left(key_spacing * 4) fwd(key_spacing*2)
        position(BACK+RIGHT+BOTTOM)
        grid_copies(n=[2,2], spacing=[key_spacing*4, key_spacing*2])
        screw_hole(pcb_mount_screw, l=case_size[2], anchor=BOTTOM) position(BOTTOM) nut_trap_inline(6, anchor=BOTTOM);
        position(BOTTOM+RIGHT+FRONT) back(case_edge_thickness+pcb_case_gap+18) up(4.5) tag("remove") right(0.05) cuboid([10+0.1, 15, 6], anchor=LEFT, rounding=2, except=[LEFT], teardrop=true, orient=DOWN);
        tag("remove") position(BOTTOM+RIGHT+FRONT) back(24+case_edge_thickness+pcb_case_gap) left(108+case_edge_thickness+pcb_case_gap) ycopies(n=3, spacing=key_spacing) cyl(d=5, l=case_bottom_thickness+0.01, anchor=BOTTOM, chamfer=-0.5);
        tag("remove") position(BOTTOM+RIGHT+FRONT) back(36+case_edge_thickness+pcb_case_gap) right(0.005) up(case_bottom_thickness+pcb_standoff_height+5/2) cuboid([case_edge_thickness+0.01+7, 15, 5+10], rounding=2, except=RIGHT, anchor=RIGHT+TOP);
        tag("remove") position(BOTTOM+RIGHT+FRONT) up(case_bottom_thickness/2) back(36+case_edge_thickness+pcb_case_gap) left(key_spacing+pcb_case_gap+case_edge_thickness) cyl(d=3.5, l=case_bottom_thickness+0.1);
    }
}

module bat_standoff()
{
    diff() {
        cuboid([35, 14, 1+3], rounding=2, except=[TOP,BOTTOM]) {
            position(TOP) xcopies(n=2, l=12) cyl(d=1.5, l=pcb_thickness+3, anchor=BOTTOM);
            tag("remove") position(TOP+RIGHT) down(1) cuboid([34, 12, 3], anchor=TOP+RIGHT, rounding = 2, except=[TOP,BOTTOM, RIGHT]);
        }
    }
}

module flex_switch_cutout(spin=0, distfromcenter=5)
{
    thickness = 10;
    diam=7;
    cut_thickness=1;
    leg_thickness=4;
    attachable(spin=spin) {
        left(distfromcenter)
        difference() {
            cuboid([distfromcenter, leg_thickness+cut_thickness, thickness], anchor=LEFT)
            position(RIGHT) cyl(d=diam+cut_thickness, l=thickness);
            cuboid([distfromcenter, leg_thickness, thickness+0.1], anchor=LEFT)
            position(RIGHT) cyl(d=diam, l=thickness+0.1);
        }
        children();
    }
}

module top()
{
    top_thickness = 0.75;
    leg=7;
    legend = [
        [
            ["E", "Shibuya Zero"],
            ["1", "Shibuya Zero"],
            ["2", "Shibuya Zero"],
            ["3", "Shibuya Zero"],
            ["4", "Shibuya Zero"],
            ["5", "Shibuya Zero"],
            ["6", "Shibuya Zero"],
            ["7", "Shibuya Zero"],
            ["8", "Shibuya Zero"],
            ["9", "Shibuya Zero"],
            ["0", "Shibuya Zero"],
            ["B", "Shibuya Zero"]],
        [
            ["T", "Shibuya Zero"],
            ["q", "Shibuya Zero"],
            ["w", "Shibuya Zero"],
            ["e", "Shibuya Zero"],
            ["r", "Shibuya Zero"],
            ["t", "Shibuya Zero"],
            ["y", "Shibuya Zero"],
            ["u", "Shibuya Zero"],
            ["i", "Shibuya Zero"],
            ["o", "Shibuya Zero"],
            ["p", "Shibuya Zero"],
            ["\\", "DejaVu Sans"]],
        [
            ["C", "Shibuya Zero"],
            ["a", "Shibuya Zero"],
            ["s", "Shibuya Zero"],
            ["d", "Shibuya Zero"],
            ["f", "Shibuya Zero"],
            ["g", "Shibuya Zero"],
            ["h", "Shibuya Zero"],
            ["j", "Shibuya Zero"],
            ["k", "Shibuya Zero"],
            ["l", "Shibuya Zero"],
            [";", "Shibuya Zero"],
            ["R", "Shibuya Zero"]],
        [
            ["S", "Shibuya Zero"],
            ["z", "Shibuya Zero"],
            ["x", "Shibuya Zero"],
            ["c", "Shibuya Zero"],
            ["v", "Shibuya Zero"],
            ["b", "Shibuya Zero"],
            ["n", "Shibuya Zero"],
            ["m", "Shibuya Zero"],
            [",", "Shibuya Zero"],
            [".", "Shibuya Zero"],
            ["/", "DejaVu Sans"],
            ["S", "Shibuya Zero"]],
        [
            ["C", "Shibuya Zero"],
            ["B", "Shibuya Zero"],
            ["A", "Shibuya Zero"],
            ["G", "Shibuya Zero"],
            ["U", "Shibuya Zero"],
            ["M", "Shibuya Zero"],
            ["_", "DejaVu Sans"],
            ["D", "Shibuya Zero"],
            ["←", "DejaVu Sans"],
            ["↓", "DejaVu Sans"],
            ["↑", "DejaVu Sans"],
            ["→", "DejaVu Sans"]]
    ];
    diff()
    {
        cuboid(concat(pcb_size, top_thickness), rounding=3, except=[TOP,BOTTOM]) {
            tag("remove") grid_copies(n=[cols, rows], spacing=[key_spacing,key_spacing])
            flex_switch_cutout(spin=$col % 2 == 0 ? 170 : -10, distfromcenter=leg);
            position(TOP) tag("remove")
            for (j=[0:4])
            {
                for (i=[0:11])
                {
                    down(0.21) back(2 * key_spacing) fwd(j*key_spacing)
                    left(5.5 * key_spacing) right(i*key_spacing) text3d(text=legend[j][i][0], size=3.5, font=legend[j][i][1], anchor=TOP, center=true, h=2);
                }
            }
            position(BOTTOM+FRONT) back(24) grid_copies(n=[2, 2], spacing=[key_spacing*4, key_spacing*2]) cyl(d=6, l=4, anchor=TOP);
            tag("remove") position(TOP+FRONT) back(24) grid_copies(n=[2,2], spacing=[key_spacing*4, key_spacing*2]) screw_hole(pcb_mount_screw, l=4+top_thickness, anchor=TOP, head="flat", counterbore=0.5);
        }
    }
}

module top_paint_stencil()
{
    diff() {
        cuboid([pcb_size[0]+10, pcb_size[1]+10, 1]) {
            tag("remove") grid_copies(n=[cols, rows], spacing=[key_spacing,key_spacing])
            cyl(d=7, l=1+1);
            fwd(key_spacing/2) tag("remove") grid_copies(n=[2,2], spacing=[key_spacing*4, key_spacing*2]) cyl(d=8, l=1+1);
        }
    }
}

// case();
// bat_standoff();
// top();
// down(5)
top_paint_stencil();
// flex_switch_cutout();
// text("The Quick Brown Fox Jumps Over the Lazy Dog", font="Pervitina Dex", size=20);
