package viewer;

import h2d.Anim;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import h2d.Tile;
import viewer.AssetConstants;

class EntityCreator {
	
	public final tileLibrary:Map<String, Tile> = [];

	public final times31 = hxd.Res.times_new_roman_31.toFont();
	public final times48 = hxd.Res.times_new_roman_48.toFont();
	public final timesBold40 = hxd.Res.times_new_roman_bold_40.toFont();
	final timesFont = hxd.Res.times_new_roman_bold.toFont();
	final backgroundTile = hxd.Res.spider_attack.Background.toTile();
	
	final heartY = -30;
	final heartXs = [147, 181, 215, 1416, 1450, 1484];
	
	public function new() {
	}

	public function initTiles() {
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.beam_png.toTile(), hxd.Res.load( "spider_attack/beam.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.fx_ball_png.toTile(), hxd.Res.load( "spider_attack/fx_ball.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.fx_glint_png.toTile(), hxd.Res.load( "spider_attack/fx_glint.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.fx_gust_png.toTile(), hxd.Res.load( "spider_attack/fx_gust.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.heroes_png.toTile(), hxd.Res.load( "spider_attack/heroes.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.HUD_background_png.toTile(), hxd.Res.load( "spider_attack/HUD_background.json" ).toText() );
		CreateTiles.create( tileLibrary, hxd.Res.spider_attack.main_png.toTile(), hxd.Res.load( "spider_attack/main.json" ).toText() );
	}
	
	public function createTextfields( textLayer:Object, player1:String, player2:String ) {
		final textPlayer1 = new Text( timesBold40, textLayer );
		final textPlayer2 = new Text( timesBold40, textLayer );
		textPlayer1.textAlign = Center;
		textPlayer2.textAlign = Center;
		textPlayer1.x = 324;
		textPlayer2.x = 1594;
		textPlayer1.y = textPlayer2.y = -2;
		textPlayer1.text = player1;
		textPlayer2.text = player2;

		final textLife1 = new Text( times31, textLayer );
		final textLife2 = new Text( times31, textLayer );
		textLife1.x = 157;
		textLife2.x = 1426;
		textLife1.y = textLife2.y = 63;
		textLife1.text = textLife2.text = "Life";

		final textMana1 = new Text( times31, textLayer );
		final textMana2 = new Text( times31, textLayer );
		textMana1.x = 356;
		textMana2.x = 1626;
		textMana1.y = textMana2.y = 63;
		textMana1.text = textMana2.text = "Mana";
	
	}

	public function createHUD( backgroundLayer:Object, mobsLayer:Object, herosLayer:Object, hudLayer:Object, textLayer:Object ) {
		new Bitmap( backgroundTile, backgroundLayer );
		final left = new Bitmap( tileLibrary["left"], hudLayer );
		left.y = App.CANVAS_HEIGHT - left.tile.height;
		final top = new Bitmap( tileLibrary["top"], hudLayer );
		top.x = App.CANVAS_WIDTH - top.tile.height;
		top.y = top.tile.width;
		top.rotation = -Math.PI / 2;
		final right = new Bitmap( tileLibrary["right"], hudLayer );
		right.x = App.CANVAS_WIDTH - right.tile.width;
		right.y = top.y;
		final bottom = new Bitmap( tileLibrary["bottom"], hudLayer );
		bottom.rotation = -Math.PI / 2;
		bottom.y = App.CANVAS_HEIGHT;
		new Bitmap( tileLibrary["HUD"], hudLayer );
	}

	public function createBackground( scene:Object ) {
		return new Bitmap( backgroundTile, new Graphics( scene ));
	}

	public function createLife( parent:Object, x:Int, y:Int ) {
		final lifeTiles = AssetConstants.LIFE_FRAMES.map( frameId -> tileLibrary[frameId] );
		final lifeAnim = new Anim( lifeTiles, new Graphics( parent ));
		lifeAnim.x = x;
		lifeAnim.y = y;
		lifeAnim.pause = true;
		return new Life( lifeAnim );
	}

	static inline var TEXT_HEIGHT = 30;

	public function createHero( parent:Object, player:Int ) {
		final heroContainer = new Object( parent );
		final infoContainer = new Object( heroContainer );
		infoContainer.y = -44 - TEXT_HEIGHT;
		
		final heroObject = new Object( heroContainer );
		final heroTile = player == 0 ? tileLibrary["Chasseur_B_OK0005"] : tileLibrary["Chasseur_R_OK0005"];
		final heroBitmap = new Bitmap( heroTile, heroObject );
		heroBitmap.x = -heroBitmap.tile.width / 2;
		heroBitmap.y = -heroBitmap.tile.height / 2;
		
		final textField = new Text( timesFont, infoContainer );
		textField.textAlign = Center;

		final hero = new HeroView( heroContainer, infoContainer, heroObject, Down, textField );
		return hero;
	}
	
	public function createMob( parent:Object, type:Int, fullHealth:Int ) {
		final mobContainer = new Object( parent );
		final infoContainer = new Object( mobContainer );
		infoContainer.x = -MobView.HEALTH_BAR_WIDTH / 2;
		infoContainer.y = MobView.HEALTH_BAR_Y - MobView.HEALTH_BAR_HEIGHT;
		
		final mobObject = new Object( mobContainer );
		final aniFrames = switch type {
			case 0: AssetConstants.MOB_1_FRAMES.map( frameId -> tileLibrary[frameId] );
			case 1: AssetConstants.MOB_2_FRAMES.map( frameId -> tileLibrary[frameId] );
			case 2: AssetConstants.MOB_3_FRAMES.map( frameId -> tileLibrary[frameId] );
			default: throw 'Error there is no mob type $type';
		}
		
		final mobAnim = new Anim( aniFrames, mobObject );
		mobAnim.x = -aniFrames[0].width;
		mobAnim.y = -aniFrames[0].height;
		mobAnim.pause = true;
		mobObject.scaleX = mobObject.scaleY = 1.5;

		
		final bgGraphics = new h2d.Graphics( infoContainer );
		bgGraphics.beginFill( 0xFF0000 );
		bgGraphics.drawRect( 0, 0, MobView.HEALTH_BAR_WIDTH, MobView.HEALTH_BAR_HEIGHT );

		final healthBar = new Object( infoContainer );
		final barGraphics = new h2d.Graphics( healthBar );
		
		barGraphics.beginFill( 0x00FF00 );
		barGraphics.drawRect( 0, 0, MobView.HEALTH_BAR_WIDTH, MobView.HEALTH_BAR_HEIGHT );
		
		infoContainer.visible = false;

		final mob = new MobView( mobContainer, infoContainer, mobObject, Up, mobAnim, healthBar, fullHealth );
		return mob;
	}
}