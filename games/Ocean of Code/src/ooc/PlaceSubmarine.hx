package ooc;

class PlaceSubmarine {
	
	public static function place( width:Int, height:Int, map:Array<Array<Bool>> ):ooc.Position {
		
		while( true ) {
			final x = Std.random( width );
			final y = Std.random( height );
			if( map[y][x] ) return { x: x, y: y };
		}
	}
}