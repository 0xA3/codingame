import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

class Main {
	
	static inline var SPLASH_WIDTH = 3;
	static var char:Int;
	
	static function main() {
		
		final n = parseInt( readline());
		final lines = [for( i in 0...n ) readline().split("").map( cell -> cell == "f" ? true : false )];
		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<Array<Bool>> ) {
		return lines.map( line -> Std.string( processLine( line ))).join( "\n" );
	}

	static function processLine( line:Array<Bool> ) {
		
		var drops = 0;
		var i = 0;
		while( i < line.length ) {
			if( line[i] ) {
				drops++;
				for( _ in 0...SPLASH_WIDTH ) {
					i++;
				}
			} else {
				i++;
			}
		}

		return drops;
	}
}
