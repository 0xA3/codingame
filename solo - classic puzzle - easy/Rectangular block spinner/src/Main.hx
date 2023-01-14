import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final size = parseInt(readline());
		final angle = parseInt(readline());
		final lines = [for( i in 0...size ) readline().split(" ")];

		final result = process( size, lines, angle );
		print( result );
	}

	static function process( size:Int, lines:Array<Array<String>>, angle:Int ) {
		
		var flip = false;
		switch angle % 360 {
			case 45:
				for( line in lines ) line.reverse();
				flip = true;
			case 135:
				lines.reverse();
				for( line in lines ) line.reverse();
			case 225:
				lines.reverse();
				flip = true;
			default: // 315
		}

		final size2 = size * 2 - 1;
		final lines2 = [];
		for( i in 0...size2 ) {
			final s = [for( _ in 0...size2 ) " "];
			for( j in 0...i + 1 ) {
				if( lines[i - j] != null && lines[i - j][j] != null ) {
					s[size - 1 - i + 2 * j] = lines[i - j][j];
				}
			}
			if( flip ) s.reverse();
			lines2.push( s.join( "" ));
		}
		// trace( "\n" + lines2.map( line -> '"' + line + '"' ).join( "\n" ));
		return lines2.join( "\n" );

	}

}
