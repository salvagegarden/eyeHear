use <shapes_lib.scad>
use <tools_lib.scad>

r=25; //chopstick radius

//i2smic();
//translate([200,0,0]) rpi0w();
//translate([-300,0,0]) oled96();
240ips();

module 240ips() {
  difference() {
    union() {
      color("royalblue") cube([390,280,15]);
      color("black") translate([45,10,15]) cube([300,260,20]);
      color("silver") translate([0,40,15]) cube([30,180,10]);
      color("black") translate([0,40,-50]) cube([390,180,50]);
      #translate([50,15,35]) cube([250,250,11]);
    }
    //translate([25,25,-1]) cylinder(17, 11,11);
    //translate([365,25,-1]) cylinder(17, 11,11);
    //translate([25,255,-1]) cylinder(17, 11,11);
    //translate([365,255,-1]) cylinder(17, 11,11);
  }
}







module i2smic() {
  union() {
    color("royalblue") cube([162,112,10]);
    color("silver") translate([23+58-25, 0, -20]) cube([50,50,20]);
    #translate([23,       25,-40]) screw8_hole();
    #translate([23+116,   25,-40]) screw8_hole();
  }
}





module rpi0w() {
    difference() {
        union() {
            color("MediumSeaGreen") cube([650,300,15]);
            translate([40,40,0])  color("Khaki") cylinder(15, 30,30);
            translate([610,40,0])  color("Khaki") cylinder(15, 30,30);
            translate([610,260,0])  color("Khaki") cylinder(15, 30,30);
            translate([40,260,0])  color("Khaki") cylinder(15, 30,30);
            translate([370,-20,15]) color("silver") cube ([80,60,30]);
            translate([500,-20,15]) color("silver") cube ([80,60,30]);
            translate([20,100,15]) color("silver") cube ([110,120,15]);
        }
        translate([40,40,0]) cylinder(15, 14,14);
        translate([610,40,0]) cylinder(15, 14,14);
        translate([610,260,0]) cylinder(15, 14,14);
        translate([40,260,0]) cylinder(15, 14,14);
    }
}



module oled96() {
  difference() {
  union() {
    color ("royalblue") rounded_cube(272,274,10,0,10);
    color("black") translate([2,70,10]) cube([268,156,15]);
    color("dimgrey") translate([57,40,10]) cube([160,30,10]);
    color("grey") translate([87,0,10]) cube([100,40,5]);
  }

  translate([30,20,-1]) cylinder(12,10,10);
  translate([242,20,-1]) cylinder(12,10,10);

  translate([30,254,-1]) cylinder(12,10,10);
  translate([242,254,-1]) cylinder(12,10,10);
  }
}