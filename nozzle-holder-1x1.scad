include <common.scad>

// how many gridfinity units should the box be?
x_size = 1;
y_size = 1;
z_size = 3;

// thread depth (i.e. how deep interior of the box)
thread_depth = 7.5;

// hole grid
hole_grid_x = (x_size * length - 2 * 3.2) / 3;

difference () {
    union () {
        gridfinityInit(x_size, y_size, height(z_size), thread_depth, length);
        gridfinityBase(x_size, y_size, length, 0, 0, 1);
    }

    Hole(-1 * hole_grid_x, -9.5, dots025);
    Text(-1 * hole_grid_x, 0, "0.25");
    Hole(-1 * hole_grid_x, 9.5, dots025);

    Hole(0 * hole_grid_x, -9.5, dots04);
    Text(0 * hole_grid_x, 0, "0.4");
    Hole(0 * hole_grid_x, 9.5, dots04);

    Hole(1 * hole_grid_x, -9.5, dots06);
    Text(1 * hole_grid_x, 0, "0.6");
    Hole(1 * hole_grid_x, 9.5, dots06);

    // text and dots test (remove * to enable)
    * union() {
        translate([-50, -50, base_depth + thread_depth + 1]) cube([100, 100, 100]);
        translate([-50, -50, base_depth + thread_depth - 2 - 100]) cube([100, 100, 100]);
    }
}

