use <shapes_lib.scad>
use <tools_lib.scad>

r=25; //chopstick radius

240_base();
translate([0,-200,0]) 240_connector();


module 240_base() {
  difference() {
    union() {
      translate([-240,0,0]) edged_cube(320,70,60,10);
      translate([30,-60,0]) edged_cube(40,90,60,10);
      translate([30,-50,40]) rotate([0,90,0]) cylinder(40,40,40);
      
    }
    translate([-220,20,40]) cube([280,80,30]);
    translate([35,45,0]) screw8_hole();
    translate([-195,40,0]) screw8_hole();
    #translate([-10,-50,40]) rotate([0,90,0]) screw8_hole();

  }
}

module 240_connector() {
  difference() {
    union() {
      hull() {
        translate([-80,35,40]) rotate([90,0,0]) cylinder(70,40,40);
        translate([25,0,40]) rotate([0,90,0]) cylinder(40,40,40);
      }
     }
     translate([0,0,-1]) cylinder(80+2,r,r);
     translate([-120-1,-5,-1]) cube([120+1,10,80+2]);
     #translate([25,0,40]) rotate([0,90,0]) screw8_hole();
     #translate([-80,40,40]) rotate([90,0,0]) screw8_hole();
   }
}