package test.ai;

import CodinGame.printErr;
import test.ai.ParseInput.parseInput;

using buddy.Should;

class TestSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test search", {
			@include it( "power above", {
				final ip = powerAbove;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai17();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 UP" );
			});
			
			it( "power 2 above", {
				final ip = power2Above;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai17();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 UP" );
			});
			
			it( "power above right", {
				final ip = powerAboveRight;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai17();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 RIGHT" );
			});
			
			it( "power above right on platform", {
				final ip = powerAboveRightOnPlatform;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai17();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 LEFT" );
			});
			
			it( "step to power", {
				final ip = stepToPower;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai17();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 RIGHT" );
			});
			
			it( "two on the left", {
				final ip = twoOnTheLeft;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );

				final ai = new ai.versions.Ai17();
				ai.setGlobalInputs( ip.board, ip.snakebots, ip.board.marginX, ip.board.marginY );
				ai.setInputs( ip.myIds, ip.oppIds );
				
				ai.process().should.be( "0 LEFT" );
			});
			
			it( "over gap", {
				final ip = overGap;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );
				printErr( ip.board.outputBoard( ip.board.currentBoard ) );
				printErr( "Power sources " + ip.powerSources.map( p -> ip.board.outputPos( p )).join(",") );

				final ai = new ai.versions.Ai17();
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