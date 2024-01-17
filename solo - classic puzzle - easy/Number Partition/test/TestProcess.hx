package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( 4 ).should.be( test1Result ));
			it( "Test 2", Main.process( 2 ).should.be( test2Result ));
			it( "Test 3", Main.process( 3 ).should.be( test3Result ));
			it( "Test 4", Main.process( 5  ).should.be( test4Result ));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1Result = parseResult(
		"4
		3 1
		2 2
		2 1 1
		1 1 1 1"
	);

	final test2Result = parseResult(
		"2
		1 1"
	);

	final test3Result = parseResult(
		"3
		2 1
		1 1 1"
	);

	final test4Result = parseResult(
		"5
		4 1
		3 2
		3 1 1
		2 2 1
		2 1 1 1
		1 1 1 1 1"
	);
}
