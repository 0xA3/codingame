import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final p = parseInt( readline());
	final pattern = readline();
	final s = parseInt( readline());
	final stock = readline();
	final inputs = readline().split(' ');
	final h = parseInt( inputs[0]);
	final w = parseInt( inputs[1]);
	final depthMaps = [for( i in 0...h ) readline()];
					
	final result = process( pattern, stock, depthMaps );
	print( result );
}

function process( inputPattern:String, inputStock:String, inputDepthMaps:Array<String> ) {
	
	final pattern = inputPattern.split( "" );
	final stock = inputStock.split( "" );
	final depthMaps = inputDepthMaps.map( line -> [for( i in 0...line.length ) parseInt( line.charAt( i ))]);
	
	final outputLines = depthMaps.map( depthMap -> processLine( pattern.copy(), stock.copy(), depthMap ));
	return outputLines.join( "\n" ) ;
}

function processLine( pattern:Array<String>, stock:Array<String>, depthMap:Array<Int> ) {
	
	final outputLine = [];
	var depth = 0;
	var pos = 0;
	for( d in depthMap ) {
		for( _ in 0...d - depth ) {
			pattern.splice( pos, 1 );
			pos = pos % pattern.length;
		}
		for( n in 0...depth - d ) {
			pattern.insert( pos + n, stock.shift() );
		}
		outputLine.push( pattern[pos] );
		pos = ( pos + 1 ) % pattern.length;
		depth = d;
	}

	return outputLine.join( "" );
}
