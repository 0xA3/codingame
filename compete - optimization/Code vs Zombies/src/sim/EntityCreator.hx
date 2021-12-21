package sim;

import Math.round;
import data.Position;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import sim.view.AshView;
import sim.view.HumanView;
import sim.view.ZombieView;

class EntityCreator {
	
	final backgroundTile = hxd.Res.background.toTile();
	final ashGlowTile = hxd.Res.ash_glow.toTile();
	final ashShadowTile = hxd.Res.ash_shadow.toTile();
	final ashTile = hxd.Res.ash.toTile();
	final humanTile = hxd.Res.human.toTile();
	final zombie1Tile = hxd.Res.zombie1.toTile();

	public function new() {}

	public function createBackground( scene:Object ) {
		new Bitmap( backgroundTile, new Graphics( scene ) );
	}

	public function createAsh( scene:Object, position:Position ) {
		final ashObject = new Object( scene );
		final glowBitmap = new Bitmap( ashGlowTile, ashObject );
		final shadowBitmap = new Bitmap( ashShadowTile, ashObject );
		final ashBitmap = new Bitmap( ashTile, ashObject );

		glowBitmap.alpha = 0.3;
		glowBitmap.x = -round( ashGlowTile.width / 2 );
		glowBitmap.y = -round( ashGlowTile.height / 2 );
		shadowBitmap.alpha = 0.5;
		shadowBitmap.x = -85;
		shadowBitmap.y = -10;
		ashBitmap.x = -round( ashTile.width / 2 );
		ashBitmap.y = -round( ashTile.height / 2 );
		final ash = new AshView( ashObject, ashBitmap, position );
		return ash;
	}

	public function createHuman( scene:Object, position:Position ) {
		final humanObject = new Object( scene );
		final humanBitmap = new Bitmap( humanTile, humanObject );
		humanBitmap.x = -round( humanTile.width / 2 );
		humanBitmap.y = -round( humanTile.height / 2 );
		
		final human = new HumanView( humanObject, position );
		return human;
	}
	
	public function createZombie( scene:Object, position:Position ) {
		final zombieObject = new Object( scene );
		final zombieBitmap = new Bitmap( zombie1Tile, zombieObject );
		zombieBitmap.x = -round( zombie1Tile.width / 2 );
		zombieBitmap.y = -round( zombie1Tile.height / 2 );
		
		final zombie = new ZombieView( zombieObject, position );
		return zombie;
	}

}