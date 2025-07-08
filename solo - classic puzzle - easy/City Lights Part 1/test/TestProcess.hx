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
			
			it( "1 Town", {
				final ip = _1Town;
				Main.process( ip.w, ip.h, ip.grid ).should.be( _1TownResult );
			});
			it( "2 Towns", {
				final ip = _2Towns;
				Main.process( ip.w, ip.h, ip.grid ).should.be( _2TownsResult );
			});
			it( "More Towns", {
				final ip = moreTowns;
				Main.process( ip.w, ip.h, ip.grid ).should.be( moreTownsResult );
			});
			it( "Rural", {
				final ip = rural;
				Main.process( ip.w, ip.h, ip.grid ).should.be( ruralResult );
			});
			it( "Urban", {
				final ip = urban;
				Main.process( ip.w, ip.h, ip.grid ).should.be( urbanResult );
			});
			it( "TOO MUCH LIGHT", {
				final ip = tooMuchLight;
				Main.process( ip.w, ip.h, ip.grid ).should.be( tooMuchLightResult );
			});
			it( "im blind", {
				final ip = imBlind;
				Main.process( ip.w, ip.h, ip.grid ).should.be( imBlindResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final h = parseInt( readline() );
		final w = parseInt( readline() );
		final grid = [for( _ in 0...h ) readline().split( "" ).map( s -> s == "." ? 0 : Main.BRIGHTNESS_CHARS.indexOf( s ))];
		
		return  { h:h, w:w,	grid:grid }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final _1Town = parseInput(
		"5
		5
		.....
		.....
		..3..
		.....
		....."
	);
	
	final _1TownResult = parseResult(
		"01110
		12221
		12321
		12221
		01110"
	);

	final _2Towns = parseInput(
		"7
		5
		.....
		....5
		.....
		.....
		.4...
		.....
		....."
	);
	
	final _2TownsResult = parseResult(
		"12344
		23445
		34554
		44554
		35443
		33432
		22210"
	);

	final moreTowns = parseInput(
		"8
		7
		.....6.
		.......
		.......
		.4.....
		.....2.
		.......
		..3....
		......."
	);
	
	final moreTownsResult = parseResult(
		"2344565
		3455555
		4555544
		3554544
		3455443
		3444322
		2342100
		1222100"
	);

	final rural = parseInput(
		"10
		10
		.....1....
		....1.....
		..........
		...2......
		..........
		.....1...1
		..........
		..........
		1.........
		1........."
	);
	
	final ruralResult = parseResult(
		"0000010000
		0000100000
		0011100000
		0012100000
		0011100000
		0000010001
		0000000000
		0000000000
		1000000000
		1000000000"
	);

	final urban = parseInput(
		"10
		11
		...5.......
		...........
		....4....1.
		...3.......
		...........
		.......7...
		...........
		.....2.....
		.1....1....
		.....8....."
	);
	
	final urbanResult = parseResult(
		"23587753221
		2489A975332
		148BDA87443
		159DCBA8653
		158BCCA9875
		2369AAAB976
		2467ABCAA86
		3568ACCA986
		3568BBDA976
		34679BA9875"
	);

	final tooMuchLight = parseInput(
		"12
		14
		..4....5......
		.....5........
		..............
		......78......
		..............
		..............
		..............
		.......B......
		..............
		.....6........
		..............
		.............5"
	);
	
	final tooMuchLightResult = parseResult(
		"38CGIKLLIFB843
		6BEIKOONLHDB75
		5AEJLOQPNJEC85
		5ADGKNQPMJFB96
		58CGKNPOMIFC96
		69DHILNNKGEDA7
		48CFIKMLKHEB86
		59BEIKLLJHDB97
		57BEHJKJIFDA97
		579CEHHGFDAA98
		468ACDEDCBA998
		4678ABBA9A9899"
	);

	final imBlind = parseInput(
		"15
		10
		......F...
		..........
		...1.....1
		.......2..
		........E.
		..........
		2.........
		..........
		........H.
		..........
		..........
		..........
		...4......
		..........
		.....2...1"
	);
	
	final imBlindResult = parseResult(
		"KMPSTVYXWV
		KNQSVXYZYX
		MPSUWXZZZZ
		MORUWYZZZZ
		MPRUWYZZZZ
		MPRTWYZZZZ
		OPRTWWYZZZ
		LNPRUWXZZY
		JMOQSUWXYW
		IKNQSSUVVV
		GKNPRQRSSS
		EILNPPPPPP
		EGJNMMNMMM
		CEGJLLLJJJ
		8BDFHIHGGH"
	);
}