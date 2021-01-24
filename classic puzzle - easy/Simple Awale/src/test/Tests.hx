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
			
			it( "Test1", {
				final input = test1;
				Main.process( input.opBowls, input.myBowls, input.num ).should.be( test1Result );
			});
			
			it( "Test2", {
				final input = test2;
				Main.process( input.opBowls, input.myBowls, input.num ).should.be( test2Result );
			});

			it( "Test3", {
				final input = test3;
				Main.process( input.opBowls, input.myBowls, input.num ).should.be( test3Result );
			});

			it( "Test4", {
				final input = test4;
				Main.process( input.opBowls, input.myBowls, input.num ).should.be( test4Result );
			});

			it( "Test5", {
				final input = test5;
				Main.process( input.opBowls, input.myBowls, input.num ).should.be( test5Result );
			});

		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final opBowls = lines[0].split(" ").map( b -> parseInt( b ));
		final myBowls = lines[1].split(" ").map( b -> parseInt( b ));
		final num = parseInt( lines[2] );
		return { opBowls: opBowls, myBowls: myBowls, num: num };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"5 1 0 6 2 2 3
		3 4 0 3 3 2 2
		0"
	);

	final test1Result = parseResult(
		"5 1 0 6 2 2 [3]
		0 5 1 4 3 2 [2]"
	);

	final test2 = parseInput(
		"5 1 0 6 2 2 3
		3 4 0 3 3 2 2
		5"
	);

	final test2Result = parseResult(
		"6 1 0 6 2 2 [3]
		3 4 0 3 3 0 [3]"
	);

	final test3 = parseInput(
		"5 1 0 6 2 2 3
		3 4 0 3 3 2 2
		3"
	);

	final test3Result = parseResult(
		"5 1 0 6 2 2 [3]
		3 4 0 0 4 3 [3]
		REPLAY"
	);

	final test4 = parseInput(
		"4 4 4 4 4 4 0
		4 4 4 4 4 4 0
		2"
	);

	final test4Result = parseResult(
		"4 4 4 4 4 4 [0]
		4 4 0 5 5 5 [1]
		REPLAY"
	);

	final test5 = parseInput(
		"4 2 1 7 0 6 2
		5 14 1 4 0 2 3
		1"
	);

	final test5Result = parseResult(
		"5 3 2 8 1 7 [2]
		6 1 3 5 1 3 [4]"
	);

}

