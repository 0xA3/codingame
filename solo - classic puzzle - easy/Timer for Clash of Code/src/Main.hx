import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;

function main() {

	final n = parseInt( readline());
	final timestamps = [for( _ in 0...n ) readline()];
	
	final result = process( timestamps );
	print( result );
}

function process( timestamps:Array<String> ) {
	if( timestamps.length == 0 ) return "NO GAME";
	
	var startTime = 0;
	for( i in 0...timestamps.length ) {
		final playersInTheRoom = i + 1;
		final currentTime = timestamps[i].toSeconds();
		if( currentTime < startTime ) break;
		if( playersInTheRoom == 7 ) {
			startTime = currentTime;
			break;
		}
		startTime = int( currentTime - 256 / pow( 2, ( playersInTheRoom - 1 )));
		final delay = currentTime - startTime;

		// printErr( 'at ${timestamps[i]} player ${playersInTheRoom + 1} joins -> set to start $delay seconds from now at ${ startTime.toTimestamp()}' );
	}

	return startTime.max( 0 ).toTimestamp();
}

function toSeconds( time:String ) {
	var parts = time.split( ":" );
	return parseInt( parts[0] ) * 60 + parseInt( parts[1] );
}

function toTimestamp( s:Int ) return '${int( s / 60 )}:${doubleDigit( s % 60 )}';
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function doubleDigit( v:Int ) return v < 10 ? '0${v}' : '${v}';