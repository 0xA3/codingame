import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;
using StringUtils;

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
		
		var lines = [];
		for( h in -maxHeight...0 ) {
			final y = -h;
			var output = "";
			for( mountainHeight in heights ) {
				if( y > mountainHeight )
					output += " ".repeat( mountainHeight * 2 );
				else {
					output += " ".repeat( y - 1 );
					output += "/";
					output += " ".repeat(( mountainHeight - y ) * 2 );
					output += "\\";
					output += " ".repeat( y - 1 );
				}
			}
			lines.push( output.rtrim() );
		}
		
		return lines.join( "\n" );
	}
}
