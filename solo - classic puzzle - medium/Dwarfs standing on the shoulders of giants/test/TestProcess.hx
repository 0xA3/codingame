package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple example", Main.process( simpleExample ).should.be( 3 ));
			it( "Complete example", Main.process( completeExample ).should.be( 4 ));
			it( "Several mentors", Main.process( severalMentors ).should.be( 3 ));
			it( "Several mentors 2", Main.process( severalMentors2 ).should.be( 5 ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 ).map( line -> line.split(" ").map( s -> parseInt( s )));
	}

	final simpleExample = parseInput(
		"3
		1 2
		1 3
		3 4" );

	final completeExample = parseInput(
		"8
		1 2
		1 3
		3 4
		2 4
		2 5
		10 11
		10 1
		10 3" );

	final severalMentors = parseInput(
		"4
		2 3
		8 9
		1 2
		6 3" );

	final severalMentors2 = parseInput(
		"9
		7 2
		8 9
		1 6
		6 9
		1 7
		1 2
		3 9
		2 3
		6 3" );
}
