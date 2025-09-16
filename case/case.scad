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
pcb_standoff_height = 5;
pcb_standoff_diam = 4.4;
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
                cyl(d=pcb_standoff_diam, l=pcb_standoff_height, anchor=BOTTOM);
            }
        };
        left(2*key_spacing + case_edge_thickness + pcb_case_gap) fwd(key_spacing + case_edge_thickness + pcb_case_gap)
        left(key_spacing * 4) fwd(key_spacing*2)
        position(BACK+RIGHT+BOTTOM)
        grid_copies(n=[2,2], spacing=[key_spacing*4, key_spacing*2])
        screw_hole(pcb_mount_screw, l=case_size[2], orient=DOWN, anchor=TOP, head="flat");
        // left(2*key_spacing + case_edge_thickness + pcb_case_gap) fwd(key_spacing + case_edge_thickness + pcb_case_gap)
        // left(key_spacing * 4) fwd(key_spacing*2)
        // position(BACK+RIGHT+BOTTOM)
        // grid_copies(n=[2,2], spacing=[key_spacing*4, key_spacing*2])
        // {
        //     up(case_bottom_thickness) cyl(d=pcb_standoff_diam, l=pcb_standoff_height, anchor=BOTTOM);
            // tag("remove") screw_hole(pcb_mount_screw, l=case_size[2], orient=DOWN, anchor=TOP, head="flat");
        // }
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

// case();
bat_standoff();
