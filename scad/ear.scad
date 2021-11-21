use <shapes_lib.scad>
use <tools_lib.scad>

$fn=100;
r=25; //chopstick radius
x=600;

difference() {
  union() {
    translate([0,0,0]) ear();
    translate([0,-150,0]) rotate([180,0,0])  ear();
  }
  translate([-1000,-1000,-80]) cube([2000,2000,80]);
}

module ear() {
  difference() {
    union() {
      rotate_extrude(angle = 45) translate([x,0,0]) circle(60);
      translate([x+50,0,-50]) rounded_cylinder(100,40,10);
      translate([x,0,0]) sphere(60);
      
      rotate(45) translate([x,0,0]) {
        translate([60,0,-50]) rounded_cylinder(100,40,10);
        sphere(60);
      }
    }
    #translate([x,-60,0]) rotate([270,0,0]) cylinder(400,r,r);

    #translate([x+50,0,-50]) screw8_hole();
    #rotate(45) translate([x+60,0,-50]) screw8_hole();
  }
}