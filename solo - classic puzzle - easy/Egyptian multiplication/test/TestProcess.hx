package test;

import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		// Tests are very slow
		describe( "Test process", {
			
			it( "Example", Main.process( [12, 5] ).should.be( exampleResult ));
			it( "Simple a<b", Main.process( [3, 12] ).should.be( simpleASmallerBResult ));
			it( "Simple a>b", Main.process( [20, 2] ).should.be( simpleABiggerBResult ));
			it( "Zero", Main.process( [0, 1] ).should.be( zeroResult ));
			it( "Bigger numbers", Main.process( [7675, 179] ).should.be( biggerNumbersResult ));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final exampleResult = parseResult(
		"12 * 5
		= 12 * 4 + 12
		= 24 * 2 + 12
		= 48 * 1 + 12
		= 48 * 0 + 12 + 48
		= 60"
	);

	final simpleASmallerBResult = parseResult(
		"12 * 3
		= 12 * 2 + 12
		= 24 * 1 + 12
		= 24 * 0 + 12 + 24
		= 36"
	);

	final simpleABiggerBResult = parseResult(
		"20 * 2
		= 40 * 1
		= 40 * 0 + 40
		= 40"
	);

	final zeroResult = parseResult(
		"1 * 0
		= 0"
	);

	final biggerNumbersResult = parseResult(
		"7675 * 179
		= 7675 * 178 + 7675
		= 15350 * 89 + 7675
		= 15350 * 88 + 7675 + 15350
		= 30700 * 44 + 7675 + 15350
		= 61400 * 22 + 7675 + 15350
		= 122800 * 11 + 7675 + 15350
		= 122800 * 10 + 7675 + 15350 + 122800
		= 245600 * 5 + 7675 + 15350 + 122800
		= 245600 * 4 + 7675 + 15350 + 122800 + 245600
		= 491200 * 2 + 7675 + 15350 + 122800 + 245600
		= 982400 * 1 + 7675 + 15350 + 122800 + 245600
		= 982400 * 0 + 7675 + 15350 + 122800 + 245600 + 982400
		= 1373825"
	);
}
