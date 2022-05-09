package viewer;

import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;

class EntityCreator {
	
	final timesFont = hxd.Res.times_new_roman_bold.toFont();
	final backgroundTile = hxd.Res.background_screenshot.toTile();
	final heartTile = hxd.Res.heart.toTile();
	final heroTiles = [
		hxd.Res.hero1.toTile().center(),
		hxd.Res.hero2.toTile().center()
	];

	final mobTiles = [
		hxd.Res.mob1.toTile().center(),
		hxd.Res.mob2.toTile().center(),
		hxd.Res.mob3.toTile().center()
	];

	public function new() {
	}

	public function createBackground( scene:Object ) {
		return new Bitmap( backgroundTile, new Graphics( scene ) );
	}

	public function createHeart( parent:Object, x:Int, y:Int ) {
		final heart = new Bitmap( heartTile, new Graphics( parent ) );
		heart.x = x;
		heart.y = y;
		return heart;
	}

	static inline var TEXT_HEIGHT = 30;

	public function createHero( parent:Object, player:Int ) {
		final heroContainer = new Object( parent );
		final infoContainer = new Object( heroContainer );
		infoContainer.y = -32 - TEXT_HEIGHT;
		
		final heroObject = new Object( heroContainer );
		new Bitmap( heroTiles[player], heroObject );
		
		final textField = new Text( timesFont, infoContainer );
		textField.textAlign = Center;

		final hero = new HeroView( heroContainer, infoContainer, heroObject, textField );
		return hero;
	}
	
	public function createMob( parent:Object, type:Int, fullHealth:Int ) {
		final mobContainer = new Object( parent );
		final infoContainer = new Object( mobContainer );
		infoContainer.x = -MobView.HEALTH_BAR_WIDTH / 2;
		infoContainer.y = -32 - MobView.HEALTH_BAR_HEIGHT;
		
		final mobObject = new Object( mobContainer );
		new Bitmap( mobTiles[type], mobObject );
		
		
		final bgGraphics = new h2d.Graphics( infoContainer );
		bgGraphics.beginFill( 0xFF0000 );
		bgGraphics.drawRect( 0, 0, MobView.HEALTH_BAR_WIDTH, MobView.HEALTH_BAR_HEIGHT );

		final healthBar = new Object( infoContainer );
		final barGraphics = new h2d.Graphics( healthBar );
		
		barGraphics.beginFill( 0x00FF00 );
		barGraphics.drawRect( 0, 0, MobView.HEALTH_BAR_WIDTH, MobView.HEALTH_BAR_HEIGHT );
		
		infoContainer.visible = false;

		final mob = new MobView( mobContainer, infoContainer, mobObject, healthBar, fullHealth );
		return mob;
	}
}