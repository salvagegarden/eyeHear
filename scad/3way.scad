use <shapes_lib.scad>
use <tools_lib.scad>

$fn=100;
r=25; //chopstick radius

difference() {
  union() {
    translate([0,0,-40]) round_3way();
    translate([0,-150,40]) rotate([180,0,0]) round_3way();
    translate([300,0,-40]) round_2way();
    translate([300,-150,40]) rotate([180,0,0])  round_2way();
  }
  translate([-1000,-1000,-80]) cube([2000,2000,80]);
}


module round_2way() {
  difference() {
    union() {
      translate([-200,0,40])
      rotate_extrude(angle = 90) translate([200,0,0]) circle(60);
      translate([40,40,-10]) rounded_cylinder(100,40,10);
      translate([-160,240,-10]) rounded_cylinder(100,40,10);
      translate([-200,200,40]) sphere(60);
      translate([0,0,40]) sphere(60);
    }
    translate([0,-60,40]) rotate([270,0,0]) cylinder(260,r,r);
    translate([0,200,40]) rotate([0,270,0]) cylinder(260,r,r);

    #translate([-60,140,0]) screw8_hole();
    #translate([40,40,0]) screw8_hole();
    #translate([-160,240,0]) screw8_hole();
  }
}



module round_3way() {
  difference() {
    union() {
      translate([-200,0,40]) rotate_extrude(angle = 90) translate([200,0,0]) circle(60);
      translate([-200,400,40]) rotate_extrude(angle = -90) translate([200,0,0]) circle(60);
      translate([40,360,-10]) rounded_cylinder(100,40,10);
      translate([0,400,40]) sphere(60);
      translate([40,40,-10]) rounded_cylinder(100,40,10);
      translate([0,0,40]) sphere(60);
      translate([-200,200,40]) sphere(60);
    }

    translate([0,-61,40]) rotate([270,0,0]) cylinder(520+2,r,r);
    translate([0,200,40]) rotate([0,270,0]) cylinder(260+1,r,r);
    #translate([-60,140,0]) screw8_hole();
    #translate([-60,260,0]) screw8_hole();
    #translate([40,40,0]) screw8_hole();
    #translate([40,360,0]) screw8_hole();
  }
}