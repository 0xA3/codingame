package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.w, ip.h, ip.lines ).should.be( 8 );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.w, ip.h, ip.lines ).should.be( 33 );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.w, ip.h, ip.lines ).should.be( 10 );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.w, ip.h, ip.lines ).should.be( 151 );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.w, ip.h, ip.lines ).should.be( 150 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final h = parseInt( inputs[0] );
		final w = parseInt( inputs[1] );
		final lines = [for( i in 0...h ) lines[i + 1].split( "" )];
		
		return { w: w, h: h, lines: lines }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final test1 = parseInput(
	"6 6
	G....G
	.G..G.
	..GG..
	..GG..
	.G..G.
	G....G" );

	static final test2 = parseInput(
	"8 12
	GGGGGGGGGGGG
	G....GG....G
	G....GG....G
	G....GG....G
	G....GG....G
	G....GG....G
	G....GG....G
	GGGGGGGGGGGG" );

	static final test3 = parseInput(
	"15 10
	..........
	..........
	..........
	..........
	....GG....
	....GG....
	....GG....
	....GG....
	....GG....
	....GG....
	....GG....
	....GG....
	..........
	..........
	.........." );

	static final test4 = parseInput(
	"20 40
	G.GG..G.GGG..G.GG.G.GGGG....GG.GGG...GGG
	GGGG..GGGGG.GG.G.G.GG.GG..G....G.GG..G.G
	G...GG.GG.GG.GGGGGGGG.GGGGGGGGGG.GGGGG..
	GGGG.GG.GG..G.GGG..GG..GGG.GGG.G.G.GGGG.
	GG..G.G.GG.GGGGGG...G.G..G.GG.G..GG.G..G
	G.GGG.....GGGGGG...GGGGG..GG..GGGG.GGGG.
	GG..GGGGGGGGGG.GGGG.GGGGGGGGGGG.GGGGGGGG
	G.GG....G.GGG..GGGG.GGGGGGGGGG..G.GG.GGG
	.G.G.GG..GGGGGGGGGG.G.GG.GGG.GGGGG..GGGG
	GGGGGGGGGGGG..GGGGGGGGGG....GG.GGGGGGGGG
	.GGGG.G.GGGGG.GGGGGGG..GG.GG.G...GG.G..G
	GG..GGGGGGGGG.GG..G.G.G..GGG.GG..GGGGG..
	GGGG.G..GGGGGGGGGGG.GG.G.G..GG.GG.G.GGG.
	GGGG..GGGGGGG.GGG.GGGGG.GGGG.GG.GGG...GG
	GGGGG.G.G.G...GGGG..G.G.GG...G.G.G.G.G.G
	GGGGG.GGGGGG.G.G.GGG.GGGG.GGG.GG..GGGGGG
	GGGGG.GGGGGGG.GGGGGGGG.GG.G.GGGG.G.GGGGG
	G.G.GGGG..G...GG.GGG.GGGGG.GG.GGGG.GGG..
	GGGGGG.GGGG.G..G..GG.GG.GGGG.GGGGG.GG.GG
	.GGGGGGGGGGGGGGG.G.GGGG...G..GG..GGGGGGG" );

	static final test5 = parseInput(
	"50 50
	GG..G.....G.........GGGG.G..GG..G..G..G........G..
	.......GG..G....G.G....GG.G........GG.....G.......
	.......G.....G...G....................G.........GG
	.....GG.....G..........GGG........G..G.G...G.G.G..
	.GG.G.............G....G..G.GG....GG...G.....G....
	G..G...GGG...G....G.G...G.G.G...G......GG...GG....
	..G.....G.G.G...G.....G..G........................
	.........GG.G...G.G.G...G........GGG.....G....G...
	..G.G.......G............G.......G...........G.G..
	.G.G..G..................G..G...GG...G....GGG.....
	.......GG...G.....G......G.....G......G....G..G..G
	.G.......GGG.G....GG..G........G..G.G.......G.G.G.
	......G.......G...GG..........G..G..G.........G..G
	.....G.......G.....G.....G..G........G.GGG..G.....
	...G.....G..G.G.....G...........GG...........G..G.
	........G..G......G.GG....G...G...G...G.G.GG......
	.....G....G.........G.GG....G....G................
	G......G.....GG.....G.G......G.....G..G......G....
	........G.GG..GG........G.........GGG.G......G....
	....G..G....G..G..................G..G.GG.........
	...G....G...G....G...GG...................G....GGG
	..................G......G..GG.....GG.......G.....
	G.....G.G......GG.G.G...........G.................
	.G......G.......G.......GGGG..........G.......GG..
	......G...........G..G.G..G.G..........G.GG.G.....
	......GG.G.....G..G.GG.........G....G..G....G.GGG.
	..G.GG.............G.G.GG....G...G...GG.G.G.......
	G.......G.G........G....G...G..G..GGGG........G..G
	...GG.........GG.....GG..G......GG....G..GG....G..
	.....G..G...G.............G....G.GG........G.G....
	GG....GG............G..G.G...........GGG....G.....
	.........G.GG.G.....G..G................G.G.......
	..............G..G..............G..G.....G....GG..
	..............G......G......G............G..G.....
	.GG....G..G...................GG..GG..G..G........
	G.G.GG..G..GG...G..G...G.....GG.....GG.G.....G..G.
	....GG.....G.............G....G.GGG....G.........G
	G........G.G...G...G...G.......GG.GG..G.G.G..G...G
	GG.....G........G.......G..........G...G......GG..
	......GG......G.....G..................G.....G....
	.G.G..GG............GG....GG.G....GGG...G...G.....
	...G.....G...G....G...............GG..........G..G
	.........GGG......G.....G.G....G.G................
	GG..G.G...G..G.G...................G..............
	......GG.........G.G...G.........GG...G.........GG
	........G.....G.G..G..G.....GG.................G..
	G.........G..G....G.G..G...G..GG.......G.....G....
	G.G...G..G.GG.G.GG...G..........G.G......G..G.....
	..........G.....G...G.......G...GG.G....GG....G..G
	G...G..G...G............G.G.........G..........G.." );
}
