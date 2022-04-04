package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test random", {
			
            var prng:PseudoRandomNumberGenerator;

			beforeEach({
                prng = new PseudoRandomNumberGenerator( 31 );
            });
			
			it( "random 1", {
				prng.random().should.be( 139 );
			});
			
			it( "random 2", {
				var r = 0.;
				for( _ in 0...2 ) r = prng.random();
				r.should.be( 492 );
			});
			
			it( "random 3", {
				var r = 0.;
				for( _ in 0...3 ) r = prng.random();
				r.should.be( 1645 );
			});
			
			it( "random 4", {
				var r = 0.;
				for( _ in 0...4 ) r = prng.random();
				r.should.be( 5410 );
			});
			
			it( "random 5", {
				var r = 0.;
				for( _ in 0...5 ) r = prng.random();
				r.should.be( 17705 );
			});
		});

		describe( "Test process", {
			
			it( "Simple level", {
				final ip = parseInput( "6 6 7 3 3 31" );
				Main.process( ip.width, ip.height, ip.mines, ip.x, ip.y, ip.seed ).should.be( simpleLevelResult );
			});
			
			it( "Corner selection", {
				final ip = parseInput( "6 6 6 0 0 3" );
				Main.process( ip.width, ip.height, ip.mines, ip.x, ip.y, ip.seed ).should.be( cornerSelectionResult );
			});
			
			it( "Edge selection", {
				final ip = parseInput( "6 6 6 2 0 31" );
				Main.process( ip.width, ip.height, ip.mines, ip.x, ip.y, ip.seed ).should.be( edgeSelectionResult );
			});
			
			it( "Beginner level", {
				final ip = parseInput( "9 9 10 4 4 1" );
				Main.process( ip.width, ip.height, ip.mines, ip.x, ip.y, ip.seed ).should.be( beginnerLevelResult );
			});
			
			it( "Intermediate level", {
				final ip = parseInput( "16 16 40 8 8 17" );
				Main.process( ip.width, ip.height, ip.mines, ip.x, ip.y, ip.seed ).should.be( intermediateLevelResult );
			});
			
			it( "Expert level", {
				final ip = parseInput( "30 16 99 15 8 17" );
				Main.process( ip.width, ip.height, ip.mines, ip.x, ip.y, ip.seed ).should.be( expertLevelResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final inputs = input.split(' ');
		final width = parseInt(inputs[0]);
		final height = parseInt(inputs[1]);
		final mines = parseInt(inputs[2]);
		final x = parseInt(inputs[3]);
		final y = parseInt(inputs[4]);
		final seed = parseInt(inputs[5]);
		
		return { width: width, height: height, mines: mines, x: x, y: y, seed: seed };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simpleLevelResult = parseResult(
		"1#2##1
		222221
		#1..11
		331.1#
		##1.11
		221..." );
	
	final cornerSelectionResult = parseResult(
		"...111
		...1#1
		11.122
		#1112#
		122#32
		.1#3#1" );
	
	final edgeSelectionResult = parseResult(
		"...1#1
		.11211
		.1#111
		13432#
		1###21
		12321." );
	
	final beginnerLevelResult = parseResult(
		"11..11211
		#1..1#2#1
		11..11211
		111....11
		1#1....1#
		111..1121
		.111.1#21
		.1#21223#
		.12#11#21" );
	
	final intermediateLevelResult = parseResult(
		".1#1.1#1....1#1.
		.1111221..11211.
		....1#11222#2221
		....1112##213##1
		......13#31.2#31
		1221..1#21..111.
		2##1..111111111.
		3#41.....1#12#2.
		2#311....1123#31
		223#31.....2#5#1
		#23##2111..2##32
		12#5#33#311134#1
		.12#22##3#211#21
		.122112222#2332.
		.1#1.....112##1.
		.111.......1221." );
	
	final expertLevelResult = parseResult(
		"112#1....1#2#22##1..112#1.....
		1#322....11223#321.13#311.....
		222#211....13#3211.2##21221122
		#3213#311..1##43#213#311##11##
		##213#4#2..123##22#211.1221133
		233#213#311..2331222..111.112#
		.1#222322#1..1#1.1#21.1#212#43
		.1222##233422221.23#1.112#34##
		..2#544#2###2#1.13#3211.224###
		..2###322343211.1##22#311#3#64
		.12455#213#2....12223##32233##
		.1#2##22#4#2...12333#4##22#34#
		133322112#21...1####3335#32#21
		1##1..12321....1234#32#3#33231
		1221..1##21.......12#2122#3#3#
		......123#1........111..113#31" );
	

}

