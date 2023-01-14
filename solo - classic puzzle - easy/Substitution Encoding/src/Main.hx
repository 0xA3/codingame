import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final rows = parseInt( readline() );
	final characters = [for( i in 0...rows) readline().split(" ")];
	final message = readline();
		
	final result = process( characters, message );
	print( result );
}

function process( characters:Array<Array<String>>, message:String ) {
	
	final codes = [for( y in 0...characters.length) for( x in( 0...characters[y].length )) characters[y][x] => '$y$x' ];
	final output = [for( i in 0...message.length ) codes[message.charAt( i )]].join( "" );

	return output;
}
