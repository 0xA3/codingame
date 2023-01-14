package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "MOVING FREELY", {
				final input = movingFreely;
				Main.process( input.rookPosition, input.pieces ).should.be( movingFreelyResult );
			});
			it( "CLOSE TO THE EDGE", {
				final input = closeToTheEdge;
				Main.process( input.rookPosition, input.pieces ).should.be( closeToTheEdgeResult );
			});
			it( "ONLY ALLIES", {
				final input = onlyAllies;
				Main.process( input.rookPosition, input.pieces ).should.be( onlyAlliesResult );
			});
			it( "FOR FRODOOO", {
				final input = forFrodooo;
				Main.process( input.rookPosition, input.pieces ).should.be( forFrodoooResult );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final rookPosition = lines[0];
		final pieces:Map<String, Int> = [];
		for( i in 2...lines.length ) {
			var inputs = lines[i].split(' ');
			pieces.set( inputs[1], parseInt( inputs[0] ));
		};
		return { rookPosition: rookPosition, pieces: pieces };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final movingFreely = parseInput(
		"d5
		2
		0 c1
		1 e8"
	);

	final movingFreelyResult = parseResult(
		"Rd5-a5
		Rd5-b5
		Rd5-c5
		Rd5-d1
		Rd5-d2
		Rd5-d3
		Rd5-d4
		Rd5-d6
		Rd5-d7
		Rd5-d8
		Rd5-e5
		Rd5-f5
		Rd5-g5
		Rd5-h5"
	);

	final closeToTheEdge = parseInput(
		"a8
		5
		0 e8
		1 d7
		0 c6
		1 b5
		0 a4"
	);

	final closeToTheEdgeResult = parseResult(
		"Ra8-a5
		Ra8-a6
		Ra8-a7
		Ra8-b8
		Ra8-c8
		Ra8-d8"
	);

	final onlyAllies = parseInput(
		"d5
		2
		0 g5
		0 d2"
	);

	final onlyAlliesResult = parseResult(
		"Rd5-a5
		Rd5-b5
		Rd5-c5
		Rd5-d3
		Rd5-d4
		Rd5-d6
		Rd5-d7
		Rd5-d8
		Rd5-e5
		Rd5-f5"
	);

	final forFrodooo = parseInput(
		"d5
		3
		0 g5
		0 d2
		1 d7"
	);
	final forFrodoooResult = parseResult(
		"Rd5-a5
		Rd5-b5
		Rd5-c5
		Rd5-d3
		Rd5-d4
		Rd5-d6
		Rd5-e5
		Rd5-f5
		Rd5xd7"
	);

}

