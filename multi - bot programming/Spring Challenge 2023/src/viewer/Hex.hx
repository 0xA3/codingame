package viewer;

import viewer.AssetConstants;

typedef Hex = {
	final q:Int;
	final r:Int;
}

typedef Cube = {
	final q:Int;
	final r:Int;
	final s:Int;
}

final TILE_SEPERATION = 20;

final HEXAGON_HEIGHT = TILE_HEIGHT + TILE_SEPERATION;
final HEXAGON_RADIUS = HEXAGON_HEIGHT / 2;
final HEXAGON_WIDTH = HEXAGON_RADIUS * Math.sqrt(3);
final HEXAGON_Y_SEP = HEXAGON_RADIUS * 3 / 2;

function hexToScreen( q:Int, r:Int ) {
	final x = HEXAGON_RADIUS * ( Math.sqrt( 3 ) * q + Math.sqrt( 3 ) / 2 * r );
	final y = HEXAGON_RADIUS * 3 / 2 * r;
}