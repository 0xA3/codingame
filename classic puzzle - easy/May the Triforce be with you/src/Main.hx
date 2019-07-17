
using Lambda;
using StringTools;
using Main.ArrayUtils;
class Main {
	
	static function main() {
		
		#if interp		
		final n = 5;
		#else
		final n = Std.parseInt( CodinGame.readline());
		#end
		
		final spaceLines = createSpace( n );
		final triangleLines = createTriangle( n );
		final triforceLines = createTriforce( spaceLines, triangleLines );
		
		triforceLines[0] = "." + triforceLines[0].substr( 1 );
		
		for( triforceLine in triforceLines ) CodinGame.print( triforceLine.rtrim() );
	}

	static function createSpace( n:Int ):Array<String> {

		final width = Std.int( n + 1 / 2 );
		return [for(i in 0...n ) spaces( width )];
	}
	
	static function createTriangle( n:Int ):Array<String> {
		
		final lineIds = [for(i in 0...n ) i];
		final lines = lineIds.map( lineId -> {
			final width = 2 * lineId + 1;
			final space = n - lineId - 1;
			return spaces( space ) + stars( width ) + spaces( space );
		});
		return lines;
	}

	static function stars( count:Int ) return chars( count, "*" );
	static function spaces( count:Int ) return chars( count, " " );
	static function chars( count:Int, s:String ) return [for(i in 0...count ) s].join('');

	static function createTriforce( spaces:Array<String>, triangle:Array<String> ):Array<String> {
		final upper = triangle.mapi(( i, triangleLine ) -> spaces[i] + triangleLine );
		final lower = triangle.map( triangleLine -> triangleLine + " " + triangleLine );
		return upper.concat( lower );
	}
}

class ArrayUtils {
	public static function last<T>( a:Array<T> ) return a[a.length - 1];
}


/*
.    *
    ***
   *****
  *     *
 ***   ***
***** *****

*/