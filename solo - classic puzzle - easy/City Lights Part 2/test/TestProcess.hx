package test;

import CodinGame.printErr;
import Main.BRIGHTNESS_CHARS;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Simple", {
				final ip = simple;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( simpleResult );
			});
			it( "Simple Again", {
				final ip = simpleAgain;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( simpleAgainResult );
			});
			it( "More Towns", {
				final ip = moreTowns;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( moreTownsResult );
			});
			it( "Rural", {
				final ip = rural;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( ruralResult );
			});
			it( "Urban", {
				final ip = urban;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( urbanResult );
			});
			it( "TOO MUCH LIGHT", {
				final ip = tooMuchLight;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( tooMuchLightResult );
			});
			it( "im blind", {
				final ip = imBlind;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( imBlindResult );
			});
			it( "pls stop wasting electricity", {
				final ip = imBlind;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( imBlindResult );
			});
			it( "2D again???", {
				final ip = imBlind;
				Main.process( ip.l, ip.w, ip.d, ip.gridInputs ).should.be( imBlindResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final l = parseInt( readline() );
		final w = parseInt( readline() );
		final d = parseInt( readline() );
		final n = parseInt( readline() );
		final gridInputs = [for( _ in 0...n ) readline()];
		
		return  { l: l, w: w, d: d, gridInputs: gridInputs }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simple = parseInput(
		"3
		4
		2
		9
		...
		.3.
		...
		...

		...
		...
		...
		.2."
	);
	
	final simpleResult = parseResult(
		"222
		232
		232
		222

		121
		222
		232
		232"
	);

	final simpleAgain = parseInput(
		"4
		2
		4
		11
		....
		.2..

		....
		....

		....
		....

		..3.
		...."
	);
	
	final simpleAgainResult = parseResult(
		"1110
		1210

		0211
		1221

		1222
		1121

		1232
		1222"
	);

	final moreTowns = parseInput(
		"4
		5
		4
		23
		.2..
		....
		....
		...1
		....

		....
		....
		.4..
		....
		....

		....
		...2
		....
		....
		11..

		....
		....
		..1.
		..1.
		...2"
	);
	
	final moreTownsResult = parseResult(
		"3431
		3432
		3332
		2323
		2221

		3332
		3443
		3433
		3332
		2221

		2232
		2334
		3343
		2323
		3332

		1112
		2232
		2232
		2242
		1123"
	);

	final rural = parseInput(
		"5
		4
		6
		29
		.....
		.....
		...1.
		.....

		...22
		.....
		.....
		.....

		.....
		..1..
		.....
		...11

		.....
		.....
		...1.
		...1.

		.....
		.....
		..3..
		.....

		....1
		.....
		..1..
		....."
	);
	
	final ruralResult = parseResult(
		"00122
		00011
		00010
		00000

		00133
		00122
		00000
		00000

		00122
		01221
		01110
		01121

		01110
		11211
		12231
		11221

		01110
		12221
		12321
		12221

		01111
		11211
		12321
		11211"
	);

	final urban = parseInput(
		"7
		4
		8
		39
		......4
		.......
		......2
		.......

		.3.....
		.......
		.......
		.......

		.......
		22.....
		.......
		..5....

		.......
		.......
		11.....
		.......

		.......
		...1...
		...1...
		.......

		2......
		.......
		.......
		......3

		.......
		.......
		.......
		.......

		.......
		...3...
		...3...
		......."
	);
	
	final urbanResult = parseResult(
		"3333334
		3434454
		3443344
		2333233

		4644343
		6765434
		5553454
		3444333

		5653232
		6854333
		6764432
		3454321

		3432121
		5653221
		5543332
		3444332

		2211100
		3223221
		2334322
		2333333

		2222100
		2233311
		1244432
		1233333

		1223210
		1244331
		0345432
		1234432

		0133310
		0245420
		0245431
		0133321"
	);

	final tooMuchLight = parseInput(
		"6
		7
		5
		39
		......
		.....5
		......
		.....2
		......
		3....5
		......

		2.....
		......
		......
		..5...
		......
		......
		.....2

		.....1
		.....1
		......
		3.....
		......
		.2.2..
		......

		......
		...6..
		......
		......
		......
		...4..
		......

		......
		.....2
		......
		.3....
		..5...
		......
		...1.."
	);
	
	final tooMuchLightResult = parseResult(
		"467887
		568AA9
		67BADB
		6B9BCC
		89CBEA
		589A99
		357676

		578988
		6AABB9
		8ADDDC
		9DEEFE
		9DFFDD
		8CDDDA
		479A98

		578989
		8AABBA
		BCEEEB
		BEHHFB
		DFHGFB
		9EEFDA
		69ABB9

		468887
		8ABBB9
		ADFEDA
		BEGFD9
		BFGGEA
		ACFDD9
		489A96

		466776
		689998
		9CCCA8
		9EEDA9
		ADEDA8
		79BBA6
		377965"
	);

	final imBlind = parseInput(
		"6
		6
		6
		41
		..3...
		..6...
		......
		....11
		......
		.1....

		......
		....8.
		......
		...A..
		......
		......

		...2..
		...F..
		......
		......
		...3..
		......

		......
		......
		...2..
		.....4
		......
		......

		......
		......
		.....2
		.....2
		......
		...22.

		...F..
		......
		......
		...2..
		......
		...4.."
	);
	
	final imBlindResult = parseResult(
		"ZZZZZZ
		ZZZZZZ
		ZZZZZZ
		WZZZZZ
		UYZZZZ
		RVWYXU

		ZZZZZZ
		ZZZZZZ
		ZZZZZZ
		YZZZZZ
		WZZZZZ
		RVZZZW

		ZZZZZZ
		ZZZZZZ
		ZZZZZZ
		YZZZZZ
		WZZZZZ
		RWZZZZ

		XZZZZZ
		ZZZZZZ
		YZZZZZ
		WZZZZZ
		VZZZZZ
		SWZZZY

		WZZZZZ
		XZZZZZ
		WZZZZZ
		WYZZZZ
		UXZZZZ
		RUYZZY

		UXZZZX
		VXZZZZ
		UWZZZZ
		SXZZZZ
		SUZZZY
		PTVZXV"
	);

	final plsStopWastingElectricity = parseInput(
		"4
		5
		6
		35
		..2.
		....
		..3.
		....
		.5.6

		...D
		....
		.11.
		.1..
		....

		.J..
		....
		....
		....
		....

		2...
		33..
		....
		...2
		.22.

		5...
		.6..
		...2
		....
		.1..

		....
		....
		....
		...1
		.654"
	);
	
	final plsStopWastingElectricityResult = parseResult(
		"WZZY
		ZZZZ
		ZZZZ
		YZZZ
		VZZZ

		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ

		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ

		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ

		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ
		ZZZZ

		ZZZX
		ZZZZ
		ZZZZ
		ZZZZ
		YZZZ"
	);

	final _2DAgain = parseInput(
		"13
		13
		1
		13
		.............
		.............
		.............
		.............
		.............
		.............
		......Q......
		.............
		.............
		.............
		.............
		.............
		............."
	);
	
	final _2DAgainResult = parseResult(
		"IIJJKKKKKJJII
		IJKKLLLLLKKJI
		JKKLMMMMMLKKJ
		JKLMMNNNMMLKJ
		KLMMNOOONMMLK
		KLMNOPPPONMLK
		KLMNOPQPONMLK
		KLMNOPPPONMLK
		KLMMNOOONMMLK
		JKLMMNNNMMLKJ
		JKKLMMMMMLKKJ
		IJKKLLLLLKKJI
		IIJJKKKKKJJII"
	);
}