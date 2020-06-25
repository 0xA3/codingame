package test;

import Main;

using buddy.Should;

@:access(Main)
class TestSequence extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Sequence", {

			it( "example", {
				// Main.loopSequence( 0, 22 ).should.be( 3 );
				Main.loopSequence( 0, 22 ).should.be( 3 );
			});

			it( "Test case1", {
				Main.loopSequence( 0, 2 ).should.be( 0 );
			});

			it( "Test case2", {
				Main.loopSequence( 0, 3 ).should.be( 1 );
			});

			it( "Test case3", {
				Main.loopSequence( 1, 58 ).should.be( 11 );
			});

			it( "Test case4", {
				Main.loopSequence( 10, 5692 ).should.be( 7 );
			});

			it( "Test case4", {
				Main.loopSequence( 1, 56804 ).should.be( 29 );
			});

			it( "Test case4", {
				Main.loopSequence( 0, 1000000 ).should.be( 34143 );
			});

		});
	}
}