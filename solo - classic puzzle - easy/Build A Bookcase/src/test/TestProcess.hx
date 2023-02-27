package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test4Result );
			});
			it( "Test 5", {	
				final ip = test5;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test5Result );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test6Result );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.height, ip.width, ip.numberOfShelves ).should.be( test7Result );
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final height = parseInt( lines[0] );
		final width = parseInt( lines[1] );
		final numberOfShelves = parseInt( lines[2] );

		return { height: height, width: width, numberOfShelves: numberOfShelves };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
	"8
	13
	3" );

	final test1Result = parseResult(
	"//////^\\\\\\\\\\\\
	|           |
	|___________|
	|           |
	|___________|
	|           |
	|           |
	|___________|" );

	final test2 = parseInput(
	"11
	15
	4" );

	final test2Result = parseResult(
	"///////^\\\\\\\\\\\\\\
	|             |
	|_____________|
	|             |
	|_____________|
	|             |
	|             |
	|_____________|
	|             |
	|             |
	|_____________|" );

	final test3 = parseInput(
	"10
	6
	5" );

	final test3Result = parseResult(
	"///\\\\\\
	|____|
	|    |
	|____|
	|    |
	|____|
	|    |
	|____|
	|    |
	|____|" );

	final test4 = parseInput(
	"31
	17
	16" );

	final test4Result = parseResult(
	"////////^\\\\\\\\\\\\\\\\
	|_______________|
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|
	|               |
	|_______________|" );

	final test5 = parseInput(
	"100
	3
	2" );

	final test5Result = parseResult(
	"/^\\
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	|_|
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	| |
	|_|" );

	final test6 = parseInput(
	"30
	30
	27" );

	final test6Result = parseResult(
	"///////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|____________________________|
	|                            |
	|____________________________|
	|                            |
	|____________________________|" );

	final test7 = parseInput(
	"3
	3
	2" );

	final test7Result = parseResult(
	"/^\\
	|_|
	|_|" );
}
