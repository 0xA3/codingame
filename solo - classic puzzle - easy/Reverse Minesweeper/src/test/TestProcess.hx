package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "leftBorder", {
				final ip = leftBorder;
				Main.process( ip.w, ip.h, ip.lines ).should.be( leftBorderResult );
			});
			it( "rightBorder", {
				final ip = rightBorder;
				Main.process( ip.w, ip.h, ip.lines ).should.be( rightBorderResult );
			});
			it( "One mine", {
				final ip = oneMine;
				Main.process( ip.w, ip.h, ip.lines ).should.be( oneMineResult );
			});
			it( "Many mines", {
				final ip = manyMines;
				Main.process( ip.w, ip.h, ip.lines ).should.be( manyMinesResult );
			});
			it( "Lot of mines", {
				final ip = lotOfMines;
				Main.process( ip.w, ip.h, ip.lines ).should.be( lotOfMinesResult );
			});
			it( "No mine", {
				final ip = noMine;
				Main.process( ip.w, ip.h, ip.lines ).should.be( noMineResult );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { w: parseInt( lines[0] ), h: parseInt( lines[1] ), lines: lines.slice( 2 ) };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final leftBorder = parseInput(
		"16
		3
		................
		x...............
		................"
	);

	final leftBorderResult = parseResult(
		"11..............
		.1..............
		11.............."
	);
	
	final rightBorder = parseInput(
		"16
		3
		................
		...............x
		................"
	);

	final rightBorderResult = parseResult(
		"..............11
		..............1.
		..............11"
	);
	
	final oneMine = parseInput(
		"16
		9
		................
		................
		................
		................
		................
		....x...........
		................
		................
		................"
	);

	final oneMineResult = parseResult(
		"................
		................
		................
		................
		...111..........
		...1.1..........
		...111..........
		................
		................"
	);

	final manyMines = parseInput(
		"10
		7
		..........
		.x...x...x
		..x......x
		.....x....
		..x.x...x.
		x.........
		.x...x...x"
	);

	final manyMinesResult = parseResult(
		"111.111.11
		1.211.1.2.
		12.1222.2.
		.2232.1122
		12.2.211.1
		.322221122
		2.1.1.1.1."
	);

	final lotOfMines = parseInput(
		"16
		11
		..xxxxxx..x.x...
		.xx...xxx....xxx
		x.xxxx.xxx...xxx
		xxxxxxxxxx..xxxx
		...xx..x..xxxx..
		xx.xx.xxxx..x...
		xxxxxx.....x..xx
		xx......xxx..xxx
		xxxxxxxxxxxxxxxx
		xxx.xxx......xx.
		........xxxxxxxx"
	);

	final lotOfMinesResult = parseResult(
		"13......32.2.332
		2..766...4223...
		.7....7...214...
		..........44....
		456..66.75....42
		..6..5....45.432
		......34554.34..
		..766544...55...
		................
		...5...556667..5
		23222322........"
	);

	final noMine = parseInput(
		"26
		12
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		.........................."
	);

	final noMineResult = parseResult(
		"..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		..........................
		.........................."
	);

}

