package test;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

import Main;
using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {

			it( "1 - 2", {
				Main.process( "1" ).should.be( "2" );
			});

			it( "9 - 11", {
				Main.process( "9" ).should.be( "11" );
			});

			it( "Test 1: 19 - 22", {
				Main.process( "19" ).should.be( "22" );
			});

			it( "Test 2: 99 - 111", {
				Main.process( "99" ).should.be( "111" );
			});

			it( "Test 3: 2533 - 2555", {
				Main.process( "2533" ).should.be( "2555" );
			});

			it( "Test 4: 123456879 - 123456888", {
				Main.process( "123456879" ).should.be( "123456888" );
			});

			it( "Test 4: 11123159995399999 - 11123333333333333", {
				Main.process( "11123159995399999" ).should.be( "11123333333333333" );
			});

			
		});

	}

}

