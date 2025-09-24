package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( test1 ).should.be( test1Result ));
			it( "Test 2", Main.process( test2 ).should.be( test2Result ));
			it( "Test 3", Main.process( test3 ).should.be( test3Result ));
			it( "Test 4", Main.process( test4 ).should.be( test4Result ));
			it( "Test 5", Main.process( test5 ).should.be( test5Result ));
			it( "Test 6", Main.process( test6 ).should.be( test6Result ));
			it( "Test 7", Main.process( test7 ).should.be( test7Result ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final h = parseInt( readline());
		final grid = [for( _ in 0...h ) readline().split(" ").map( parseInt )];
		
		return grid;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"4
		1 1 1 2
		1 2 1 1
		1 1 1 2
		1 0 1 1"
	);

	final test1Result = parseResult(
		"(3, 0), (1, 1), (3, 2)
		(1, 3)"
	);

	final test2 = parseInput(
		"5
		8 9 4 1
		3 4 8 7
		1 5 4 4
		1 3 8 9
		1 4 4 4"
	);

	final test2Result = parseResult(
		"(1, 0), (3, 3)
		(3, 0)"
	);

	final test3 = parseInput(
		"6
		11 23 45 78 69 12 45
		14 57 89 65 11 12 23
		47 58 69 14 25 36 10
		4 5 7 87 465 12 87
		87 45 6 123 78 65 1
		7 8 9 4 5 6 117"
	);

	final test3Result = parseResult(
		"(6, 0), (2, 1), (4, 3), (6, 3), (0, 4), (6, 5)
		(0, 0), (4, 1), (6, 2), (0, 3), (6, 4), (0, 5), (3, 5)"
	);

	final test4 = parseInput(
		"8
		4 45 -8 1 6
		-4 -6 7 12 5
		6 45 789 23 -45
		597 155 974 -742 -497
		546 784 12 4 3
		-1 -2 -3 -5 -78
		5 7 9 135 782
		1234 456 789 -4678 9644"
	);

	final test4Result = parseResult(
		"(1, 0), (2, 3), (0, 7), (2, 7), (4, 7)
		(2, 0), (3, 3), (4, 5), (3, 7)"
	);

	final test5 = parseInput(
		"10
		-9514 -124 -7832 5498 -1803 -3162
		-124 1221 5659 -6759 -4978 -3051
		-4208 -2974 5659 -4978 -8227 -8227
		-3231 531 -4163 -3000 -4978 -8227
		-8522 -597 -9102 -3000 -4168 -8227
		-597 2124 4348 -9102 -130 -130
		-597 4348 937 5064 -7861 -5129
		-1814 -6515 -8705 8952 8952 -5064
		7556 7556 3432 4843 4527 -4739
		-5091 5775 -7253 -4228 -6849 4042"
	);

	final test5Result = parseResult(
		"NONE
		(0, 0), (2, 0), (0, 2), (0, 4), (2, 7), (0, 9), (2, 9), (4, 9)"
	);

	final test6 = parseInput(
		"10
		3437 -2236 9860 3922 7275 9682
		5706 2515 -2236 9860 9860 289
		9620 2630 2630 2547 9860 289
		3139 1450 2630 661 3194 7008
		3139 606 -92 -1125 7008 7008
		606 -1455 3586 -1376 9450 6287
		604 -1455 -2501 9629 5851 -2257
		8365 -1599 5133 -2931 -4791 -2257
		735 8127 6700 4528 6759 -4791
		1215 6700 8127 7136 2479 -546"
	);

	final test6Result = parseResult(
		"(0, 2), (3, 6), (0, 7)
		NONE"
	);

	final test7 = parseInput(
		"10
		-9778 -9778 -4268 -2147 7140 7140 7140
		-9778 -9778 -7141 -4268 -4146 7140 5790
		-8651 -7141 -5903 -4268 3710 -8684 -8684
		-8367 958 958 -2511 -824 -6834 -824
		-1918 958 -772 -772 -3752 -824 -2451
		3281 3281 235 -772 -8165 -246 -824
		-1913 3281 1420 1420 -3703 -8165 5016
		-1913 396 396 -44 -2507 5016 -8165
		-1913 -1913 106 -8729 -8729 -8729 4072
		-1913 106 -1913 106 -2693 1944 -8729"
	);

	final test7Result = parseResult(
		"NONE
		NONE"
	);
}