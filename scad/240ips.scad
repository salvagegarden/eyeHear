use <shapes_lib.scad>
use <tools_lib.scad>
use <components_lib.scad>

$fn=100;
r=25; //chopstick radius

240_base();
translate([0,-200,0]) 240_connector();


module 240_base() {
  difference() {
    union() {
      translate([0,0,0]) edged_cube(435,320,60,10);
      // Top connector
      translate([30,-60,0]) edged_cube(60,90,60,10);
      translate([30,-50,40]) rotate([0,90,0]) cylinder(60,40,40);
      // bottom connector
      translate([345,-60,0]) edged_cube(60,90,60,10);
      translate([345,-50,40]) rotate([0,90,0]) cylinder(60,40,40);
    }
    // cut out
    translate([70,70,0]) cube([345,180,60]);
    translate([80,20,0]) cube([275,280,60]);
    translate([20,80,0]) rotate([180,0,90]) i2smic();

    translate([20,20,40]) cube([395,280,30]);
    #translate([50,45,0]) screw8_hole();
    #translate([385,45,0]) screw8_hole();
    #translate([50,275,0]) screw8_hole();
    #translate([385,275,0]) screw8_hole();
    
    #translate([130,-50,40]) rotate([0,270,0]) screw8_hole();
    #translate([305,-50,40]) rotate([0,90,0]) screw8_hole();
  }
}

module 240_connector() {
  difference() {
    union() {
      hull() {
        translate([160,35,40]) rotate([90,0,0]) cylinder(70,40,40);
        translate([230,35,40]) rotate([90,0,0]) cylinder(70,40,40);
        translate([90,0,40]) rotate([0,90,0]) cylinder(255,40,40);
      }
    }
    translate([170,0,-1]) cylinder(80+2,r,r);
    translate([170-1,-5,-1]) cube([100,10,80+2]);
    #translate([130,0,40]) rotate([0,270,0]) screw8_hole();
    #translate([305,0,40]) rotate([0,90,0]) screw8_hole();
    #translate([230,40,40]) rotate([90,0,0]) screw8_hole();
   }
}