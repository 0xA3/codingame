import haxe.ds.Vector;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Math.max;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final height = parseInt( inputs[0] );
		final width = parseInt( inputs[1] );
		final numbers = [for( i in 0...height ) readline().split(" ").map( line -> parseInt( line ))].flatten();
		final grid = [for( i in 0...height ) readline().split(" ")].flatten();
		
		final result = process( numbers, grid );
		print( result );
	}

	static function process( numbers:Array<Int>, grid:Array<String> ) {
		
		if( numbers.length != grid.length ) throw 'Error: numbers.length ${numbers.length} should be grid.length ${grid.length}';
		
		final xIds = [for( i in 0...grid.length) if( grid[i] == "X" ) i];
		final xNumbers = xIds.mapi(( i, xId ) -> i % 2 == 0 ? numbers[xId] : -numbers[xId] );
		final xSigns = xNumbers.map( xNumber -> xNumber / Math.abs( xNumber ));
		
		for( i in 1...xSigns.length ) if( xSigns[i] != xSigns[i - 1] ) return false;
		
		return true;
	}

	
}
