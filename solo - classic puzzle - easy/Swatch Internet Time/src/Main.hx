import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using NumberFormat;

function main() {

	final rawtime = readline();

	final result = process( rawtime );
	print( result );
}

function process( rawtime:String ) {

	final secondsOfMinute = 60;
	final secondsOfHour = 60 * secondsOfMinute;
	final secondsOfDay = secondsOfHour * 24;

	final hour = parseInt( rawtime.substr( 0, 2 ) );
	final minute = parseInt( rawtime.substr( 3, 2 ) );
	final seconds = parseInt( rawtime.substr( 6, 2 ) );
	final plusMinus = rawtime.substr( 12, 1 );
	final hourOffset = parseInt( rawtime.substr( 13, 2 ) );
	final minuteOffset = parseInt( rawtime.substr( 16, 2 ) );

	final timeSeconds = hour * secondsOfHour + minute * secondsOfMinute + seconds;
	final deltaSeconds = hourOffset * secondsOfHour + minuteOffset * secondsOfMinute;

	final resultSeconds = switch plusMinus {
		case "+": timeSeconds - deltaSeconds + secondsOfHour;
		case "-": timeSeconds + deltaSeconds + secondsOfHour;
		default: throw 'Error: Invalid plusMinus "$plusMinus"';
	}

	final bielSeconds = ( resultSeconds + secondsOfDay ) % secondsOfDay;
	
	final beats = bielSeconds / 86.4;

	// trace( 'rawtime: $rawtime' );
	// trace( 'hour: $hour, minute: $minute, seconds: $seconds, plusMinus: $plusMinus, hourOffset: $hourOffset, minuteOffset: $minuteOffset' );
	// trace( 'timeSeconds: $timeSeconds' );
	// trace( 'delta: $resultSeconds' );
	// trace( 'resultSeconds: $resultSeconds' );

	final roundedBeats = Math.round( beats * 1000 ) / 1000;
	// trace( 'beats: $beats' );
	// trace( 'roundedBeats: $roundedBeats' );

	return "@" + roundedBeats.fixed( 2 );
}
