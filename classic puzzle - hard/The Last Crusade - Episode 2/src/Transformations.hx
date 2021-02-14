final posMap = [
	"TOP" => 0,
	"LEFT" => 1,
	"RIGHT" => 2
];

final tileMovements = [
	[[0, 0], [0, 0], [0, 0]], // Type  0 - TOP not possible, LEFT not possible, RIGHT not possible
	[[0, 1], [0, 1], [0, 1]], // Type  1 - TOP go down 0:1, LEFT go down 0:1, RIGHT go down 0:1
	[[0, 0], [1, 0], [-1, 0]], // Type  2 - TOP not possible, LEFT go right 1:0, RIGHT go left -1:0
	[[0, 1], [0, 0], [0, 0]], // Type  3 - ...
	[[-1, 0], [0, 0], [0, 1]], // Type  4
	[[1, 0], [0, 1], [0, 0]], // Type  5
	[[0, 0], [1, 0], [-1, 0]], // Type  6
	[[0, 1], [0, 0], [0, 1]], // Type  7
	[[0, 0], [0, 1], [0, 1]], // Type  8
	[[0, 1], [0, 1], [0, 0]], // Type  9
	[[-1, 0], [0, 0], [0, 0]], // Type 10
	[[1, 0], [0, 0], [0, 0]], // Type 11
	[[0, 0], [0, 0], [0, 1]], // Type 12
	[[0, 0], [0, 1], [0, 0]], // Type 13
];

final tileRotations = [
	[0],				// Type 0
	[1],				// Type 1
	[2, 3],				// Type 2
	[3, 2],				// Type 3
	[4, 5],				// Type 4
	[5, 4],				// Type 5
	[6, 7, 8, 9],		// Type 6
	[7, 8, 9, 6],		// Type 7
	[8, 9, 6, 7],		// Type 8
	[9, 6, 7, 8],		// Type 9
	[10, 11, 12, 13],	// Type 10
	[11, 12, 13, 10],	// Type 11
	[12, 13, 10, 11],	// Type 12
	[13, 10, 11, 12],	// Type 13
];

final directions = [
	[-1, -1, -1],	// Type  0 - TOP - undefined, LEFT - undefined, RIGHT - undefined
	[0, 0, 0],		// Type  1 - TOP - TOP, LEFT - TOP, RIGHT - TOP
	[-1, 1, 2],		// Type  2 - TOP - Undefined, LEFT - LEFT, RIGHT - RIGHT
	[0, -1, -1],	// Type  3 - TOP - TOP, LEFT - undefined, RIGHT - undefined
	[2, -1, 0],		// Type  4 - TOP - RIGHT, LEFT - undefined, RIGHT - TOP
	[1, 0, -1],		// Type  5 - TOP - LEFT, LEFT - TOP, RIGHT - undefined
	[-1, 1, 2],		// Type  6 - TOP - undefined, LEFT - LEFT, RIGHT - RIGHT
	[0, -1, 0],		// Type  7 - TOP - TOP, LEFT - undefined, RIGHT - TOP
	[-1, 0, 0],		// Type  8 - TOP - undefined, LEFT - TOP, RIGHT - TOP
	[0, 0, -1],		// Type  9 - TOP - TOP, LEFT - TOP, RIGHT - undefined
	[2, -1, -1],	// Type 10 - TOP - RIGHT, LEFT - undefined, RIGHT - undefined
	[1, -1, -1],	// Type 11 - TOP - LEFT, LEFT - undefined, RIGHT - undefined
	[-1, -1, 0],	// Type 12 - TOP - undefined, LEFT - undefined, RIGHT - TOP
	[-1, 0, -1],	// Type 13 - TOP - LEFT, LEFT - TOP, RIGHT - undefined

];
