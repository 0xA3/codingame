package test;

import CompileTime.readFile;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {
		//
		// Tests don't work because of UTF-8 problem but python solution does work on codinGame
		//
		
		describe( "Test process", {
			@include it( "Test 1 - 1 of value", {
				final ip = parseInput( readFile( "test/test_01.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$12" );
			});
			it( "Test 2 - 2 of value", {
				final ip = parseInput( readFile( "test/test_02.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$16" );
			});
			it( "Test 3 - several of value", {
				final ip = parseInput( readFile( "test/test_03.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$27" );
			});
			it( "Test 4 - multiples of same plant", {
				final ip = parseInput( readFile( "test/test_04.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$61" );
			});
			it( "Test 5 - big garden", {
				final ip = parseInput( readFile( "test/test_05.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$47" );
			});
			it( "Test 6 - giant garden", {
				final ip = parseInput( readFile( "test/test_06.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$400" );
			});
			it( "Test 7 - profitable", {
				final ip = parseInput( readFile( "test/test_07.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$3,170" );
			});
			it( "Test 8 - well kept and profitable", {
				final ip = parseInput( readFile( "test/test_08.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$5,484" );
			});
			it( "Test 9 - no weeds and lots of offers", {
				final ip = parseInput( readFile( "test/test_09.txt" ));
				Main.process( ip.offers, ip.garden ).should.be( "$12,574" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final numOfLinesOfOfferingStatement = parseInt( lines[0] );
		final offers = [for( i in 0...numOfLinesOfOfferingStatement ) lines[i + 1]];
		
		final gardenHeight = parseInt( lines[numOfLinesOfOfferingStatement + 1] );
		final garden = [for( i in 0...gardenHeight ) lines[numOfLinesOfOfferingStatement + 2]].join( "" );

		return { offers: offers, garden: garden }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
