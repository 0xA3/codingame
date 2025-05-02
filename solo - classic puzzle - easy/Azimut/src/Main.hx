import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"];

function main() {

	final startDirection = readline();
	final n = parseInt( readline() );
	final turns = [for( i in 0...n) readline()];

	final result = process( startDirection, turns );
	print( result );
}

function process( startDirection:String, turns:Array<String> ) {
	var directionIndex = directions.indexOf( startDirection );
	
	for( turn in turns ) {
		switch turn {
			case "FORWARD": // no-op
			case "BACK": directionIndex = ( directionIndex + 4 ) % directions.length;
			case "LEFT": directionIndex = ( directionIndex + 7 ) % directions.length;
			case "RIGHT": directionIndex = ( directionIndex + 1 ) % directions.length;
			default: throw( "Invalid turn: " + turn );
		}
		// printErr( 'turn: $turn  new direction ${directions[directionIndex]}' );
	}
	
	return directions[directionIndex];
}
