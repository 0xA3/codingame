import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final line = readline();

	final result = process( line );
	print( result );
}

function process( line:String ) {
	final chars = line.split( "" );
	var depth = 0;
	for( i in 0...chars.length ) {
		final char = chars[i];
		switch char {
			case "<": depth++;
			case ">": depth--;
			default: throw 'Error: illegal char $char';
		}
		if( depth < 0 ) return i;
	}
	return chars.length;
}
