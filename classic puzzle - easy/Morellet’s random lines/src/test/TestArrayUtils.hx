package test;

import haxe.Int64;
import Main;
import Std.parseInt;

using buddy.Should;
using ArrayUtils;

class TestArrayUtils extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Min", {
			
			it( "Min 0", {
				[0].min().should.be( 0 );
			});
			
			it( "Min 1 2", {
				[1, 2].min().should.be( 1 );
			});
			
			it( "Min 2 1", {
				[2, 1].min().should.be( 1 );
			});
			
			it( "Min 2 -1 3", {
				[2, -1, 3].min().should.be( -1 );
			});
			
		});

		describe( "Test Every", {
			
			it( "Every [0] n == 0", {
				[0].every( n -> n == 0 ).should.be( true );
			});
			
			it( "Every [0] n != 0", {
				[0].every( n -> n != 0 ).should.be( false );
			});
			
			it( "Every [2, 4, 6] n % 2 == 0", {
				[2, 4, 6].every( n -> n % 2 == 0 ).should.be( true );
			});
			
			it( "Every [2, 3, 6] n % 2 == 0", {
				[2, 3, 6].every( n -> n % 2 == 0 ).should.be( false );
			});
			
		});

	}

}

