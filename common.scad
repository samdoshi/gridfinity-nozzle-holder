include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
use <threads-scad/threads.scad>

$fn = $preview ? 16 : 64;

// define the dots patterns here
dots015 = [1, 0, 1, 0, 0, 0];
dots025 = [0, 0, 0, 0, 0, 0];
dots03 =  [1, 0, 0, 0, 0, 0];
dots035 = [1, 1, 0, 0, 0, 0];
dots04 =  [1, 1, 1, 0, 0, 0];
dots05 =  [1, 1, 1, 1, 1, 1];
dots06 =  [1, 1, 1, 1, 0, 0];
dots08 =  [1, 1, 1, 1, 1, 0];

// gridfinity-rebuilt-openscad requires these
enable_scoop = true;
enable_zsnap = true;
enable_lip = true;
height_internal = 0;
length = 42;

// at what height doe the base end (shouldn't need to change this)
base_depth = 5;

module Dots(x, y, d) {
    translate([x, y, base_depth + thread_depth]) {
        for (i = [0:5]) {
            if (d[i]) {
                angle = i * 360 / 6;
                rotate(a=angle, v=[0, 0, -1]) translate([0, 5, -1]) cylinder(r=0.8, h=2);
            }
        }
    }
}

module Text(x, y, t) {
    translate([x, y, base_depth + thread_depth - 1]) 
        linear_extrude(3)
        text(t, font = "Liberation Sans", size=3.75, valign="center", halign="center");
}

module Hole(x, y, d) {
    translate([x, y, base_depth + 0.2]) {
        InverseScrewHole(6, height(z_size));
    }
    Dots(x, y, d);
}

module InverseScrewHole(outer_diam, height, pitch=0, tooth_angle=30, tolerance=0.4, tooth_height=0) {
  extra_height = 0.001 * height;
  union() {
      translate([0, 0, -extra_height/2])
      ScrewThread(1.01*outer_diam + 1.25*tolerance, height + extra_height,
        pitch, tooth_angle, tolerance, tooth_height=tooth_height);
  }
}
