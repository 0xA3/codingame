package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "One aircraft on each side", { Main.process( oneAircraftOnEachSide ).should.be( oneAircraftOnEachSideResult ); });
			it( "Three on the same side", { Main.process( threeOnTheSameSide ).should.be( threeOnTheSameSideResult ); });
			it( "Hold the line", { Main.process( holdTheLine ).should.be( holdTheLineResult ); });
			it( "Don't panic", { Main.process( dontPanic ).should.be( dontPanicResult ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		return lines.slice( 1 );
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final oneAircraftOnEachSide = parseInput(
	"6
	....................
	.>..................
	...................<
	....................
	....................
	_________^__________" );

	final oneAircraftOnEachSideResult = parseResult(
	"WAIT
	WAIT
	WAIT
	SHOOT
	WAIT
	WAIT
	SHOOT" );

	final threeOnTheSameSide = parseInput(
	"6
	>...................
	>...................
	>...................
	....................
	....................
	_________^__________" );

	final threeOnTheSameSideResult = parseResult(
	"WAIT
	WAIT
	WAIT
	SHOOT
	SHOOT
	SHOOT" );

	final holdTheLine = parseInput(
	"2
	...<<<<<<<<<<<<<<<<<<<<<<<..<<<
	^______________________________" );

	final holdTheLineResult = parseResult(
	"WAIT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	WAIT
	WAIT
	SHOOT
	SHOOT
	SHOOT" );

	final dontPanic = parseInput(
	"10
	...........................<...........
	.......................................
	.......................................
	.......................................
	............<..<..<..<..<..<..<..<..<..
	.......................................
	.......................................
	.......................................
	..>......<..<..<..<..<..<..<..<..<..<..
	______^________________________________" );

	final dontPanicResult = parseResult(
	"SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	WAIT
	SHOOT
	SHOOT
	WAIT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	SHOOT
	WAIT
	SHOOT
	SHOOT
	WAIT
	SHOOT
	SHOOT
	WAIT
	SHOOT
	SHOOT
	WAIT
	SHOOT
	SHOOT
	WAIT
	WAIT
	SHOOT" );
}
