use <shapes_lib.scad>
use <tools_lib.scad>

r=25; //chopstick radius

10400_holder();
translate([0,200,0]) 10400_holder();

module 10400_holder() {
  difference() {
    union() {
      hull() {
        translate([-50,35,40]) rotate([90,0,0]) cylinder(70,40,40);
        translate([90,0,0]) rounded_cylinder(140,80,10);
      }
     }
     translate([0,0,-1]) cylinder(160,r,r);
     #translate([-50,25,40]) rotate([90,0,0]) screw4_hole();
     translate([-90-1,-5,-1]) cube([72,10,120+2]);
     translate([20,-10,-1]) cube([32,20,150]);
     translate([90,0,30]) cylinder(120,51,51);
   }
 }
 