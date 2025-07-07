package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Test 1", Main.process( 59 ).should.be( 9 ));
			it( "Test 2", Main.process( 27 ).should.be( 8 ));
			it( "Test 3", Main.process( 71 ).should.be( 9 ));
			it( "Test 4", Main.process( 1023 ).should.be( 12 ));
			it( "Test 5", Main.process( 35641 ).should.be( 22 ));
			it( "Test 6", Main.process( 43691 ).should.be( 24 ));
			it( "Test 7", Main.process( 174763 ).should.be( 27 ));
			it( "Test 8", Main.process( 131072 ).should.be( 18 ));
			it( "Test 9", Main.process( 131073 ).should.be( 19 ));
			it( "Test 10", Main.process( 682430 ).should.be( 27 ));
			it( "Test 11", Main.process( 999998 ).should.be( 26 ));
			it( "Test 12", Main.process( 1 ).should.be( 1 ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		return  [for( _ in 0...5 ) readline()];
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}