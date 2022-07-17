import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final typedKeys = readline();

	final result = process( typedKeys );
	print( result );
}

function process( typedKeys:String ) {

	final chars = typedKeys.split( "" );
	var output = [];
	
	var position = 0;
	for( char in chars ) {
		switch char {
			case "<":
				position = max( 0, position - 1 );
				// trace( 'position $position' );
			case ">":
				position = min( output.length, position + 1 );
				// trace( 'position $position' );
			case "-":
				position = max( 0, position - 1 );
				output.splice( position, 1 );
			default:
				final left = output.slice( 0, position );
				final right = output.slice( position );
				// trace( '$left  $char  $right' );
				output = [left, [char], right].flatten();
				position++;
		}
	}

	return output.join( "" );
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;