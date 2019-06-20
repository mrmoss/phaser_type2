$fn=100;

//Used to generate handle (difference doesn't work with openscad - use occ-csg instead)
module gen_handle()
{
	size=[47.91140127,190.76215172,57.58443403];
	cube_bounds=2;
	cube_size=[size[0],107,size[2]]+[cube_bounds*2,0,cube_bounds*2];
	translate([-size[0]/2,0,-size[2]/2])
	{
		//difference()
		{
			import("phaser_zeroed.stl");
			//translate([-cube_bounds,-cube_bounds,-cube_bounds])
				//cube(cube_size);
		}
	}
}

//Mid and tip generation (no hole)
module gen_mid_and_tip()
{
	union()
	{
		tip_size=[29.73414612,21,29.86725426];
		height=100;
		hole_d=6.5;
		difference()
		{
			union()
			{
				translate([0,tip_size[2]/2+0.5,tip_size[1]/2])
					rotate([-90,0,180])
						translate(-tip_size/2)
							import("tip_zeroed.stl");
				translate([0,61.86725,-1.1825])
					import("phaser_typ2_b.stl");
				translate([-10,100.867225,0])
					cube([20,5,20]);
			}
			translate([0,height,12])
				rotate([90,0,0])
					cylinder(d=hole_d,h=height);
		}
	}
}

//Handle and grip
module gen_handle_and_grip()
{
	translate([-12,30,80.8948])
		cube([24,20,4]);
	handle_size=[30,51.6098,84.8949];
	translate([-handle_size[0]/2,0,0])
		import("handle_zeroed.stl");
	grip_size=[23,22.5411,58.7153];
	translate([-grip_size[0]/2,8.5,14.2])
		rotate([-2.6,0,0])
			scale([1,1,1.05])
				import("grip_zeroed.stl");
}

module gen_cover()
{
	difference()
	{
		union()
		{
			scale([1.01,1.01,0.96])
			{
				front_buttons_size=[28.1493,12.05,7.93898];
				translate([-front_buttons_size[0]/2,3.8,14.585])
					import("front_buttons.stl");
			}
			import("phaser_typ2_c.stl");
		}
		translate([0,-2,3])
			rotate([-90,0,0])
				cylinder(d=20,h=38);
	}
}

module gen_fire_button()
{
	translate([0,87,17])
	{
		fire_size=[21.3656,10.05,6.09283];
		scale([0.98,0.97,1.2])
			translate([-fire_size[0]/2,0,0])
				import("fire_button.stl");
		translate([-24/2,-1,0])
			cube([24,12,1.2]);
	}
}

import("handle_and_grip.stl");
import("mid_and_tip.stl");
import("cover.stl");
import("button.stl");