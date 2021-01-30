import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final inputs = readline().split(' ');
		final heights = [for( i in 0...n ) parseInt( inputs[i] )];
		
		final result = process( heights );
		print( result );
	}

	static function process( heights:Array<Int> ) {
		
		final maxHeight = int( heights.fold(( h, max ) -> Math.max( max, h ), 0.0 ));
		
		final lines:Array<Array<String>> = [for( i in 0...maxHeight ) []];

		var x = 0;
		for( h in heights ) {
			for( i in 0...h ) {
				final y = maxHeight - 1 - i;
				insert( lines, x, y, "/" );
				x++;
			}
			for( i in -h + 1...1 ) {
				final y = maxHeight - 1 + i;
				insert( lines, x, y, "\\" );
				x++;
			}
		}

		// trace( "\n" + lines.map( cells -> cells.join( "" )).join( "\n" ));

		return lines.map( cells -> cells.join( "" )).join( "\n" );
	}

	static function insert( lines:Array<Array<String>>, x:Int, y:Int, char:String ) {
		for( i in lines[y].length...x ) {
			lines[y].push(" ");
		}
		lines[y].push( char );
	}

}
