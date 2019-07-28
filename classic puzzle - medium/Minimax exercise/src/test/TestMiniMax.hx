package test;

using buddy.Should;

class TestMiniMax extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Minimax", {
			
			/*
			max     3
			     / / \ \
			    2 -1  3 0

			*/
			
			it( "Depth 1 game evaluate", {
				final miniMax = new MiniMax( 1, 4, [2, -1, 3, 0] );
				miniMax.evaluate().should.be( 3 );
			});
			
			it( "Depth 1 game leafCounter", {
				final miniMax = new MiniMax( 1, 4, [2, -1, 3, 0] );
				miniMax.evaluate();
				miniMax.visitedNodesQuantity.should.be( 5 );
			});
			
			/*
			max     3
			       / \
            min   1   3
			     /\   /\
			    1  2 3  4

			*/
			it( "Depth 2, no cutoffs evaluate", {
				final miniMax = new MiniMax( 2, 2, [1, 2, 3, 4] );
				miniMax.evaluate().should.be( 3 );
			});
			
			it( "Depth 2, no cutoffs leafCounter", {
				final miniMax = new MiniMax( 2, 2, [1, 2, 3, 4] );
				miniMax.evaluate();
				miniMax.visitedNodesQuantity.should.be( 7 );
			});
			
		});

	}
}