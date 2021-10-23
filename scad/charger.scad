use <shapes_lib.scad>
use <tools_lib.scad>

r=25; //chopstick radius

charger();

module charger() {
  difference() {
    union() {
      edged_cube(370,280,35,10);
    }
    translate([20,20,20]) cube([330,240,15]);
    translate([45,20,-10]) edged_cube(130,30,40,10);
    translate([50,250,-10]) edged_cube(120,50,60,10);
    translate([240,230,-10]) edged_cube(110,30,60,10);
    
  translate([100,140,-1]) cylinder(20+2,70,70);
  translate([270,140,-1]) cylinder(20+2,70,70);
  }
}  

