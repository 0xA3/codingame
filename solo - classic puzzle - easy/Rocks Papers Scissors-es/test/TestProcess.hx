package test;

import Main.parseMove;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", Main.process( example ).should.be( exampleResult ));
			it( "Easy Win", Main.process( easyWin ).should.be( easyWinResult ));
			it( "Draw Doesn't Stop The Match", Main.process( drawDoesntStopTheMatch ).should.be( drawDoesntStopTheMatchResult ));
			it( "Round The Clock", Main.process( roundTheClock ).should.be( roundTheClockResult ));
			it( "Tiebreaker", Main.process( tiebreaker ).should.be( tiebreakerResult ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 ).map( s -> parseMove( s ));
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final example = parseInput(
		"6
		Scissors
		Paper
		Rock
		Paper
		Scissors
		Rock" );
	
	final exampleResult = parseResult(
		"Rock
		4" );
	
	final easyWin = parseInput(
		"4
		Paper
		Paper
		Paper
		Rock" );
	
	final easyWinResult = parseResult(
		"Scissors
		0" );
		
	final drawDoesntStopTheMatch = parseInput(
		"7
		Paper
		Rock
		Paper
		Rock
		Paper
		Rock
		Scissors" );
	
	final drawDoesntStopTheMatchResult = parseResult(
		"Paper
		1" );

	final roundTheClock = parseInput(
		"5
		Rock
		Scissors
		Paper
		Rock
		Rock" );
	
	final roundTheClockResult = parseResult(
		"Paper
		3" );
		
	final tiebreaker = parseInput(
		"10
		Rock
		Scissors
		Scissors
		Scissors
		Paper
		Rock
		Rock
		Rock
		Scissors
		Paper" );
	
	final tiebreakerResult = parseResult(
		"Rock
		1" );
}
