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
			it( "The Example", {
				final ip = theExample;
				Main.process( ip.w, ip.h, ip.t ).should.be( theExampleResult );
			});
			it( "Half Black half white", {
				final ip = halfBlackHalfWhite;
				Main.process( ip.w, ip.h, ip.t ).should.be( halfBlackHalfWhiteResult );
			});
			it( "Hello", {
				final ip = hello;
				Main.process( ip.w, ip.h, ip.t ).should.be( helloResult );
			});
			it( "Heart", {
				final ip = heart;
				Main.process( ip.w, ip.h, ip.t ).should.be( heartResult );
			});
			it( "Inverse", {
				final ip = inverse;
				Main.process( ip.w, ip.h, ip.t ).should.be( inverseResult );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final w = parseInt( lines[0] );
		final h = parseInt( lines[1] );
		final t = lines[2];
		
		return { w: w, h: h, t: t };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final theExample = parseInput(
		"8
		3
		10 10 4"
	);

	final theExampleResult = parseResult(
		"|********|
		|**      |
		|    ****|"
	);

	final halfBlackHalfWhite = parseInput(
		"32
		6
		93 99"
	);

	final halfBlackHalfWhiteResult = parseResult(
		"|********************************|
		|********************************|
		|*****************************   |
		|                                |
		|                                |
		|                                |"
	);

	final hello = parseInput(
		"16
		9
		16 18 2 2 2 3 2 5 2 2 2 10 6 3 2 5 2 2 2 3 2 5 2 2 2 3 2 19 16"
	);

	final helloResult = parseResult(
		"|****************|
		|                |
		|  **  **   **   |
		|  **  **        |
		|  ******   **   |
		|  **  **   **   |
		|  **  **   **   |
		|                |
		|****************|"
	);

	final heart = parseInput(
		"23
		7
		6 4 3 4 11 6 1 6 11 11 13 9 16 6 18 4 20 2 10"
	);

	final heartResult = parseResult(
		"|******    ***    ******|
		|*****      *      *****|
		|******           ******|
		|*******         *******|
		|*********      ********|
		|**********    *********|
		|***********  **********|"
	);

	final inverse = parseInput(
		"23
		7
		0 6 4 3 4 11 6 1 6 11 11 13 9 16 6 18 4 20 2 10"
	);

	final inverseResult = parseResult(
		"|      ****   ****      |
		|     ****** ******     |
		|      ***********      |
		|       *********       |
		|         ******        |
		|          ****         |
		|           **          |"
	);

}

