package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Vertical stripes", {
				Main.process( verticalStripes ).should.be( verticalStripesResult );
			});
			it( "Starting by 0", {
				Main.process( startingBy0 ).should.be( startingBy0Result );
			});
			it( "Chess board", {
				Main.process( chessboard ).should.be( chessboardResult );
			});
			it( "Horizontal stripes", {
				Main.process( horizontalStripes ).should.be( horizontalStripesResult );
			});
			it( "Codingame", {
				Main.process( codingame ).should.be( codingameResult );
			});
			it( "Invalid", {
				Main.process( invalid ).should.be( invalidResult );
			});
			it( "Random", {
				Main.process( random ).should.be( randomResult );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return [for( i in 1...lines.length ) lines[i].split(" ").map( s -> parseInt( s ))];
	
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final verticalStripes = parseInput(
		"4
		1 3 2 1
		1 3 2 1
		1 3 2 1
		1 3 2 1"
	);

	final verticalStripesResult = parseResult(
		".OOO..O
		.OOO..O
		.OOO..O
		.OOO..O"
	);

	final startingBy0 = parseInput(
		"4
		0 1 1 1 1
		0 1 1 1 1
		0 1 1 1 1
		0 1 1 1 1"
	);

	final startingBy0Result = parseResult(
		"O.O.
		O.O.
		O.O.
		O.O."
	);

	final chessboard = parseInput(
		"8
		0 1 1 1 1 1 1 1 1
		1 1 1 1 1 1 1 1
		0 1 1 1 1 1 1 1 1
		1 1 1 1 1 1 1 1
		0 1 1 1 1 1 1 1 1
		1 1 1 1 1 1 1 1
		0 1 1 1 1 1 1 1 1
		1 1 1 1 1 1 1 1"
	);

	final chessboardResult = parseResult(
		"O.O.O.O.
		.O.O.O.O
		O.O.O.O.
		.O.O.O.O
		O.O.O.O.
		.O.O.O.O
		O.O.O.O.
		.O.O.O.O"
	);

	final horizontalStripes = parseInput(
		"4
		8
		0 8
		8
		0 8"
	);

	final horizontalStripesResult = parseResult(
		"........
		OOOOOOOO
		........
		OOOOOOOO"
	);

	final codingame = parseInput(
		"8
		45
		2 2 3 2 2 3 2 1 1 1 3 1 2 2 3 2 2 1 3 1 1 4 1
		1 1 2 1 1 1 2 1 1 1 2 1 1 1 1 2 2 1 1 1 2 1 1 1 2 1 1 2 1 2 1 1 4
		1 1 4 1 2 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 4 1 2 1 1 1 1 1 1 1 1 3 2
		1 1 4 1 2 1 1 1 2 1 1 1 1 1 2 2 1 1 1 2 1 4 1 1 3 1 1 1 4
		1 1 2 1 1 1 2 1 1 1 2 1 1 1 1 1 3 1 1 1 2 1 1 1 2 1 1 1 3 1 1 1 4
		2 2 3 2 2 3 2 1 1 1 3 1 2 2 2 1 2 1 1 1 3 1 1 4 1
		45"
	);

	final codingameResult = parseResult(
		".............................................
		..OO...OO..OOO..O.O...O..OO...OO..O...O.OOOO.
		.O..O.O..O.O..O.O.OO..O.O..O.O..O.OO.OO.O....
		.O....O..O.O..O.O.O.O.O.O....O..O.O.O.O.OOO..
		.O....O..O.O..O.O.O..OO.O.OO.OOOO.O...O.O....
		.O..O.O..O.O..O.O.O...O.O..O.O..O.O...O.O....
		..OO...OO..OOO..O.O...O..OO..O..O.O...O.OOOO.
		............................................."
	);

	final invalid = parseInput(
		"4
		0 1 1 2
		0 2 1 1
		0 1 1 1
		1 1 1 1"
	);

	final invalidResult = parseResult(
		"INVALID"
	);

	final random = parseInput(
		"5
		0 1 2 1 1 1 2 2 2 1 1 1 1 1 2 1 1 2 1 1 1 1 1 1 1 1 1 2 1 2 1 1 1 1 1 1 1 3 1 2
		2 3 1 1 6 1 1 1 1 1 2 2 2 1 1 1 4 1 1 1 3 2 1 2 1 1 1 1 3 1
		1 1 3 5 2 3 1 2 1 3 2 2 2 3 1 2 4 2 4 5 1
		0 1 1 1 1 3 3 1 1 2 2 2 2 1 1 3 1 1 2 1 1 2 2 1 3 1 1 1 2 4 1 1
		2 2 1 1 1 3 1 1 2 1 6 1 1 4 1 1 2 1 1 1 1 1 1 1 2 2 3 1 4"
	);

	final randomResult = parseResult(
		"O..O.O..OO..O.O.O..O.OO.O.O.O.O.OO.OO.O.O.O.OOO.OO
		..OOO.O......O.O.O..OO..O.O....O.O...OO.OO.O.O...O
		.O...OOOOO..OOO.OO.OOO..OO..OOO.OO....OO....OOOOO.
		O.O.OOO...O.OO..OO..O.OOO.O..O.OO..O...O.O..OOOO.O
		..OO.O.OOO.O..O......O.OOOO.O..O.O.O.O..OO...O...."
	);

}

