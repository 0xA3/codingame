import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final rows = [for( i in 0...h ) readline()];
		
		final result = process( rows );
		print( result );
	}

	static function process( rows:Array<String> ) {
		
		if( getCorners( rows ).join("") == "XXXX" ) return "Rectangle";
		if( getCenters( rows ).join("") == "XXXX" ) return "Ellipse";
		return "Triangle";
	}

	static function getCorners( rows:Array<String> ) {
		return [	rows[0].charAt( 0 ),
					rows[0].charAt( rows[0].length - 1),
					rows[rows.length - 1].charAt( 0 ),
					rows[rows.length - 1].charAt( rows[rows.length - 1].length - 1 )
				];
	}
	
	static function getCenters( rows:Array<String> ) {
		final centerX = int( rows[0].length / 2 );
		final centerY = int( rows.length / 2 );
		return [	rows[0].charAt( centerX ),
					rows[centerY].charAt( 0 ),
					rows[rows.length - 1].charAt( centerX ),
					rows[centerY].charAt( rows[centerY].length - 1 )
				];
	}

}
