use <shapes_lib.scad>
use <tools_lib.scad>

$fn=100;
r=25; //chopstick radius

//pizerow_connector();
//pi0w_base();


difference() {
  pi0w2_base();
  translate([-1,-1,50]) cube([760,460,60]);
}

difference() {
  translate([0,500,-50]) pi0w2_base();
  translate([-1,480,-60]) cube([760,460,60]);
}


module pi0w2_base() {
  difference() {
    union() {
      hull() {
        edged_cube(70+50, 300+60, 100,20);
        translate([0,380,50]) rotate([0,90,0]) rounded_cylinder(70+50,50,20);
      }
      hull() {
        translate([635,0,0]) edged_cube(70+50, 300+60, 100,20);
        translate([635,380,50]) rotate([0,90,0]) rounded_cylinder(70+50,50,20);
      }
      translate([30,30,0]) cube([655,300,30]);
    }
    translate([50,30,0]) pi_screws();
    translate([-1,380,50]) rotate([0,90,0]) cylinder(655+100+2,r,r);
    translate([50,30,35]) rounded_base(655,300,15,35);
    translate([50,30,25]) board_cutout(655,300,10,35);
    translate([30,25+70,50]) cube([71+20,170,50+1]);
    translate([615-1,25+70,50]) cube([71+30,170,50+1]);
    translate([120,260,15]) cube([655-140,71,20]);
  }
}
 
module pi0w_base() {
  difference() {
    union() {
      rounded_base(655,300,20,35);

      translate([35,265,0]) cylinder(70,35,35);
      translate([620,265,0]) cylinder(70,35,35);
      
      translate([35,35,0]) cylinder(70,35,35);
      translate([620,35,0]) cylinder(70,35,35);
    }
  }
}


module pi_screws() {
  union() {
    translate([ 35, 35,0]) screw8_hole();
    translate([620, 35,0]) screw8_hole();
    translate([ 35,265,0]) screw8_hole();
    translate([620,265,0]) screw8_hole();
  }
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
