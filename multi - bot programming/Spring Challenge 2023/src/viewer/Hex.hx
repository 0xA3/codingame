package viewer;

@:structInit class Hex {

	static final TILE_SEPERATION = 20;

	static final HEXAGON_HEIGHT = AssetConstants.TILE_HEIGHT + TILE_SEPERATION;
	static final HEXAGON_RADIUS = HEXAGON_HEIGHT / 2;
	static final HEXAGON_WIDTH = HEXAGON_RADIUS * Math.sqrt(3);
	static final HEXAGON_Y_SEP = HEXAGON_RADIUS * 3 / 2;

	public final q:Float;
	public final r:Float;
	
	public static function hexToScreen( q:Int, r:Int ):Point {
		final x = HEXAGON_RADIUS * ( Math.sqrt( 3 ) * q + Math.sqrt( 3 ) / 2 * r );
		final y = HEXAGON_RADIUS * 3 / 2 * r;

		return { x: x, y: y }
	}

	/**
	 * https://www.redblobgames.com/grids/hexagons/#pixel-to-hex
	 */
	public static function screenToHex( point:Point ):Hex {
		final q = ( Math.sqrt( 3 ) / 3 * point.x - 1.0 / 3 * point.y ) / HEXAGON_RADIUS;
		final r = ( 2.0 / 3 * point.y ) / HEXAGON_RADIUS;
		
		return axialRound({ q: q, r: r });
	}

	static function axialRound( hex:Hex ) {
		return cubeToAxial( Cube.cubeRound( Cube.axialToCube( hex )));
	}

	static function cubeToAxial( cube:Cube ):Hex {
		final q = cube.q;
		final r = cube.r;
		return { q: q, r: r }
	}
	
}
