package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test 1", { Main.process( test1 ).should.be( "right-handed" ); });
			it( "Test 2", { Main.process( test2 ).should.be( "degenerate" ); });
			it( "Test 3", { Main.process( test3 ).should.be( "left-handed" ); });
			it( "Test 4", { Main.process( test4 ).should.be( "degenerate" ); });
			it( "Test 5", { Main.process( test5 ).should.be( "right-handed" ); });
			it( "Test 6", { Main.process( test6 ).should.be( "degenerate" ); });
			it( "Test 7", { Main.process( test7 ).should.be( "left-handed" ); });
			it( "Test 8", { Main.process( test8 ).should.be( "right-handed" ); });
			it( "Test 9", { Main.process( test9 ).should.be( "degenerate" ); });
			it( "Test 10", { Main.process( test10 ).should.be( "degenerate" ); });
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		return lines;
	}
	
	final test1 = parseInput(
	   " 1
		2354
		 6"
	);

	final test2 = parseInput(
	   " 1
		4256
		 3"
	);

	final test3 = parseInput(
	   " 4
		6512
		 3"
	);

	final test4 = parseInput(
	   " 4
		5612
		 3"
	);

	final test5 = parseInput(
	   " 4
		1562
		 3"
	);

	final test6 = parseInput(
	   " 3
		2561
		 4"
	);

	final test7 = parseInput(
	   " 3
		2156
		 4"
	);

	final test8 = parseInput(
	   " 5
		3641
		 2"
	);

	final test9 = parseInput(
	   " 5
		6341
		 2"
	);

	final test10 = parseInput(
	   " 6
		3452
		 1"
	);

}

