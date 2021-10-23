use <shapes_lib.scad>
use <tools_lib.scad>

r=25; //chopstick radius


difference() {
  union() {
    round_3way();
    translate([300,400,80]) rotate([180,0,0]) round_3way();
    translate([300,500,0]) round_2way();
    translate([-100,700,80]) rotate([180,0,0]) round_2way();
  }
  translate([-400,-100,40]) cube([1000,1000,40]);
}


module round_2way() {
  difference() {
    union() {
      translate([-200,0,40])
        rotate_extrude(angle = 90) translate([200,0,0]) circle(60);
      translate([40,40,0]) rounded_cylinder(80,40,10);
      translate([-160,240,0]) rounded_cylinder(80,40,10);
    }
    translate([0,0,40]) rotate([270,0,0]) cylinder(200,r,r);
    translate([0,200,40]) rotate([0,270,0]) cylinder(200,r,r);

    translate([-220,-20,-20]) cube([300,300,20]);

    #translate([-60,140,0]) screw8_hole();
    #translate([40,40,0]) screw8_hole();
    #translate([-160,240,0]) screw8_hole();
    translate([-220,-20,-20]) cube([300,300,20]);
    translate([-220,-20,80]) cube([300,300,20]);
    translate([-220,-20,38]) cube([320,320,4]);
  }
}



module round_3way() {
  difference() {
    union() {
      translate([-200,0,40])
        rotate_extrude(angle = 90) translate([200,0,0]) circle(60);
      translate([-200,400,40])
        rotate_extrude(angle = -90) translate([200,0,0]) circle(60);
      translate([40,40,0]) rounded_cylinder(80,40,10);
      translate([40,360,0]) rounded_cylinder(80,40,10);
      translate([0,400,40]) sphere(60);
      translate([0,0,40]) sphere(60);
      translate([-200,200,40]) sphere(60);
    }

    translate([0,-61,40]) rotate([270,0,0]) cylinder(520+2,r,r);
    translate([0,200,40]) rotate([0,270,0]) cylinder(260+1,r,r);
    #translate([-60,140,0]) screw8_hole();
    #translate([-60,260,0]) screw8_hole();
    #translate([40,40,0]) screw8_hole();
    #translate([40,360,0]) screw8_hole();
    translate([-280,-70,-20]) cube([380,550,20]);
    translate([-280,-70,80]) cube([380,550,20]);
    translate([-280,-70,38]) cube([380,550,4]);
  }
}