
rounded_cube(100,200,30,10,30);
%cube([100,200,30]);

translate([200,0,0]) rounded_cylinder(100, 40, 10);
%translate([200,0,0]) cylinder(100, 40, 40);

translate([300,0,0]) edged_cube(100, 200, 50,10);
%translate([300,0,0]) cube([100, 200, 50]);


module rounded_hole(h=100, r=50, c=10) {
  difference() {
    union() {
      translate([0,0,0]) cylinder(c, r+c, r+c);
      translate([0,0,0]) cylinder(h, r, r);
      translate([0,0,h-c]) cylinder(c, r+c, r+c);
    }
    rotate_extrude() translate([r+c, c, 0]) circle(c);
    rotate_extrude() translate([r+c, h-c, 0]) circle(c);
  }
}

module rounded_cylinder(h, r, c) {
  // h = heigth
  // r = radius
  // c = corner radius
  
  union() {
    rotate_extrude() translate([r-c, c, 0]) circle(r = c);
    rotate_extrude() translate([r-c, h-c, 0]) circle(r = c);
    translate([0,0,c]) cylinder(h-2*c, r, r);
    cylinder(h, r-c, r-c);
  }
}

module rounded_base(x,y,z,cr) {
  hull() {
    translate([   cr,   cr, 0 ]) cylinder( z, cr, cr );
    translate([ x-cr,   cr, 0 ]) cylinder( z, cr, cr );
    translate([   cr, y-cr, 0 ]) cylinder( z, cr, cr );
    translate([ x-cr, y-cr, 0 ]) cylinder( z, cr, cr );
  }
}

module edged_cube(x,y,z,er) {
  if (z>=2*er) {
    hull() {
      // bottom spheres
      translate([ er,   er,   er ]) sphere( er );
      translate([ x-er, er,   er ]) sphere( er );
      translate([ er,   y-er, er ]) sphere( er );
      translate([ x-er, y-er, er ]) sphere( er );

      // top spheres
      translate([ er,   er  , z-er ]) sphere( er );
      translate([ x-er, er  , z-er ]) sphere( er );
      translate([ er,   y-er, z-er ]) sphere( er );
      translate([ x-er, y-er, z-er ]) sphere( er );
    }
  } else {
    echo (" z ! >= 2 * er ");
  }
}


module rounded_cube(x,y,z,er,cr) {
  // er = edge radius
  // cr = corner radius
  // er must be smaller than cr

  // X bottom
  rotate([0,90,0]) translate([-er,er,cr+er]) cylinder(x-2*cr-2*er,er,er);
  rotate([0,90,0]) translate([-z+er,er,cr+er]) cylinder(x-2*cr-2*er,er,er);
  // X top
  rotate([0,90,0]) translate([-er,y-er,cr+er]) cylinder(x-2*cr-2*er,er,er);
  rotate([0,90,0]) translate([-z+er,y-er,cr+er]) cylinder(x-2*cr-2*er,er,er);
  // Y left
  rotate([-90,0,0]) translate([er,-er,cr+er]) cylinder(y-2*cr-2*er,er,er);
  rotate([-90,0,0]) translate([er,-z+er,cr+er]) cylinder(y-2*cr-2*er,er,er);
  // Y right
  rotate([-90,0,0]) translate([x-er,-er,cr+er]) cylinder(y-2*cr-2*er,er,er);
  rotate([-90,0,0]) translate([x-er,-z+er,cr+er]) cylinder(y-2*cr-2*er,er,er);
  
  // corner donut
  // bottom left
  translate([cr+er,cr+er,er]) rotate_extrude() translate([cr,0,0]) circle(er);
  translate([cr+er,cr+er,z-er]) rotate_extrude() translate([cr,0,0]) circle(er);
  // top left
  translate([cr+er,y-cr-er,er]) rotate_extrude() translate([cr,0,0]) circle(er);
  translate([cr+er,y-cr-er,z-er]) rotate_extrude() translate([cr,0,0]) circle(er);
  // bottom right
  translate([x-cr-er,cr+er,er]) rotate_extrude() translate([cr,0,0]) circle(er);
  translate([x-cr-er,cr+er,z-er]) rotate_extrude() translate([cr,0,0]) circle(er);
  // top right
  translate([x-cr-er,y-cr-er,er]) rotate_extrude() translate([cr,0,0]) circle(er);
  translate([x-cr-er,y-cr-er,z-er]) rotate_extrude() translate([cr,0,0]) circle(er);
  
  // corner cylinder
  // bottom left
  translate([cr+er,cr+er,er]) cylinder(z-2*er,cr+er,cr+er);
  translate([cr+er,cr+er,0]) cylinder(z,cr,cr);
  // top left
  translate([cr+er,y-cr-er,er]) cylinder(z-2*er,cr+er,cr+er);
  translate([cr+er,y-cr-er,0]) cylinder(z,cr,cr);
  // bottom right
  translate([x-cr-er,cr+er,er]) cylinder(z-2*er,cr+er,cr+er);
  translate([x-cr-er,cr+er,0]) cylinder(z,cr,cr);
  // top right
  translate([x-cr-er,y-cr-er,er]) cylinder(z-2*er,cr+er,cr+er);
  translate([x-cr-er,y-cr-er,0]) cylinder(z,cr,cr);
  
  // center cube
  translate([cr+er,0,er]) cube([x-2*cr-2*er,y,z-2*er]);
  translate([0,cr+er,er]) cube([x,y-2*cr-2*er,z-2*er]);
  translate([er,cr+er,0]) cube([x-2*er,y-2*cr-2*er,z]);
  translate([cr+er,er,0]) cube([x-2*cr-2*er,y-2*er,z]);
}