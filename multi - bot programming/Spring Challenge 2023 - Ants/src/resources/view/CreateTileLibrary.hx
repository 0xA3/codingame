package resources.view;

import h2d.Tile;

class CreateTileLibrary {
	
	public static function create( tile:Tile, mapFile:String ) {
		final tileLibrary = {};
		final map = haxe.Json.parse( mapFile ).frames;

		final fields = Reflect.fields( map );
		for( field in fields ) {
			final tileName = field.split(".")[0];
			if( Reflect.getProperty( tileLibrary, tileName ) != null ) throw 'Error: $tileName already exists in Tiles';
			final value:TilemapDataset = Reflect.field( map, field );
			final frame = value.frame;
			final subTile = tile.sub( frame.x, frame.y, frame.w, frame.h );
			Reflect.setField( tileLibrary, tileName, subTile );
		}
		return tileLibrary;
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