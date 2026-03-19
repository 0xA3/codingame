package test.ai;

import CodinGame.printErr;
import test.ai.ParseInput.ParsedInput;
import test.ai.ParseInput.parseInput;

using StringTools;
using buddy.Should;

@:access(ai.versions.Ai17)
class TestGetGroundDistance extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test get ground distance", {
			it( "on ground", {
				final ai = createAi( onGround );
				final groundDistance = ai.getGroundDistance( ai.mySnakebots[0], ai.board.powerSources[0], 0, 0, ai.board.boardHeight );
				groundDistance.should.be( 0 );
			});
			
			@include it( "distance 1", {
				final ai = createAi( distance1 );

				final groundDistance = ai.getGroundDistance( ai.mySnakebots[0], ai.board.powerSources[0], 0, 0, ai.board.boardHeight );
				groundDistance.should.be( 1 );
			});
		});
	}

	public function createAi( ip:ParsedInput ) {
		
		ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

		final ai = new ai.versions.Ai17();
		ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );

		return ai;
	}
	
	public final onGround = parseInput(
		"0
		2
		4
		0.
		0.
		0P
		##"
	);
	
	public final distance1 = parseInput(
		"0
		2
		4
		0.
		0P
		0.
		##"
	);
	
	public final distance2 = parseInput(
		"0
		2
		4
		0P
		0.
		0.
		##"
	);
}