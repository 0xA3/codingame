package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( test1 ).should.be( "0.6667" ));
			it( "Test 2", Main.process( test2 ).should.be( "0.0113" ));
			it( "Test 3", Main.process( test3 ).should.be( "0.9985" ));
			it( "Test 4", Main.process( test4 ).should.be( "0.9401" ));
			it( "Test 5", Main.process( test5 ).should.be( "0.0000" ));
			it( "Test 6", Main.process( test6 ).should.be( "1.0000" ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final n = parseInt( lines[0] );
		final reflectivities = lines[1].split(" ").map( s -> parseFloat( s )).slice( 0, n );
	
		return reflectivities;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"2
		0.5 0.500000"
	);

	final test2 = parseInput(
		"1
		0.011263"
	);

	final test3 = parseInput(
		"3
		0.313178 0.055436 0.998542"
	);

	final test4 = parseInput(
		"4
		0.756643 0.845056 0.439436 0.863778"
	);

	final test5 = parseInput(
		"10
		0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"
	);

	final test6 = parseInput(
		"8
		0.0 0.0 0.0 0.0 0.0 1.0 1.0 0.0"
	);
}
