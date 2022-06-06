import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
		
	final r = parseInt( readline() );
	final l = parseInt( readline() );
	
	final result = process( r, l );
	print( result );
}

function process( r:Int, l:Int ) {

	var line = [r];
	for( _ in 0...l - 1 ) {
		line = sequence( line );
		// printErr( line.join(" "));
	}
	
	return line.join(" ");
}

function sequence( line:Array<Int> ) {
	final output = [];
	var i = 0;
	while( i < line.length ) {
		var v = line[i];
		var o = 1;
		while( line[i + o] == v ) o++;
		output.push( o );
		output.push( v );
		i = i + o;
	}
	return output;
}
