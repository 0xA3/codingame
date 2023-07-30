package resources.view;

import h2d.Tile;

class CreateTiles {
	
	public static function create( subTiles:Map<String, Tile>, tile:Tile, mapFile:String ) {
		final map = haxe.Json.parse( mapFile ).frames;

		final fields = Reflect.fields( map );
		for( field in fields ) {
			if( subTiles.exists( field )) throw 'Error: $field already exists in Tiles';
			final value:TilemapDataset = Reflect.field( map, field );
			final frame = value.frame;
			final subTile = tile.sub( frame.x, frame.y, frame.w, frame.h );
			subTiles.set( field, subTile );
		}
	}
}

typedef TilemapDataset = {
	frame:{
		x:Int,
		y:Int,
		w:Int,
		h:Int
	},
	rotated:Bool,
	trimmed:Bool,
	spriteSourceSize:{
		x:Int,
		y:Int,
		w:Int,
		h:Int
	},
	sourceSize:{
		w:Int,
		h:Int
	}
}