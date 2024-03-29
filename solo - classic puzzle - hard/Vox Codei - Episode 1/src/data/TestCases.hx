package data;

import Std.parseInt;

using StringTools;

class TestCases {
	
	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(" ");
		final width = parseInt( inputs[0] );
		final height = parseInt( inputs[1] );
		final grid = [for( i in 0...height ) lines[i + 1].split( "" )];
		final gameTurnInputs = lines[height + 1].split(" ");
		final rounds = parseInt( gameTurnInputs[0] );
		final bombs = parseInt( gameTurnInputs[1] );

		final dataset:TestCaseDataset = { width: width, height: height, grid: grid, rounds: rounds, bombs: bombs }

		return dataset;
	}

	public static final oneNodeOneBomb = parseInput(
		"4 3
		....
		.@..
		....
		15 1" );

	public static final threeNodesThreeBombs = parseInput(
		"4 3
		....
		@.@@
		....
		15 3" );

	public static final nineNodesNineBombs = parseInput(
		"12 9
		@...@.......
		.......@...@
		............
		...@.....@..
		............
		.@..........
		......@.....
		.........@..
		............
		15 9" );

	public static final fourNodesOneBomb = parseInput(
		"4 3
		.@..
		@.@.
		.@..
		4 1" );

	public static final lotOfNodesViewBombs = parseInput(
		"8 6
		....@@@.
		.@@@...@
		@...@..@
		@...@..@
		@...@...
		.@@@.@@@
		15 3" );

	public static final fourScatteredNodesTwoBombs = parseInput(
		"8 6
		.@.....@
		........
		........
		........
		........
		.@.....@
		5 2" );

	public static final indestructibleNodes = parseInput(
		"12 9
		............
		..##....##..
		.#@@#..#@@#.
		............
		.#@@#..#@@#.
		..##....##..
		............
		............
		............
		15 4" );

	public static final forseeTheFuture = parseInput(
		"8 6
		........
		......@.
		@@@.@@@@
		......@.
		........
		........
		10 3" );

	public static final forseeTheFutureBetter = parseInput(
		"8 6
		........
		......@.
		@@@.@@@@
		......@.
		........
		........
		10 2" );

	public static final destroyCodinGame = parseInput(
		"12 9
		............
		.#@@@.#@@@..
		.@....@.....
		.@....@.....
		.@....@..@#.
		.@....@...@.
		..@@@..@@@#.
		............
		............
		15 6" );

	public static final notSoFast = parseInput(
		"15 12
		...............
		...#...@...#...
		....#.....#....
		.....#.@.#.....
		......#.#......
		...@.@...@.@...
		......#.#......
		.....#.@.#.....
		....#.....#....
		...#...@...#...
		...............
		...............
		15 4" );
}