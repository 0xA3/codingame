package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test process", {
			it( "One player, only roads", { Main.process( onePlayerOnlyRoads ).should.be( "A 6" ); });
			it( "One player", { Main.process( onePlayer ).should.be( "A 6" ); });
			it( "Not long enough", { Main.process( notLongEnough ).should.be( "0" ); });
			it( "Two players", { Main.process( twoPlayers ).should.be( "B 6" ); });
			it( "Four players and overlapping roads", { Main.process( fourPlayersAndOpverlappingRoads ).should.be( "B 6" ); });
			it( "Loops and branches", { Main.process( loopsAndBranches ).should.be( "B 6" ); });
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
				
		return lines.slice( 1 );
	}


	final onePlayerOnlyRoads = parseInput(
		"5
		#a###
		#a###
		#a###
		#aa##
		##a##"
	);

	final onePlayer = parseInput(
		"5
		aa#a#
		#A#aA
		#a##a
		#aa##
		##a##"
	);

	final notLongEnough = parseInput(
		"5
		#####
		#A###
		#a###
		#aA##
		##aa#"
	);

	final twoPlayers = parseInput(
		"5
		#A#bb
		#a##b
		####B
		#Aa#b
		##abb"
	);

	final fourPlayersAndOpverlappingRoads = parseInput(
		"10
		Bb###aA###
		b#Cc#a####
		###c#a####
		###ccCccc#
		#####a####
		#####aAaaa
		######d###
		#dBbb#D###
		#d####d###
		#D####d###"
	);

	final loopsAndBranches = parseInput(
		"5
		aaaaa
		A#a#a
		aaaa#
		#a###
		aaaaa"
	);

}

