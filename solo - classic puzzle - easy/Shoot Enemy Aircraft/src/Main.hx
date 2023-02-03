import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final lines = [for( _ in 0...n ) readline()];
	
	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {

	final launcherX = lines[lines.length - 1].indexOf( "^" );
	final aircrafts = getAircrafts( lines, launcherX );
	final delays = aircrafts.map( a -> a.offset - a.height );
	delays.sort(( a, b ) -> a - b );

	final steps = delays[delays.length - 1] + 1;

	final outputs = [];
	var element = 0;
	for( i in 0...steps ) {
		if( i == delays[element] ) {
			outputs.push( "SHOOT" );
			element++;
		} else {
			outputs.push( "WAIT" );
		}
	}
	return outputs.join( "\n" );
}

function getAircrafts( lines:Array<String>, launcherX:Int ) {
	final aircrafts:Array<Aircraft> = [];
	for( y in 0...lines.length - 1 ) {
		final line = lines[y].split( "" );
		for( x in 0...line.length ) {
			if( ["<", ">"].contains( line[x] )) {
				aircrafts.push({ height: lines.length - y, offset: abs( launcherX - x ) });
			}
		}
	}
	return aircrafts;
}

function abs( v:Int ) return v < 0 ? -v : v;

typedef Aircraft = {
	final height:Int;
	final offset:Int;
}