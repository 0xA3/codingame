package simGA.factory;

import h2d.Bitmap;
import h2d.Object;
import h2d.Scene;
import simGA.view.Rocket;

class RocketFactory {
	
	public static function createRocket( s2d:Scene ) {
		
		final rocketTile = hxd.Res.rocket_128.toTile();
		final flame1Tile = hxd.Res.flame1_128.toTile();
		final flame2Tile = hxd.Res.flame2_128.toTile();
		final explosionTile = hxd.Res.explosion_128.toTile();
		rocketTile.setCenterRatio( 0.5, 0.92 );
		flame1Tile.setCenterRatio( 0.5, 0 );
		flame2Tile.setCenterRatio( 0.5, 0 );
		explosionTile.setCenterRatio( 0.5, 0.7 );
		final rocketObj = new Object( s2d );
		final flame1Bitmap = new Bitmap( flame1Tile, rocketObj );
		final flame2Bitmap = new Bitmap( flame2Tile, rocketObj );
		final rocketBitmap = new Bitmap( rocketTile, rocketObj );
		final explosionBitmap = new Bitmap( explosionTile, rocketObj );

		flame1Bitmap.visible = false;
		flame2Bitmap.visible = false;
		explosionBitmap.visible = false;

		final rocket = new Rocket( rocketObj, rocketBitmap, flame1Bitmap, flame2Bitmap, explosionBitmap );
		return rocket;
	}
}