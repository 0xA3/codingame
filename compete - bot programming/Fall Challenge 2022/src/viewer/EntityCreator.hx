package viewer;

import game.Config;
import game.Coord;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import h2d.Tile;
import viewer.AssetConstants;

using xa3.MathUtils;

class EntityCreator {
	
	public final tileLibrary:Map<String, Tile> = [];

	static inline var TEXT_HEIGHT = 54;
	public final lato_bold_44 = hxd.Res.lato_bold_44.toFont();
	public final lato_bold_54 = hxd.Res.lato_bold_54.toFont();
	public final lato_bold_64 = hxd.Res.lato_bold_64.toFont();
	public final timesFont = hxd.Res.times_new_roman_bold.toFont();

	final logoTile = hxd.Res.keep_off_the_grass.logo.toTile();
	final backgroundTile = hxd.Res.keep_off_the_grass.Background_low.toTile();
	// final backgroundTile = hxd.Res.keep_off_the_grass.Background.toTile();
	final caseTile = hxd.Res.keep_off_the_grass.Case.toTile();
	
	public function new() { }

	public function initTiles() {
		CreateTiles.create( tileLibrary, hxd.Res.keep_off_the_grass.blue_png.toTile(), hxd.Res.load( "keep_off_the_grass/blue.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.keep_off_the_grass.red_png.toTile(), hxd.Res.load( "keep_off_the_grass/red.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.keep_off_the_grass.spritesheet_png.toTile(), hxd.Res.load( "keep_off_the_grass/spritesheet.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.keep_off_the_grass.white_fx_png.toTile(), hxd.Res.load( "keep_off_the_grass/white_fx.json" ).toText() );
	}
	
	public function createPlayerNameTextfields( textLayer:Object, player1:String, player2:String ) {
		final textPlayer1 = new Text( lato_bold_54, textLayer );
		final textPlayer2 = new Text( lato_bold_54, textLayer );
		textPlayer1.textAlign = Center;
		textPlayer2.textAlign = Center;
		textPlayer1.x = 272;
		textPlayer2.x = 1645;
		textPlayer1.y = textPlayer2.y = -2;
		textPlayer1.text = player1;
		textPlayer2.text = player2;
	}

	public function createHUD( backgroundLayer:Object, hudLayer:Object, textLayer:Object ) {
		new Bitmap( backgroundTile, backgroundLayer );
		new Bitmap( tileLibrary["HUD"], hudLayer );
	}

	function centerAnim( anim:Anim ) {
		if( anim.frames.length == 0 ) throw 'Error: anim has no frames';
		anim.x = -anim.frames[0].width / 2;
		anim.y = -anim.frames[0].height / 2;
	}
}