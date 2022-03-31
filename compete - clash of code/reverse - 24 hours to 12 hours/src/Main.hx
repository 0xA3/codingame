import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final time = readline();
	final hour = parseInt( time.substr( 0, 2 ));
	final minuteString = time.substr( 3, 2 );
	final minute = parseInt( minuteString );


	if( hour > 23 || minute > 59 ) {
		print( "INVALID" );
		return;
	}

	final ampm = hour < 12 ? "AM" : "PM";
	final hour12 = hour == 0 ? 12 : hour > 11 ? hour - 12 : hour;

	print( '$hour12:$minuteString $ampm' );
}

function double( i:Int ) {
	if( i < 10 ) return '0$i';
	return '$i';
}
