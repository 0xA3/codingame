using StringTools;
using StringUtils;

class GridUtils {

	public static function fromString( s:String ) {
		return s.replace( "\t", "" ).replace( "\r", "" ).split( "\n" ).map( line -> line.split( "" ));
	}

	public static function fromDimensions( width:Int, height:Int ) {
		return [for( _ in 0...height ) [for( _ in 0...width ) " "]];
	}

	public static function paste( grid:Array<Array<String>>, pattern:Array<Array<String>>, offsetX = 0, offsetY = 0 ) {
		for( py in 0...pattern.length ) {
			for( px in 0...pattern[py].length ) {
				final x = offsetX + px;
				final y = offsetY + py;
				if( x < 0 || x >= grid[0].length || y < 0 || y >= grid.length ) continue;
	
				final char = pattern[py][px];
				if( char != " " ) grid[y][x] = char;
			}
		}
	}

	static final horizontalPairs = ["()","{}","[]","<>","/\\"];
	static final hMap = createPairMap( horizontalPairs );

	public static function mirrorHorizontally( grid:Array<Array<String>> ) {
		final width = grid[0].length;
		final height = grid.length;
		return [for( y in 0...height ) [for( x in 0...width ) grid[y][width - 1 - x].mapReplace( hMap )]];
	}

	static final verticalPairs = ["^v","AV","wm","WM","un","/\\"];
	static final vMap = createPairMap( verticalPairs );

	public static function mirrorVertically( grid:Array<Array<String>> ) {
		final width = grid[0].length;
		final height = grid.length;
		return [for( y in 0...height ) [for( x in 0...width ) grid[height - 1 - y][x].mapReplace( vMap )]];
	}
	
	public static function visualize( grid:Array<Array<String>> ) return grid.map( row -> row.join( "" )).join( "\n" );
	
	static function createPairMap( a:Array<String> ) {
		final map:Map<String, String> = [];
		for( pair in a ) {
			if( pair.length != 2 ) throw 'Error: pair $pair should be two characters';
			final c1 = pair.charAt( 0 );
			final c2 = pair.charAt( 1 );
			map.set( c1, c2 );
			map.set( c2, c1 );
		}
		return map;
	}

}