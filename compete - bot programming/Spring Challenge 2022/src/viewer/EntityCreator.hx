package viewer;

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

	public function createHeart( parent:Object, x:Int, y:Int ) {
		final heart = new Bitmap( tileLibrary["heart_OK0001"], new Graphics( parent ) );
		heart.x = x;
		heart.y = y;
		return heart;
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

		final hero = new HeroView( heroContainer, infoContainer, heroObject, Math.PI, textField );
		return hero;
	}
	
	public function createMob( parent:Object, type:Int, fullHealth:Int ) {
		final mobContainer = new Object( parent );
		final infoContainer = new Object( mobContainer );
		infoContainer.x = -MobView.HEALTH_BAR_WIDTH / 2;
		infoContainer.y = MobView.HEALTH_BAR_Y - MobView.HEALTH_BAR_HEIGHT;
		
		final mobObject = new Object( mobContainer );
		final mobTile = switch type {
			case 0: tileLibrary["M1_OK0001"];
			case 1: tileLibrary["M2_OK0001"];
			case 2: tileLibrary["M3_OK0001"];
			default: throw 'Error there is no mob type $type';
		}
		
		final mobBitmap = new Bitmap( mobTile, mobObject );
		mobBitmap.x = -mobBitmap.tile.width / 2;
		mobBitmap.y = -mobBitmap.tile.height / 2;
		mobObject.scaleX = mobBitmap.scaleY = 1.5;
		
		
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