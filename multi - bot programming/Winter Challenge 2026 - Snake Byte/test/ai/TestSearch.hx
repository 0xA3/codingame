package test.ai;

import CodinGame.printErr;
import test.ai.ParseInput.ParsedInput;
import test.ai.ParseInput.parseInput;

using buddy.Should;

class TestSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test search", {
			it( "power above", {
				final ai = createAi( powerAbove );
				ai.process().should.be( "0 UP" );
			});
			
			it( "power 2 above", {
				final ai = createAi( power2Above );
				ai.process().should.be( "0 LEFT" );
			});
			
			it( "power above right", {
				final ai = createAi( powerAboveRight );
				ai.process().should.be( "0 RIGHT" );
			});
			
			it( "power above right on platform", {
				final ai = createAi( powerAboveRightOnPlatform );
				ai.process().should.be( "0 LEFT" );
			});
			
			it( "step to power", {
				final ai = createAi( stepToPower );
				ai.process().should.be( "0 RIGHT" );
			});
			
			it( "two on the left", {
				final ai = createAi( twoOnTheLeft );
				ai.process().should.be( "0 LEFT" );
			});
			
			@include it( "over gap", {
				final ai = createAi( overGap );
				ai.process().should.be( "0 RIGHT" );
			});
		});
	}

	public function createAi( ip:ParsedInput ) {
		ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

		final ai = new ai.versions.Ai18();
		ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
		ai.setInputs( ip.myIds, ip.oppIds );

		return ai;
	}

	public final powerAbove = parseInput(
		"0
		3
		5
		.P.
		.0.
		.0.
		.0.
		###"
	);

	public final power2Above = parseInput(
		"0
		3
		6
		.P.
		...
		.0.
		.0.
		.0.
		###"
	);

	public final powerAboveRight = parseInput(
		"0
		3
		5
		..P
		.0.
		.0.
		.0.
		###"
	);
	
	public final powerAboveRightOnPlatform = parseInput(
		"0
		6
		5
		..P...
		.0#...
		.0....
		.0....
		######"
	);
	
	public final stepToPower = parseInput(
		"0
		6
		5
		..P...
		.0....
		.0#...
		.0....
		######"
	);
	
	public final twoOnTheLeft = parseInput(
		"0
		8
		6
		........
		....0...
		..P.0...
		#...0...
		#...####
		########"
	);
	
	public final overGap = parseInput(
		"0
		8
		6
		........
		....0.P.
		....0...
		....0...
		#...#.#.
		.###..##"
	);
}