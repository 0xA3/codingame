package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		// Tests are very slow
		describe( "Test process", {
			
			it( "1 time stamp, timer starts game", Main.process( _1TimeStampTimerStartsGame ).should.be( "0:31" ));
			it( "2 time stamps, timer starts game", Main.process( _2TimeStampsTimerStartsGame ).should.be( "1:40" ));
			it( "4 time stamps, timer starts game", Main.process( _4TimeStampsTimerStartsGame ).should.be( "0:19" ));
			it( "6 time stamps, timer starts game", Main.process( _6TimeStampsTimerStartsGame ).should.be( "2:38" ));
			it( "1 time stamp, timer reaches zero", Main.process( _1timeStampTimerReachesZero ).should.be( "0:00" ));
			it( "2 time stamps, timer reaches zero", Main.process( _2TimeStampsTimerReachesZero ).should.be( "0:00" ));
			it( "4 time stamps, timer reaches zero", Main.process( _4TimeStampsTimerReachesZero ).should.be( "0:00" ));
			it( "6 time stamps, timer reaches zero", Main.process( _6TimeStampsTimerReachesZero ).should.be( "0:00" ));
			it( "7, the room is filled", Main.process( _7TheRoomIsFilled ).should.be( "1:43" ));
			it( "No one joins", Main.process( noOneJoins ).should.be( "NO GAME" ));
			it( "Starting time, but someone joins", Main.process( startingTimeButSomeoneJoins ).should.be( "2:22" ));
			it( "Down to the last seconds", Main.process( downToTheLastSeconds ).should.be( "0:02" ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final n = parseInt( readline());
		final timestamps = [for( _ in 0...n ) readline()];
					
		return timestamps;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final _1TimeStampTimerStartsGame = parseInput(
		"1
		4:47"
	);

	final _2TimeStampsTimerStartsGame = parseInput(
		"2
		3:55
		3:48"
	);

	final _4TimeStampsTimerStartsGame = parseInput(
		"4
		4:32
		2:50
		1:50
		0:51"
	);

	final _6TimeStampsTimerStartsGame = parseInput(
		"6
		4:51
		4:29
		3:42
		2:25
		1:48
		0:29"
	);

	final _1timeStampTimerReachesZero = parseInput(
		"1
		2:14"
	);

	final _2TimeStampsTimerReachesZero = parseInput(
		"2
		4:14
		0:05"
	);

	final _4TimeStampsTimerReachesZero = parseInput(
		"4
		4:36
		2:15
		1:11
		0:19"
	);

	final _6TimeStampsTimerReachesZero = parseInput(
		"6
		3:06
		2:53
		1:32
		0:47
		0:21
		0:06"
	);

	final _7TheRoomIsFilled = parseInput(
		"7
		4:10
		3:29
		2:44
		2:20
		1:56
		1:47
		1:43"
	);

	final noOneJoins = parseInput(
		"0"
	);

	final startingTimeButSomeoneJoins = parseInput(
		"5
		4:21
		4:01
		3:48
		3:10
		2:38"
	);

	final downToTheLastSeconds = parseInput(
		"1
		4:18"
	);
}
