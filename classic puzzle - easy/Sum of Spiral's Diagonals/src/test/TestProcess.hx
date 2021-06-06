package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "3", { Main.process( 3 ).should.be( 25 );	});
			it( "4", { Main.process( 4 ).should.be( 80 );	});
			it( "Odd Spiral", { Main.process( 5 ).should.be( 133 );	});
			it( "Even Spiral", { Main.process( 36 ).should.be( 61584 );	});
			it( "Bigger Spiral", { Main.process( 588 ).should.be( 270890816 );	});
			it( "Milky Way", { Main.process( 1453 ).should.be( 4086949725 );	});
		});
			
	}

}

