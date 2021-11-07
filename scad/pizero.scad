use <shapes_lib.scad>
use <tools_lib.scad>

$fn=100;
r=25; //chopstick radius

//pizerow_connector();
pi0w_base();
 
module pi0w_base() {
  difference() {
    union() {
      rounded_base(650,300,20,35);

      translate([35,265,0]) cylinder(70,35,35);
      translate([615,265,0]) cylinder(70,35,35);
      
      hull() {
        translate([35,35,0]) cylinder(70,35,35);
        translate([0,-40,40]) rotate([0,90,0]) cylinder(70,40,40);
      }
      hull() {
        translate([615,35,0]) cylinder(70,35,35);
        translate([580,-40,40]) rotate([0,90,0]) cylinder(70,40,40);
      }
    }
    translate([-1,-40,40]) rotate([0,90,0]) cylinder(652,r,r);
    translate([-1,0,70]) cube([650+2,70,21]);
    translate([-1,-50,35]) cube([650+2,120,5]);

  #translate([35,35,0]) screw8_hole();
  #translate([615,35,0]) screw8_hole();
  #translate([35,265,0]) screw8_hole();
  #translate([615,265,0]) screw8_hole();
  }
 
  
 // translate([0,0,80]) rounded_base(80,160,20,35);
  
}

module pizerow_connector() {
  difference() {
    hull() {
      cylinder(80,50,50);
       translate([80,40,40]) rotate([90,0,0]) cylinder(80,40,40);
    }
  translate([0,0,-1]) cylinder(80+2,r,r);
  translate([0,-5,-1]) cube([120+1,10,80+2]);
  #translate([35,-50-1,-1]) cube([85+1,20+1,80+2]);
  #translate([70,40,40]) rotate([90,0,0]) screw8_hole();
  }
}
