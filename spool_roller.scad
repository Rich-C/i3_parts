slop = .2;

//sized for m5 and 605
bearing_w = 5+slop;
bearing_d = 16;
bearing_r = bearing_d/2+slop;
bearing_inner_d = 8.5;
bearing_inner_r = bearing_inner_d/2;

bolt_d = 5;
bolt_r = bolt_d/2+slop;

//sized for m8 and 608
//bearing_w = 7+slop;
//bearing_d = 22;
//bearing_r = bearing_d/2+slop;
//bearing_inner_d = 12;
//bearing_inner_r = bearing_inner_d/2;

//bolt_d = 8;
//bolt_r = bolt_d/2+slop;


separation = 100;
wall = 4;

spool_roller();

$fn=32;
module spool_roller(){
	difference(){
		union(){
			translate([0,0,wall+slop/2]) cube([separation+wall*2,wall*3+bearing_w,wall+wall+slop], center=true);
			for(i=[-separation/2, separation/2]) translate([i,0,0]) {
				translate([0,0,wall]) bearing_mount();
				
				cylinder(r1=bearing_r+wall*1.75, r2=bearing_r+wall+wall, h=2);

				translate([0,0,1.95]) cylinder(r1=bearing_r+wall+wall, r2=(bearing_w+wall+wall+wall)/2, h=wall+wall+slop-1.95);
			}
		}

		//center channel
		translate([0,0,wall+wall+slop]) scale([1,(bearing_w+wall)/(wall*2),1]) rotate([0,90,0]) cylinder(r=wall, h=separation*2, center=true, $fn=32);
	}
}

module bearing_mount(){
	translate([0,0,bearing_r+wall])
	rotate([-90,0,0]) 
	difference(){
		union(){
			for(i=[0,1]) mirror([0,0,i]) translate([0,0,-wall*1.5-bearing_w/2]) {
				translate([-(bearing_r+wall),0,0]) cube([(bearing_r+wall)*2, bearing_r+wall+wall, wall]);
				cylinder(r=(bearing_r+wall/2)/cos(30), h=wall, $fn=6);
				translate([0,0,wall]) cylinder(r=bearing_r, r2=bearing_inner_r, h=wall/2);
			}
		}

		cap_cylinder(r=bolt_r, h=100, center=true);
	}
}

module cap_cylinder(r=1, h=1, center=false){
	render() union(){
		cylinder(r=r, h=h, center=center);
		intersection(){
			rotate([0,0,22.5]) cylinder(r=r/cos(180/8), h=h, $fn=8, center=center);
			translate([0,-r/cos(180/4),0]) rotate([0,0,0]) cylinder(r=r/cos(180/4), h=h, $fn=4, center=center);
		}
	}
}