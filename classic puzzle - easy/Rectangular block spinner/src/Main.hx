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
		
		final realAngle = ( angle % 360 );
		final size2 = lines.length * 2 - 1;

		var tempAngle = realAngle;
		while( tempAngle > 90 ) {
			lines = rotate90( size, lines );
			tempAngle -= 90;
		}
		
		final lines2 = rotate45( size, lines );
		final outputLines = [];
		for( line in lines2 ) {
			final s = line.join(" ");
			final spacesNo = int(( size2 - s.length  ) / 2 );
			final spaces = [for( i in 0...spacesNo ) " "].join( "" );
			outputLines.push( '$spaces$s$spaces' );
		}
		// trace( "\n" + outputLines.join( "\n" ));

		return outputLines.join( "\n" );
	}

	static function rotate45( size:Int, lines:Array<Array<String>> ) {
		
		final lines2 = [];
		
		// top half
		for( i in 0...size ) {
			var x = size - i - 1;
			var y = 0;
			final line = [];
			while( x < size && y < size ) {
				line.push( lines[y][x] );
				x++;
				y++;
			}
			lines2.push( line );
		}
		// bottom half
		for( i in 1...size ) {
			var x = 0;
			var y = i;
			final line = [];
			while( x < size && y < size ) {
				line.push( lines[y][x] );
				x++;
				y++;
			}
			lines2.push( line );
		}
		return lines2;
	}

	static function rotate90( size:Int, lines:Array<Array<String>> ) {
		final lines2 = [];
		for( y in 0...size ) {
			final line = [];
			for( x in 0... size ) {
				line.push( lines[x][size - y - 1 ] );
			}
			lines2.push( line );
		}
		return lines2;
	}

}
