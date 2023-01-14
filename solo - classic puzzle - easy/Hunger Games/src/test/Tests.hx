package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Test 1", {
				final input = test1;
				Main.process( input.playerNames, input.infos ).should.be( test1Result );
			});
			
			it( "A few more", {
				final input = aFewMore;
				Main.process( input.playerNames, input.infos ).should.be( aFewMoreResult );
			});
			
			it( "Serial Killers", {
				final input = serialKillers;
				Main.process( input.playerNames, input.infos ).should.be( serialKillersResult );
			});
			
			it( "Line Killers", {
				final input = lineKillers;
				Main.process( input.playerNames, input.infos ).should.be( lineKillersResult );
			});
			
			it( "Alphabetize Tributes", {
				final input = alphabetizeTributes;
				Main.process( input.playerNames, input.infos ).should.be( alphabetizeTributesResult );
			});
			
			it( "Alphabize Victims", {
				final input = alphabetizeVictims;
				Main.process( input.playerNames, input.infos ).should.be( alphabetizeVictimsResult );
			});
			
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final tributes = parseInt( lines[0] );
		final playerNames = lines.slice( 1, tributes + 1 );
		
		final turns = parseInt( lines[tributes + 1] );
		final infos = lines.slice( 1 + tributes + 1 );
		return { playerNames: playerNames, infos: infos };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final test1 = parseInput(
		"2
		Bowser
		Mario
		1
		Mario killed Bowser" );
	
	final test1Result = parseResult(
		"Name: Bowser
		Killed: None
		Killer: Mario
		
		Name: Mario
		Killed: Bowser
		Killer: Winner" );
	
	
	final aFewMore = parseInput(
		"5
		Ann
		Isaac
		Mary
		Max
		Thomas
		4
		Max killed Isaac
		Isaac killed Mary
		Mary killed Max
		Thomas killed Ann" );

	final aFewMoreResult = parseResult(
		"Name: Ann
		Killed: None
		Killer: Thomas
		
		Name: Isaac
		Killed: Mary
		Killer: Max
		
		Name: Mary
		Killed: Max
		Killer: Isaac
		
		Name: Max
		Killed: Isaac
		Killer: Mary
		
		Name: Thomas
		Killed: Ann
		Killer: Winner"	);

	final serialKillers = parseInput(
		"4
		Foo
		Bar
		Foobar
		Sam
		1
		Foo killed Bar, Foobar, Sam" );

	final serialKillersResult = parseResult(
		"Name: Bar
		Killed: None
		Killer: Foo
		
		Name: Foo
		Killed: Bar, Foobar, Sam
		Killer: Winner
		
		Name: Foobar
		Killed: None
		Killer: Foo
		
		Name: Sam
		Killed: None
		Killer: Foo" );

	final lineKillers = parseInput(
		"4
		Dude
		Him
		Killed
		This
		3
		Dude killed Him
		Dude killed Killed
		Dude killed This" );

	final lineKillersResult = parseResult(
		"Name: Dude
		Killed: Him, Killed, This
		Killer: Winner
		
		Name: Him
		Killed: None
		Killer: Dude
		
		Name: Killed
		Killed: None
		Killer: Dude
		
		Name: This
		Killed: None
		Killer: Dude" );

	final alphabetizeTributes = parseInput(
		"4
		Zulu
		Whiskey
		Charlie
		Alpha
		2
		Charlie killed Alpha
		Whiskey killed Charlie, Zulu" );

	final alphabetizeTributesResult = parseResult(
		"Name: Alpha
		Killed: None
		Killer: Charlie
		
		Name: Charlie
		Killed: Alpha
		Killer: Whiskey
		
		Name: Whiskey
		Killed: Charlie, Zulu
		Killer: Winner
		
		Name: Zulu
		Killed: None
		Killer: Whiskey" );

	final alphabetizeVictims = parseInput(
		"10
		Marco
		Sophie
		Diamond
		Lester
		Steve
		Hawkings
		Harry
		Potter
		Michael
		Scott
		6
		Marco killed Sophie, Diamond
		Sophie killed Lester
		Sophie killed Scott
		Michael killed Harry
		Harry killed Potter
		Potter killed Hawkings, Steve, Marco" );

	final alphabetizeVictimsResult = parseResult(
		"Name: Diamond
		Killed: None
		Killer: Marco
		
		Name: Harry
		Killed: Potter
		Killer: Michael
		
		Name: Hawkings
		Killed: None
		Killer: Potter
		
		Name: Lester
		Killed: None
		Killer: Sophie
		
		Name: Marco
		Killed: Diamond, Sophie
		Killer: Potter
		
		Name: Michael
		Killed: Harry
		Killer: Winner
		
		Name: Potter
		Killed: Hawkings, Marco, Steve
		Killer: Harry
		
		Name: Scott
		Killed: None
		Killer: Sophie
		
		Name: Sophie
		Killed: Lester, Scott
		Killer: Marco
		
		Name: Steve
		Killed: None
		Killer: Potter"	);

}

