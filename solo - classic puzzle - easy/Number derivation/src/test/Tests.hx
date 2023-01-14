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
			
			it( "Prime number", {
				Main.process( 7 ).should.be( 1 );
			});
			
			it( "Power of prime", {
				Main.process( 81 ).should.be( 108 );
			});
			
			it( "Product of primes", {
				Main.process( 15 ).should.be( 8 );
			});
			
			it( "Integer", {
				Main.process( 42 ).should.be( 41 );
			});
			
			it( "n’=n", {
				Main.process( 27 ).should.be( 27 );
			});
			
		});
	}

}
