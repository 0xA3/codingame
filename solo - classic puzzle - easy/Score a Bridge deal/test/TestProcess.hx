package test;

import Std.parseInt;
import haxe.ds.Either;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "SingleTest", Main.process( singleTest ).should.be( singleTestResult ));
			it( "Example", Main.process( example ).should.be( exampleResult ));
			it( "Winning a partial", Main.process( winningAPartial ).should.be( winningAPartialResult ));
			it( "Nobody's interested", Main.process( nobodySInterested ).should.be( nobodySInterestedResult ));
			it( "Going Down !", Main.process( goingDown ).should.be( goingDownResult ));
			it( "Bonuses", Main.process( bonuses ).should.be( bonusesResult ));
			it( "Doubling starts", Main.process( doublingStarts ).should.be( doublingStartsResult ));
			it( "Random 1", Main.process( random1 ).should.be( random1Result ));
			it( "Random 2", Main.process( random2 ).should.be( random2Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final singleTest = parseInput(
		"1
		V 7SX 6"
	);

	final singleTestResult = parseResult(
		"-2000"
	);

	final example = parseInput(
		"1
		V 4S 11"
	);

	final exampleResult = parseResult(
		"650"
	);
	
	final winningAPartial = parseInput(
		"5
		V 1NT 7
		NV 3D 10
		V 2H 12
		NV 2NT 9
		V 1C 7"
	);

	final winningAPartialResult = parseResult(
		"90
		130
		230
		150
		70"
	);
	
	final nobodySInterested = parseInput(
		"1
		V Pass"
	);

	final nobodySInterestedResult = parseResult(
		"0"
	);
	
	final goingDown = parseInput(
		"3
		V 3NT 8
		NV 6H 10
		V 7NT 0"
	);

	final goingDownResult = parseResult(
		"-100
		-100
		-1300"
	);
	
	final bonuses = parseInput(
		"5
		NV 4S 11
		V 3NT 9
		NV 5C 13
		V 6NT 13
		NV 7D 13"
	);

	final bonusesResult = parseResult(
		"450
		600
		440
		1470
		1440"
	);
	
	final doublingStarts = parseInput(
		"8
		V 1NTX 5
		NV 2DXX 6
		NV 4HXX 10
		V 3NTXX 10
		NV 7DX 8
		V 3CX 10
		NV 1DXX 9
		NV 4SX 9"
	);

	final doublingStartsResult = parseResult(
		"-500
		-600
		880
		1400
		-1100
		870
		630
		-100"
	);
	
	final random1 = parseInput(
		"20
		V 4NTXX 6
		V 4NT 11
		V 5NTXX 13
		V 6C 6
		NV 2H 9
		NV 6D 10
		NV 5S 9
		V 6S 11
		V 4CX 10
		NV 6HX 10
		NV 7NT 10
		NV 4C 13
		V 5DX 11
		NV 4S 13
		V 6NTX 12
		V 6NT 8
		V 3NTX 9
		NV 6D 10
		V 7SX 6
		V 5H 9"
	);

	final random1Result = parseResult(
		"-2200
		660
		2040
		-600
		140
		-100
		-100
		-100
		710
		-300
		-150
		190
		750
		510
		1680
		-400
		750
		-100
		-2000
		-200"
	);
	
	final random2 = parseInput(
		"20
		V 6SXX 11
		V 7DX 6
		NV 5C 6
		V 3NT 12
		NV 3H 13
		NV 5H 12
		NV 5S 8
		NV 7D 13
		NV 7H 5
		V 2CXX 6
		V 4DX 11
		V 1NTX 7
		NV 1NTXX 10
		V 2DX 9
		NV 3NT 7
		NV 2C 9
		NV 1DX 13
		V 4NT 7
		V 5SX 8
		V 5SX 6"
	);

	final random2Result = parseResult(
		"-400
		-2000
		-250
		690
		260
		480
		-150
		1440
		-400
		-1000
		910
		180
		1160
		380
		-100
		110
		740
		-300
		-800
		-1400"
	);
}
