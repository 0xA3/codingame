package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Basic", {
				final ip = simple;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 6 );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 8 );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 5 );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 7 );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 9 );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 5 );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 3 );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 8 );
			});
			it( "Test 9", {
				final ip = test9;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 9 );
			});
			it( "Lizzo is making this too hard", {
				final ip = lizzoIsMakingThisTooHard;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 8 );
			});
			it( "One Button", {
				final ip = oneButton;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 7 );
			});
			it( "Now you're just Messing Around", {
				final ip = nowYoureJustMessingAround;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 1 );
			});
			it( "Test 13", {
				final ip = test13;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 6 );
			});
			it( "Test 14", {
				final ip = test14;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 4 );
			});
			it( "Test 15", {
				final ip = test15;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 8 );
			});
			it( "Test 16", {
				final ip = test16;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 4 );
			});
			it( "Test 17", {
				final ip = test17;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 5 );
			});
			it( "Test 18", {
				final ip = test18;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 7 );
			});
			it( "Test 19", {
				final ip = test19;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 8 );
			});
			it( "Test 20", {
				final ip = test20;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 3 );
			});
			it( "Test 21", {
				final ip = test21;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 3 );
			});
			it( "Test 22", {
				final ip = test22;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 9 );
			});
			it( "Test 23", {
				final ip = test23;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 1 );
			});
			it( "Test 24", {
				final ip = test24;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 4 );
			});
			it( "Test 25", {
				final ip = test25;
				Main.process( ip.rows, ip.allButtonsPressed ).should.be( 7 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final rows = [for( i in 0...3 ) lines[i]];
		final allButtonsPressed = lines[3].split( "" ).map( s -> parseInt( s ));
		
		return { rows: rows, allButtonsPressed: allButtonsPressed }
	}

	final simple = parseInput(
	"~ * ~
	~ ~ ~
	~ * ~
	884" );

	final test2 = parseInput(
	"~ ~ *
	* * ~
	* * ~
	45" );

	final test3 = parseInput(
	"~ ~ *
	~ ~ *
	* * *
	24618" );

	final test4 = parseInput(
	"~ ~ *
	~ ~ ~
	~ ~ ~
	485" );

	final test5 = parseInput(
	"* * *
	* ~ *
	* ~ ~
	5741" );

	final test6 = parseInput(
	"~ * *
	* * ~
	~ * ~
	56421" );

	final test7 = parseInput(
	"* ~ *
	~ ~ *
	* * *
	687" );

	final test8 = parseInput(
	"* * ~
	~ ~ ~
	* * ~
	39246" );

	final test9 = parseInput(
	"* * *
	* * ~
	* ~ ~
	1212" );

	final lizzoIsMakingThisTooHard = parseInput(
	"* * *
	* ~ *
	~ ~ ~
	987654321987654321987654321987654321" );

	final oneButton = parseInput(
	"* ~ ~
	~ ~ ~
	~ ~ *
	3" );

	final nowYoureJustMessingAround = parseInput(
	"~ ~ *
	~ * *
	* * *
	5555555555" );

	final test13 = parseInput(
	"* ~ ~
	* * *
	~ ~ ~
	2137" );

	final test14 = parseInput(
	"* ~ *
	* ~ ~
	* * *
	981" );

	final test15 = parseInput(
	"* ~ ~
	~ ~ ~
	~ * *
	641117" );

	final test16 = parseInput(
	"* ~ ~
	~ * *
	~ ~ *
	13665" );

	final test17 = parseInput(
	"~ ~ *
	* ~ ~
	~ * *
	9951234" );

	final test18 = parseInput(
	"~ ~ *
	~ * ~
	* * ~
	32579" );

	final test19 = parseInput(
	"~ * ~
	~ * ~
	~ * ~
	25" );

	final test20 = parseInput(
	"* * *
	* * ~
	* ~ *
	5678" );

	final test21 = parseInput(
	"~ ~ ~
	~ * ~
	~ * *
	4" );

	final test22 = parseInput(
	"* ~ *
	~ * *
	* * ~
	4682" );

	final test23 = parseInput(
	"~ * ~
	* * *
	~ * ~
	98765432" );

	final test24 = parseInput(
	"* ~ *
	* ~ ~
	* * ~
	36517" );

	final test25 = parseInput(
	"* * ~
	~ * *
	~ ~ *
	321569" );
}
