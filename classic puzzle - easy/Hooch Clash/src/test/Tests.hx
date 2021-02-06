package test;

import haxe.Int64;
import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		@exclude
		describe( "Test volumeOf", {
			
			it( "Volume of 1", {
				Main.volumeOf( 2 ).should.beCloseTo( 4.188790 );
			});

		});	
			
		describe( "Test process", {
			
			it( "This is fun!", {
				final k = parseInput(
					// "1 1000
					"1 12
					9 10" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "1 12" );
			});
			
			it( "This is valid!", {
				final k = parseInput(
					"1 1000
					5 7" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "VALID" );
			});
			
			it( "Fun enough", {
				final k = parseInput(
					"1 1000
					90 492" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "11 493" );
			});
			
			it( "Whee", {
				final k = parseInput(
					"1 1000
					180 984" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "22 986" );
			});
			
			it( "Higher", {
				final k = parseInput(
					"1000 2000
					1002 1003" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "VALID" );
			});
			
			it( "Much higher", {
				final k = parseInput(
					"1000 3000
					1356 2644" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "1200 2680" );
			});
			
			it( "Crazy High", {
				final k = parseInput(
					"1000 3000
					2511 2962" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "2719 2790" );
			});
			
			it( "Stoned", {
				final k = parseInput(
					"1 3000
					417 2962" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "1290 2881" );
			});
			
			it( "Overflow", {
				final k = parseInput(
					"1 15
					9 15" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "VALID" );
			});
			
			it( "Underflow", {
				final k = parseInput(
					"2 14
					9 10" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "VALID" );
			});
			
			it( "B&B", {
				final k = parseInput(
					"97000 100000
					98500 98500" );
				Main.process( k.orbSizeMin, k.orbsizeMax, k.glowingSize1, k.glowingSize2 ).should.be( "VALID" );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final orbSizeMin = parseInt( inputs[0] );
		final orbSizeMax = parseInt( inputs[1] );
		final inputs = lines[1].split(' ');
		final glowingSize1 = parseInt( inputs[0] );
		final glowingSize2 = parseInt( inputs[1] );
		return { orbSizeMin: orbSizeMin, orbsizeMax: orbSizeMax, glowingSize1: glowingSize1, glowingSize2: glowingSize2 };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

}

