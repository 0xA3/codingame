package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Action", Main.process( action ).should.be( actionResult ));
			it( "Fire", Main.process( fire ).should.be( fireResult ));
			it( "Not Alone", Main.process( notAlone ).should.be( notAloneResult ));
			it( "Example", Main.process( example ).should.be( exampleResult ));
			it( "Screams", Main.process( screams ).should.be( screamsResult ));
			it( "Pointless", Main.process( pointless ).should.be( pointlessResult ));
			it( "CodinGame", Main.process( codinGame ).should.be( codinGameResult ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final action = parseInput(
		"1
		act, action, deed, move, step"
	);

	final actionResult = parseResult(
		"action: act"
	);

	final fire = parseInput(
		"1
		burnable, dangerous, flammable, inflammable"
	);

	final fireResult = parseResult(
		"inflammable: flammable"
	);

	final notAlone = parseInput(
		"1
		alone, lone, one"
	);

	final notAloneResult = parseResult(
		"alone: lone, one
		lone: one"
	);

	final example = parseInput(
		"2
		detect, examine, inspect, note, see, observe
		bag, box, can, container, tank, tin"
	);

	final exampleResult = parseResult(
		"container: can, tin
		observe: see"
	);

	final screams = parseInput(
		"2
		aaaah, aaah, aah, ah
		oh, ooh, oooh, ooooh"
	);

	final screamsResult = parseResult(
		"aaaah: aaah, aah, ah
		aaah: aah, ah
		aah: ah
		ooh: oh
		oooh: oh, ooh
		ooooh: oh, ooh, oooh"
	);

	final pointless = parseInput(
		"5
		aimless, fruitless, futile, pointless
		blunder, fail, flopp, miss
		bare, blank, empty, vacant, void
		boring, dull, mundane, stupid
		redundant, superfluous"
	);

	final pointlessResult = parseResult(
		"NONE"
	);

	final codinGame = parseInput(
		"2
		educator, instructor, lecturer, mentor, teacher, tutor
		absorbing, amusing, captivating, enjoyable, entertaining, fun, funny, lively, pleasant"
	);

	final codinGameResult = parseResult(
		"funny: fun
		instructor: tutor"
	);
}
