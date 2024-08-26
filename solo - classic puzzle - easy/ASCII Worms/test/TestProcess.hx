package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Just a normal worm", {
				final ip = justANormalWorm;
				Main.process( ip.thickness, ip.length, ip.turns ).should.be( justANormalWormResult );
			});
			it( "Tiny worm", {
				final ip = tinyWorm;
				Main.process( ip.thickness, ip.length, ip.turns ).should.be( tinyWormResult );
			});
			it( "HUGE worm!", {
				final ip = hugeWorm;
				Main.process( ip.thickness, ip.length, ip.turns ).should.be( hugeWormResult );
			});
			it( "Gives me scoleciphobia", {
				final ip = givesMeScoleciphobia;
				Main.process( ip.thickness, ip.length, ip.turns ).should.be( givesMeScoleciphobiaResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final thickness = parseInt( lines[0] );
		final length = parseInt( lines[1] );
		final turns = parseInt( lines[2] );
	
		return { thickness: thickness, length: length, turns: turns };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final justANormalWorm = parseInput(
		"2
		5
		4"
	);

	final justANormalWormResult = parseResult(
		" __ _____ _____
		|  |     |     |
		|  |  |  |  |  |
		|  |  |  |  |  |
		|  |  |  |  |  |
		|_____|_____|__|"
	);

	final tinyWorm = parseInput(
		"1
		2
		2"
	);

	final tinyWormResult = parseResult(
		" _ ___
		| |   |
		|___|_|"
	);

	final hugeWorm = parseInput(
		"5
		8
		4"
	);

	final hugeWormResult = parseResult(
		" _____ ___________ ___________
		|     |           |           |
		|     |     |     |     |     |
		|     |     |     |     |     |
		|     |     |     |     |     |
		|     |     |     |     |     |
		|     |     |     |     |     |
		|     |     |     |     |     |
		|___________|___________|_____|"
	);

	final givesMeScoleciphobia = parseInput(
		"1
		15
		15"
	);

	final givesMeScoleciphobiaResult = parseResult(
		" _ ___ ___ ___ ___ ___ ___ ___ _
		| |   |   |   |   |   |   |   | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		| | | | | | | | | | | | | | | | |
		|___|___|___|___|___|___|___|___|"
	);
}
