package test;

import Main;
import Std.parseFloat;
import Std.parseInt;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {

			// for( i in 0...15 ) trace( '${i + 1}: ${ Main.processReference(i + 1)}' );

			it( "1", { Main.process( 1 ).should.be( 1 ); });
			it( "2", { Main.process( 2 ).should.be( 2 ); });
			it( "3", { Main.process( 3 ).should.be( 2 ); });
			it( "4", { Main.process( 4 ).should.be( 4 ); });
			it( "5", { Main.process( 5 ).should.be( 2 ); });
			it( "Example", { Main.process( 6 ).should.be( 4 ); });
			it( "7", { Main.process( 7 ).should.be( 6 ); });
			it( "8", { Main.process( 8 ).should.be( 8 ); });
			it( "9", { Main.process( 9 ).should.be( 2 ); });
			it( "10", { Main.process( 10 ).should.be( 4 ); });
			it( "11", { Main.process( 11 ).should.be( 6 ); });
			it( "12", { Main.process( 12 ).should.be( 8 ); });
			it( "13", { Main.process( 13 ).should.be( 10 ); });
			it( "14", { Main.process( 14 ).should.be( 12 ); });
			it( "Easy", { Main.process( 15 ).should.be( 14 ); });
			it( "A little more", { Main.process( 32 ).should.be( 32 ); });
			it( "A thick deck", { Main.process( 777 ).should.be( 530 ); });
			it( "Heavy deck", { Main.process( 9876 ).should.be( 3368 ); });
			it( "Getting serious", { Main.process( 609901 ).should.be( 171226 ); });
			it( "Millions 1", { Main.process( 566373192 ).should.be( 59004560 ); });
			it( "Millions 2", { Main.process( 697691238 ).should.be( 321640652 ); });
			it( "Ultimate test", { Main.process( 1000000000 ).should.be( 926258176 ); });
			it( "Boundary case", { Main.process( 1 ).should.be( 1 ); });

		});

	}

}

