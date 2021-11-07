use <shapes_lib.scad>
use <tools_lib.scad>

$fn=100;
r=25; //chopstick radius

difference() {
  union() {
    battery_charger();
    translate([0,-200,160]) rotate([180,0,0]) battery_charger();
  }
  translate([-10,-600,79]) cube([600,1000,90]);
}


//translate([0,500,0])  battery_charger();



module battery_charger() {
  difference() {
    hull() {
      translate([0,240,80]) rotate([0,90,0]) rounded_cylinder(480+40,80,10);
      translate([0,0,80]) rotate([0,90,0]) rounded_cylinder(480+40,80,10);
    }
    translate([-1,0,80]) rotate([0,90,0]) cylinder(480+40+2,r,r);
    translate([20,240,80]) rotate([0,90,0]) cylinder(480,55,55);
    #translate([10,50,50-2]) cube([55,130,60+4]); // switch
    translate([-1,70,60]) cube([12,90,40]); // knob
    translate([60,65,50]) cube([40,100,60]); // switch connector
    translate([150,0,80+1]) cube([130,30,80]); //cable space
   # translate([150,25,80]) cube([130,30,30]); //cable space
   # translate([65,50,80]) cube([430,30,30]); //cable space
   # translate([420,50,80]) cube([80,150,30]); //cable space
    translate([20,0,70]) cube([80,200,20]); // power cable space
    translate([340,205,101]) cube([110,30,60]); //cable space
    translate([340,170,100]) cube([110,40,40]); //cable space
    #translate([380,120,120]) rotate([180,0,0]) screw8_hole();
    #translate([140,120,120]) rotate([180,0,0])  screw8_hole();
  }

}  