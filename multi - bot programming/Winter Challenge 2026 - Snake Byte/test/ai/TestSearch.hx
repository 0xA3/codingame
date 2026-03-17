package test.ai;

import test.ai.ParseInput.parseInput;

using buddy.Should;

class TestSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test search", {
			it( "snake should move up", {
				final ip = powerAbove;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai8();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 UP" );
			});
		});
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

}