use <shapes_lib.scad>
use <tools_lib.scad>

$fn=100;
r=25; //chopstick radius


difference() {
  nose();
  translate([25,300,40]) cube([200,140,60]);
}

difference() {
  translate([-400,-200,-40]) nose();
  translate([-375,100,-60]) cube([200,140,60]);
  translate([-450,-300,-60]) cube([400,400,150]);
}


module nose() {
  difference() {
    union() {
       hull() {
        translate([50,300,0]) edged_cube(40,50,80,10);
        translate([0,0,59]) rotate([0,70,0]) translate([0,0,-15]) rounded_cylinder(30,60,10);
      }
      hull() {
        translate([160,300,0]) edged_cube(40,50,80,10);
        translate([250,0,59]) rotate([0,110,0]) translate([0,0,-15]) rounded_cylinder(30,60,10);
      }
      hull() {
        translate([50,340,40]) rotate([0,90,0]) cylinder(150,40,40);
        translate([125,380,0]) cylinder(80,40,40);
      }
    }
    translate([40,340,40]) rotate([0,90,0]) cylinder(170,r,r);
    #translate([125,380,0]) screw8_hole();
    translate([25,363,35]) cube([200,60,10]);
  }
}

