import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final l = parseInt( readline() );
	final f = readline();
	final inputs = readline().split(' ');
	final n = parseInt( inputs[0] );
	final k = parseInt( inputs[1] );
	final crewmates = [for( i in 0...n ) readline()];
				
	final result = process( l, f, crewmates );
	print( result );
}

function process( length:Int, layout:String, crewmates:Array<String> ) {
	
	final outputLines = crewmates.map( crewmate -> checkCrewmate( length, layout, crewmate ));
	return outputLines.join( "\n" );
}

function checkCrewmate( length:Int, layout:String, crewMate:String ) {
	
	final roomPositions = [for( i in 0...crewMate.length ) if( crewMate.charAt( i ) != "#") i];
	if( roomPositions.length < 2 ) return "NOT SUS";
	
	for( i in 1...roomPositions.length ) {
		// trace( 'crewMate $crewMate ${i - 1} ${crewMate.charAt( i - 1 )}  ${i} ${crewMate.charAt( i )}' );
		final pos1 = roomPositions[i - 1];
		final pos2 = roomPositions[i];
		final room1 = crewMate.charAt( pos1 );
		final room2 = crewMate.charAt( pos2 );
		final distance = getDistance( room1, room2, length, layout );
		if( distance > pos2 - pos1 ) return "SUS";
	}
	return "NOT SUS";
}

inline function getDistance( room1:String, room2:String, length:Int, layout:String ) {
	final pos1 = layout.indexOf( room1 );
	final pos2 = layout.indexOf( room2 );
	final distance1 = abs( pos2 - pos1 );
	final distance2 = length - distance1;
	// trace( '$layout $room1 - $room2  pos1 $pos1  pos2 $pos2  distance1 $distance1  distance2 $distance2' );
	return distance1 < distance2 ? distance1 : distance2;
}
