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
			
			it( "Real out", { Main.process( "4.5+0i", 10 ).should.be( 1 ); });
			it( "Imaginary out", { Main.process( "0+4.2i", 100 ).should.be( 1 ); });
			it( "Real in", { Main.process( "-1.1+0i", 45 ).should.be( 45 ); });
			it( "Imaginary in", { Main.process( "0+0.2i", 11 ).should.be( 11 ); });
			it( "Complex out", { Main.process( "-0.65812-0.452i", 275 ).should.be( 124 ); });
			it( "Complex in", { Main.process( "0.15658-0.5745i", 822 ).should.be( 822 ); });
			it( "Check your absolute value", { Main.process( "0.465+0.354i", 50 ).should.be( 12 ); });
			
		});
	}

}

