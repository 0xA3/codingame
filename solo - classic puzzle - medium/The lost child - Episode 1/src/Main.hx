import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

import BreadthFirstSearch2D.Cell;

using Lambda;

class Main {
	
	static inline var SIZE = 10;

	static function main() {
		
		final lines = [for( i in 0...SIZE ) readline()];

		final result = process( lines, SIZE );
		print( result );
	}

	static function process( lines:Array<String>, size:Int ) {
		
		final cells = lines.flatMap( line -> line.split("").map( cell -> switch cell {
			case ".": Road;
			case "#": Wall;
			case "C": Start;
			case "M": Goal;
			case s: throw 'Error: unexpected $s';
		}));
		
		

		final distance = BreadthFirstSearch2D.getPath( cells, size );
		return '${distance * 10}km';
	}

}
