import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

enum TEvent {
	Try;
	Conversion;
	Penalty;
	DroppedGoal;
	EndOfGame;
}

typedef Event = {
	final timestamp:Int;
	final team:Int;
	final type:TEvent;
}

final eventTypes = [Try, Conversion, Penalty, DroppedGoal];
final eventScores = [Try => 5, Conversion => 2, Penalty => 3, DroppedGoal => 3, EndOfGame => 0];

function main() {

	final teams = readline().split( "," );
	final scores1 = readline();
	final scores2 = readline();

	final result = process( teams, scores1, scores2 );
	print( result );
}

function process( teams:Array<String>, scores1:String, score2:String ) {
	
	final events1 = parseScore( 0, scores1 );
	final events2 = parseScore( 1, score2 );
	final gameEndEvent:Event = { timestamp: 81, team: 0, type: EndOfGame }

	final events = [events1, events2, [gameEndEvent]].flatten();
	events.sort(( a, b ) -> a.timestamp - b.timestamp );

	final teamScores = [0, 0];
	var advantageTimes = [0, 0];
	var lastTimestamp = 0;
	for( event in events ) {
		// printErr( 'Event timestamp: ${event.timestamp} team: ${event.team} type: ${event.type}' );
		final advantageTeam = teamScores[0] == teamScores[1] ? -1 : teamScores[0] > teamScores[1] ? 0 : 1;
		final timeSinceLastEvent = event.timestamp - lastTimestamp;
		
		// printErr( 'Team ${event.team} ${event.type} at time ${event.timestamp}: advantage $timeSinceLastEvent to ${advantageTeam}' );
		teamScores[event.team] += eventScores[event.type];
		if( advantageTeam != -1 ) advantageTimes[advantageTeam] += timeSinceLastEvent;
		
		// printErr( 'Team 1: ${teamScores[0]} Team 2: ${teamScores[1]} advantage time team 1: ${advantageTimes[0]} advantage time team 2: ${advantageTimes[1]}' );
		lastTimestamp = event.timestamp;
	}

	final outputs = [for( i in 0...teams.length ) '${teams[i]}: ${teamScores[i]} ${advantageTimes[i]}'];

	return outputs.join( "\n" );
}

function parseScore( team:Int, s:String ) {
	final tryConversionPenaltyDropped = s.split( "," );

	final events = [];
	for( i in 0...tryConversionPenaltyDropped.length ) {
		final eventType = eventTypes[i];
		final timestampStrings = tryConversionPenaltyDropped[i].split(" ");

		for( timestampString in timestampStrings ) {
			if( timestampString == "" ) continue;

			final timestamp = parseInt( timestampString );
			events.push( { timestamp: timestamp, team: team, type: eventType } );
		}
	}

	return events;
}