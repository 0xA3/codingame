import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final COLDER = "COLDER";
final WARMER = "WARMER";
final SAME = "SAME";
final UNKNOWN = "UNKNOWN";

var width:Int;
var height:Int;
var maxJumps:Int;
var x:Int;
var y:Int;

var turn:Int;

function main() {
	
	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] ); // width of the building.
	final h = parseInt( inputs[1] ); // height of the building.
	final n = parseInt( readline() ); // maximum number of turns before game over.
	var inputs = readline().split(' ');
	final x0 = parseInt( inputs[0] );
	final y0 = parseInt( inputs[1] );
	
	init( w, h, n, x0, y0 );

	while( true ) {
		final result = process( readline() );
		print( result );
	}
}

function init( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
	printErr( '$w $h\n$n\n$x0 $y0' );
	width = w;
	height = h;
	maxJumps = n;
	x = x0;
	y = y0;
	turn = 0;
}

function process( bombDir:String ) {
	printErr( bombDir );
	if( bombDir == UNKNOWN ) return '${width - x} ${height - y}';
	return "0 0";
}

