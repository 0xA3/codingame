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
	  hSpeed: -100,
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
	  hSpeed: -90,
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
	  angle: -75,
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
	  hSpeed: -50,
	  vSpeed: -4,
	  fuel: 1000,
	  angle: 75,
	  power: 0
}

var caveCorrectSide:TestCase = {
	coords: [
		[ 0, 450 ],     [ 300, 750 ],
		[ 1000, 450 ],  [ 1500, 650 ],
		[ 1800, 850 ],  [ 2000, 1950 ],
		[ 2200, 1850 ], [ 2400, 2000 ],
		[ 3100, 1800 ], [ 3150, 1550 ],
		[ 2500, 1600 ], [ 2200, 1550 ],
		[ 2100, 750 ],  [ 2200, 150 ],
		[ 3200, 150 ],  [ 3500, 450 ],
		[ 4000, 950 ],  [ 4500, 1450 ],
		[ 5000, 1550 ], [ 5500, 1500 ],
		[ 6000, 950 ],  [ 6999, 1750 ]
	  ],
	  x: 6480,
	  y: 2593,
	  hSpeed: -20,
	  vSpeed: -7,
	  fuel: 1000,
	  angle: 18,
	  power: 0
}

var caveWrongSide:TestCase = {
	coords: [
		[ 0, 1800 ],    [ 300, 1200 ],
		[ 1000, 1550 ], [ 2000, 1200 ],
		[ 2500, 1650 ], [ 3700, 220 ],
		[ 4700, 220 ],  [ 4750, 1000 ],
		[ 4700, 1650 ], [ 4000, 1700 ],
		[ 3700, 1600 ], [ 3750, 1900 ],
		[ 4000, 2100 ], [ 4900, 2050 ],
		[ 5100, 1000 ], [ 5500, 500 ],
		[ 6200, 800 ],  [ 6999, 600 ]
	  ],
	  x: 6500,
	  y: 1998,
	  hSpeed: 0,
	  vSpeed: -4,
	  fuel: 1200,
	  angle: 15,
	  power: 0
}

var stalagtiteUpwardStart:TestCase = {
	coords: [
		[ 0, 2500 ],    [ 100, 200 ],
		[ 500, 150 ], [ 1000, 2000 ],
		[ 2000, 2000 ], [ 2010, 200 ],
		[ 6899, 300 ],  [ 6999, 2500 ],
		[ 4100, 2600 ], [ 4200, 1000 ],
		[ 3500, 2900 ]
	  ],
	  x: 6500,
	  y: 1300,
	  hSpeed: 0,
	  vSpeed: 50,
	  fuel: 1750,
	  angle: 0,
	  power: 0
}
