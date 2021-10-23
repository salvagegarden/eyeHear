
screw8_hole();

translate([0,100,0]) screw8();

translate([100,0,0]) screw4_hole();

translate([100,100,0]) screw4();


module screw8_hole() {
  // screw protrudes 5 clearance
  union() {
    translate([ 0,0,-5]) cylinder(75,12,12);
    translate([0,0,40]) cylinder(40,14,14);
    translate([0,0,80]) cylinder(100,24,24);
  }
}

module screw4_hole() {
  // screw protrudes 5 clearance
  union() {
    translate([ 0,0,-5]) cylinder(35,11,11);
    translate([0,0,30]) cylinder(10,14,14);
    translate([0,0,40]) cylinder(60,24,24);
  }
}


module screw4() {
  color("Silver") {
    difference() {
      union() {
        cylinder(40,13,13);
        translate([0,0,40]) cylinder(20,23,23);
      }
    translate([-15,-3,55]) cube([30,6,6]);
    translate([-3,-15,55]) cube([6,30,6]);
    }
  }
}

module screw8() {
  color("Silver") {
    difference() {
      union() {
        cylinder(80,13,13);
        translate([0,0,80]) cylinder(20,23,23);
      }
    translate([-15,-3,95]) cube([30,6,6]);
    translate([-3,-15,95]) cube([6,30,6]);
    }
  }
}