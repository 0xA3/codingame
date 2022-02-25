package sim;

using xa3.MathUtils;

class MazeMap {
	
	final map:Array<Array<String>>;
	final visibleMap:Array<Array<String>>;
	final visibility:Array<Array<Bool>>;

	public final width:Int;
	public final height:Int;

	public var transporterX(default, null):Int;
	public var transporterY(default, null):Int;
	public var controlRoomX(default, null):Int;
	public var controlRoomY(default, null):Int;
	public var kx(default, null):Int;
	public var ky(default, null):Int;

	public function new( lines:Array<String> ) {
		this.map = lines.map( line -> line.split( "" ));
		width = map[0].length;
		height = map.length;
		visibility = [for( y in 0...map.length )[for( _ in map[y] ) false]];
		visibleMap = [for( _ in 0...map.length ) []];
		
		for( y in 0...map.length ) {
			for( x in 0...map[y].length ) {
				if( map[y][x] == "T" ) {
					transporterX = x;
					transporterY = y;
				} else if( map[y][x] == "C" ) {
					controlRoomX = x;
					controlRoomY = y;
				}
			}
		}
		kx = transporterX;
		ky = transporterY;
		createVisibleMap();
	}

	public function updatePosition( direction:String ) {
		switch direction {
			case "UP":
				final y = ky - 1;
				if( validatePosition( kx, y )) ky = y;
			case "DOWN":
				final y = ky + 1;
				if( validatePosition( kx, y )) ky = y;
			case "LEFT":
				final x = kx - 1;
				if( validatePosition( x, ky )) kx = x;
			case "RIGHT":
				final x = kx + 1;
				if( validatePosition( x, ky )) kx = x;
			default: throw 'Error: direction "$direction" is not a valid command';
		}
		createVisibleMap();
	}

	function createVisibleMap() {
		final minX = ( kx - 2 ).max( 0 );
		final maxX = ( kx + 3 ).min( width );
		final minY = ( ky - 2 ).max( 0 );
		final maxY = ( ky + 3 ).min( height );
		for( y in minY...maxY ) for( x in minX...maxX ) visibility[y][x] = true;

		for( y in 0...height ) {
			for( x in 0...width ) {
				visibleMap[y][x] = visibility[y][x] ? map[y][x] : "?";
			}
		}
	}

	function validatePosition( x:Int, y:Int ) {
		if( kx < 0 || kx >= width || ky < 0 || ky >= height ) return false;
		return map[y][x] != "#";
	}

	public function getVisibleLines() return visibleMap.map( row -> row.join( "" ));

	public function getOutput() {
		final output = [];
		for( y in 0...height ) {
			output[y] = [];
			for( x in 0...width ) {
				output[y][x] = x == kx && y == ky ? "@" : visibleMap[y][x];
			}
		}
		return output.map( row -> row.join( "" )).join( "\n" );
	}

	public function getCell() return map[ky][kx];
}