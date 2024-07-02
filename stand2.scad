include <BOSL2/std.scad>
include <BOSL2/shapes2d.scad>

length=250;
height=100;
thick=10;
wide=10;
laptop=20;

const_angle = atan(height/length);
back_angle = atan(length/height);
echo(back_angle);

// sketch for the bracket
module main_shape() {

    zrot(90-back_angle) fwd(height)
    // the main hollowed out triangle frame
    difference() {
        // union() {
            // outer triangle shape
            right_triangle([length, height]);

            // right(length-wide/2)
            // difference() {
            //     square([wide,laptop+5], anchor=BACK);
            //     square([wide/2, laptop], anchor=BACK+RIGHT);
            // }
        // }

        // inner triangle hollow
        back(thick)
        right(thick)
        right_triangle([length-5*thick, (length-5*thick)*tan(const_angle)]);
    };

    intersection() {

                // middle support where the 2 parts cross
                zrot(90-back_angle) fwd(height)
                right_triangle([length, height]);
        
                // right(length/2)
                right(sqrt(height^2+length^2)/2)
                square([thick*3, height], anchor=BACK);

            }
}

module laptop_plane() {
    linear_extrude(height=length)
    right(sqrt(height^2+length^2)-thick)
    fwd(thick*cos(back_angle))
    zrot(90-back_angle)
    square([length, laptop], anchor=BACK+RIGHT);
    // #right_triangle([length, height]);
}

module laptop_plane2() {
    down(wide/2)
    left(sqrt(height^2+length^2)/2)
    zrot(90-back_angle) fwd(height)
    right_triangle([length, height]);
}

module foot() {
    union() {
        // difference() {
            cylinder(h=1.5, r=7, $fn=90);
            // pocket for silicon pad 12.7x1.5 mm
            // cylinder(h=1,r=6.5);
        // }

        up(1.5)
        cylinder(h=3.5, r1=7, r2=3.5, $fn=90);
    }
}

union() {
difference() {
    union() {
        up(wide/2)
        back(10)
        xrot(180)
        yrot(90+45)
        intersection() {
            yrot(45)
            down(wide/2)
            left(sqrt(height^2+length^2)/2)
            linear_extrude(height=wide)
            difference () {
                round2d(r=2.2)
                main_shape();

                right(sqrt(height^2+length^2)/2)
                square([thick+1, height/3.3], anchor=BACK);
            }

            down(length/2)
            linear_extrude(height=length)
            projection()
            linear_extrude(height=0.5)
            yrot(45)
            #laptop_plane2();
        }

        // rear foot
        right(length/3)
        up(7)
        back(10)
        xrot(-90)
        foot();

        // front foot
        left(length/2-25)
        up(7)
        back(10)
        xrot(-90)
        foot();
    }

    // pocket for silicon pad for rear foot
    right(length/3)
    up(7)
    back(10)
    xrot(-90)
    cylinder(h=1,r=6.5, $fn=90);


    // pocket for silicon pad for front foot
    left(length/2-25)
    up(7)
    back(10)
    xrot(-90)
    cylinder(h=1,r=6.5, $fn=90);
}

    linear_extrude(height=wide)
    left(120)
    zrot(const_angle)
    back(12.5)
    right(wide/2)
    difference() {
        square([wide,laptop+5], anchor=FRONT);
        square([wide/2, laptop+1], anchor=FRONT+LEFT);
    }
}

union() {
difference() {
    union() {
        up(wide/2)
        fwd(10)
        yrot(-135)
        intersection() {
            yrot(-45)
            down(wide/2)
            left(sqrt(height^2+length^2)/2)
            union() {
                linear_extrude(height=wide)
                difference() {
                    round2d(r=2)
                    main_shape();

                right(sqrt(height^2+length^2)/2)
                fwd(height/3.5)
                square([thick+1, height/3.3], anchor=BACK);
                }
            }

            down(length/2)
            linear_extrude(height=length)
            projection()
            linear_extrude(height=0.5)
            yrot(45)
            laptop_plane2();
        }

        // rear foot
        right(length/3)
        up(7)
        fwd(10)
        xrot(90)
        foot();

        // front foot
        left(length/2-25)
        up(7)
        fwd(10)
        xrot(90)
        foot();
    }

    // pocket for silicon pad for rear foot
    right(length/3)
    up(7)
    fwd(10)
    xrot(90)
    cylinder(h=1,r=6.5, $fn=90);

    // pocket for silicon pad for front foot
    left(length/2-25)
    up(7)
    fwd(10)
    xrot(90)
    cylinder(h=1,r=6.5, $fn=90);
}

    linear_extrude(height=wide)
    left(121)
    zrot(-const_angle)
    fwd(12.5)
    right(wide/2)
    difference() {
        square([wide,laptop+5], anchor=BACK);
        square([wide/2, laptop+1], anchor=BACK+LEFT);
    }
}