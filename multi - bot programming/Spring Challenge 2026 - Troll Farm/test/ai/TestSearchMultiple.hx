package test.ai;

import test.ai.ParseInput.parseInput;

using buddy.Should;

class TestSearchMultiple extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test search", {
			@include it( "step to power", {
				final ip = stepToPower;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai8();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 RIGHT" );
			});
		});
	}

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
}