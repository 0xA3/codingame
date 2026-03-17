package test.ai;

import test.ai.ParseInput.parseInput;

using buddy.Should;

class TestSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test search", {
			it( "power above", {
				final ip = powerAbove;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai8();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 UP" );
			});
			
			it( "power 2 above", {
				final ip = power2Above;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai8();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 UP" );
			});
			
			it( "power above right", {
				final ip = powerAboveRight;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai8();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 RIGHT" );
			});
			
			it( "power above right on platform", {
				final ip = powerAboveRightOnPlatform;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai8();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 LEFT" );
			});
			
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

	public final powerAbove = parseInput(
		"0
		1
		5
		P
		0
		0
		0
		#"
	);

	public final power2Above = parseInput(
		"0
		1
		6
		P
		.
		0
		0
		0
		#"
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
}