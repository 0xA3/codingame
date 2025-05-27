package test;

import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Test 1", Main.process( 44714648 ).should.be( "2078-12-08" ));
			it( "Test 2", Main.process( 11241130 ).should.be( "0127-01-20" ));
			it( "Test 3", Main.process( 144783 ).should.be( "0012-01-01" ));
			it( "Test 4", Main.process( 10831071 ).should.be( "0831-07-10" ));
			it( "Test 5", Main.process( 94721247 ).should.be( "2012-09-09" ));
			it( "Test 6", Main.process( 71284547 ).should.be( "3241-10-16" ));
			it( "Test 7", Main.process( 328728753 ).should.be( "9451-11-11" ));
			it( "Test 8", Main.process( 83107110 ).should.be( "0831-07-10" ));
			it( "Test 9", Main.process( 200104091 ).should.be( "2001-04-09" ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
					
		return 0;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}