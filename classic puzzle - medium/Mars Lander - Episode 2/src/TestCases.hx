typedef TestCase = {
	var coords:Array<Array<Int>>;
	var x:Int;
	var y:Int;
	var hSpeed:Int;
	var vSpeed:Int;
	var fuel:Int;
	var angle:Int;
	var power:Int;
}

var easyOnTheRight:TestCase = {
	coords: [
		[ 0, 100 ],
		[ 1000, 500 ],
		[ 1500, 1500 ],
		[ 3000, 1000 ],
		[ 4000, 150 ],
		[ 5500, 150 ],
		[ 6999, 800 ]
	],
	x: 2500,
	y: 2700,
	hSpeed: 0,
	vSpeed: 0,
	fuel: 550,
	angle: 0,
	power: 0
}

var initialSpeedCorrectSide:TestCase = {
	coords: [
		[ 0, 100 ],
		[ 1000, 500 ],
		[ 1500, 100 ],
		[ 3000, 100 ],
		[ 3500, 500 ],
		[ 3700, 200 ],
		[ 5000, 1500 ],
		[ 5800, 300 ],
		[ 6000, 1000 ],
		[ 6999, 2000 ]
	  ],
	  x: 6400,
	  y: 2798,
	  hSpeed: 100,
	  vSpeed: 4,
	  fuel: 600,
	  angle: 75,
	  power: 0
}

var initialSpeedWrongSide:TestCase = {
	coords: [
		[ 0, 100 ],
		[ 1000, 500 ],
		[ 1500, 1500 ],
		[ 3000, 1000 ],
		[ 4000, 150 ],
		[ 5500, 150 ],
		[ 6999, 800 ]
	  ],
	  x: 6410,
	  y: 2798,
	  hSpeed: 90,
	  vSpeed: -4,
	  fuel: 750,
	  angle: 75,
	  power: 0
}

var deepCanyon:TestCase = {
	coords: [
		[ 0, 1000 ],    [ 300, 1500 ],
		[ 350, 1400 ],  [ 500, 2000 ],
		[ 800, 1800 ],  [ 1000, 2500 ],
		[ 1200, 2100 ], [ 1500, 2400 ],
		[ 2000, 1000 ], [ 2200, 500 ],
		[ 2500, 100 ],  [ 2900, 800 ],
		[ 3000, 500 ],  [ 3200, 1000 ],
		[ 3500, 2000 ], [ 3800, 800 ],
		[ 4000, 200 ],  [ 5000, 200 ],
		[ 5500, 1500 ], [ 6999, 2800 ]
	  ],
	  x: 600,
	  y: 2698,
	  hSpeed: 100,
	  vSpeed: -4,
	  fuel: 800,
	  angle: 75,
	  power: 0
}

var highGround:TestCase = {
	coords: [
		[ 0, 1000 ],    [ 300, 1500 ],
		[ 350, 1400 ],  [ 500, 2100 ],
		[ 1500, 2100 ], [ 2000, 200 ],
		[ 2500, 500 ],  [ 2900, 300 ],
		[ 3000, 200 ],  [ 3200, 1000 ],
		[ 3500, 500 ],  [ 3800, 800 ],
		[ 4000, 200 ],  [ 4200, 800 ],
		[ 4800, 600 ],  [ 5000, 1200 ],
		[ 5500, 900 ],  [ 6000, 500 ],
		[ 6500, 300 ],  [ 6999, 500 ]
	  ],
	  x: 6450,
	  y: 2698,
	  hSpeed: 50,
	  vSpeed: -4,
	  fuel: 1000,
	  angle: 75,
	  power: 0
}
