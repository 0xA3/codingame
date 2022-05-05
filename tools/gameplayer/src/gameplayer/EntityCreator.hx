package gameplayer;

import h2d.Bitmap;
import h2d.Interactive;
import h2d.Object;
import h2d.Tile;
import haxe.Json;

class EntityCreator {
	
	public static function createBackground( container:Object ) {
		final background = new Object( container );
		var rectangle = new h2d.Graphics( background );
		rectangle.beginFill( 0x252e38 );
		rectangle.drawRect( 0, 0, 800, 44 );
		rectangle.endFill();
		rectangle.y = -44;

		return background;
	}

	public static function create() {
		
	}

	public static function createBitmaps( container:Object ) {
		final buttonsMap = Json.parse( hxd.Res.load( "buttons_map.json" ).toText() );
		final buttonsTile = hxd.Res.buttons.toTile();

		final start = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.end.frame ), container );
		final prev = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.next.frame ), container );
		final pause = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.pause.frame ), container );
		final play = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.play.frame ), container );
		final next = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.next.frame ), container );
		final end = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.end.frame ), container );

		start.scaleX = -1;
		prev.scaleX = -1;
		
		final bitmaps = [start, prev, play, next, end];
		for( i in 0...bitmaps.length ) {
			final bitmap = bitmaps[i];
			bitmap.tile.center();
			bitmap.x = 30 + 30 * i;
			bitmap.y = -28;
		}
		
		play.x -= 7;
		play.y -= 5;
		pause.x = play.x;
		pause.y = play.y;
		pause.visible = false;
		
		final drag = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.drag.frame ));
		container.addChild( drag );

		return [start, prev, play, next, end, pause, drag];
	}
	
	static function createSubTile( tile:Tile, frame:{ x:Int, y:Int, w:Int, h:Int } ) {
		return tile.sub( frame.x, frame.y, frame.w, frame.h );
	}

	public static function createInteractives( container:Object ) {
		
		final interactives = [];

		for( i in 0...5 ) {
			final iContainer = new Object( container );
			iContainer.x = 10 + 30 * i;
			iContainer.y = -34;
			final interactive = new Interactive( 38, 24, iContainer );
			interactives.push( interactive );
		}

		return interactives;
	}
}