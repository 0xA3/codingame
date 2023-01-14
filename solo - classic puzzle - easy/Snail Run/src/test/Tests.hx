package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test Run", {
				final ip = testRun;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 1 );
			});
			it( "Simple Run", {
				final ip = simpleRun;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 3 );
			});
			it( "Run in progress", {
				final ip = runInProgress;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 3 );
			});
			it( "only one arrives", {
				final ip = onlyOneArrives;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 1 );
			});
			it( "In a mess", {
				final ip = inAMess;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 3 );
			});
			it( "Conversely", {
				final ip = conversely;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 3 );
			});
			it( "difficult 1", {
				final ip = difficult1;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 3 );
			});
			it( "diffcult 2", {
				final ip = difficult2;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 3 );
			});
			it( "diffcult 3", {
				final ip = difficult3;
				Main.process( ip.numberSnails, ip.snailSpeeds, ip.mapWidth, ip.mapHeight, ip.rows ).should.be( 2 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final numberSnails = parseInt( lines[0] );
		final snailSpeeds = [for( i in 0...numberSnails ) parseInt( lines[i + 1] )];
		final mapHeight = parseInt( lines[numberSnails + 1] );
		final mapWidth = parseInt( lines[numberSnails + 2] );
		final rows = [for( i in 0...mapHeight ) lines[numberSnails + 3 + i].split( "" )];

		return {
			numberSnails: numberSnails,
			snailSpeeds: snailSpeeds,
			mapWidth: mapWidth,
			mapHeight: mapHeight,
			rows: rows
		}
	}

	static final testRun = parseInput(
	"1
	1
	1
	6
	1****#" );

	static final simpleRun = parseInput(
	"3
	2
	3
	5
	3
	6
	1****#
	2****#
	3****#" );

	static final runInProgress = parseInput(
	"4
	1
	3
	4
	1
	4
	6
	**1**#
	*2***#
	**3**#
	**4**#" );

	static final onlyOneArrives = parseInput(
	"3
	3
	1
	2
	3
	8
	1*******
	2******#
	3*******" );

	static final inAMess = parseInput(
	"3
	4
	2
	2
	3
	7
	12****3
	*******
	******#" );

	static final conversely = parseInput(
	"5
	1
	1
	2
	1
	1
	5
	7
	#*****1
	#*****2
	#*****3
	#*****4
	#*****5" );

	static final difficult1 = parseInput(
	"3
	1
	1
	1
	3
	7
	**3****
	****2**
	#*****1" );

	static final difficult2 = parseInput(
	"4
	1
	1
	1
	1
	4
	7
	1******
	****3**
	**#***2
	******4" );

	static final difficult3 = parseInput(
	"2
	1
	1
	3
	6
	1*****
	2****#
	**#***" );
}
