package player;

import Std.int;
import h2d.Bitmap;
import h2d.Flow;
import h2d.Graphics;
import h2d.Object;
import player.CharacterView;
import view.SliderView;

class EntityCreator {
	
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
		init();
	}

	function init() {
		// createHerosTiles();

	}

/*	function createHerosTiles() {
		final mapData:TiledMapData = haxe.Json.parse(hxd.Res.heroes_json.entry.getText());
		final tileImage = hxd.Res.heroes_png.toTile();

		final group = new h2d.TileGroup( tileImage );
		
		var tw = mapData.tilewidth;
		var th = mapData.tileheight;
		var mw = mapData.width;
		var mh = mapData.height;

		// make sub tiles from tile
		var tiles = [
			for(y in 0 ... Std.int(tileImage.height / th))
			for(x in 0 ... Std.int(tileImage.width / tw))
			tileImage.sub(x * tw, y * th, tw, th)
	   ];
	   
	   // iterate on all layers
	   for(layer in mapData.layers) {
		   // iterate on x and y
		   for(y in 0 ... mh) for (x in 0 ... mw) {
			   // get the tile id at the current position
			   var tid = layer.data[x + y * mw];
			   if (tid != 0) { // skip transparent tiles
				   // add a tile to the TileGroup
				   group.add(x * tw, y * th, tiles[tid - 1]);
			   }
		   }
	   }
   }
*/
	public function createBackground( scene:Object ) {
		final background = new Bitmap( backgroundTile, new Graphics( scene ) );
	}

	public function createHeart( parent:Object, x:Int, y:Int ) {
		final heart = new Bitmap( heartTile, new Graphics( parent ) );
		heart.x = x;
		heart.y = y;
		return heart;
	}

	public function createHero( parent:Object, player:Int ) {
		final heroContainer = new Object( parent );
		final heroObject = new Object( heroContainer );
		new Bitmap( heroTiles[player], heroObject );
		
		final hero = new CharacterView( heroContainer, heroObject );
		return hero;
	}
	

	public function createMob( parent:Object, type:Int, fullHealth:Int ) {
		final mobContainer = new Object( parent );
		final mobObject = new Object( mobContainer );
		new Bitmap( mobTiles[type], mobObject );
		
		final healthBarContainer = new Object( mobContainer );
		healthBarContainer.x = -MobView.HEALTH_BAR_WIDTH / 2;
		healthBarContainer.y = -32 - MobView.HEALTH_BAR_HEIGHT;
		
		final bgGraphics = new h2d.Graphics( healthBarContainer );
		bgGraphics.beginFill( 0xFF0000 );
		bgGraphics.drawRect( 0, 0, MobView.HEALTH_BAR_WIDTH, MobView.HEALTH_BAR_HEIGHT );

		final healthBar = new Object( healthBarContainer );
		final barGraphics = new h2d.Graphics( healthBar );
		
		barGraphics.beginFill( 0x00FF00 );
		barGraphics.drawRect( 0, 0, MobView.HEALTH_BAR_WIDTH, MobView.HEALTH_BAR_HEIGHT );
		
		healthBarContainer.visible = false;

		final mob = new MobView( mobContainer, mobObject, healthBarContainer, healthBar, fullHealth );
		return mob;
	}

	public function createSlider( scene:Object, label:String, get:Void -> Float, set:Float -> Void, min:Float = 0., max:Float = 1. ) {
		var flow = new h2d.Flow( scene );

		flow.horizontalSpacing = 5;

		var textInput = new h2d.Text( getFont(), flow );
		textInput.text = label;
		textInput.maxWidth = 70;
		textInput.textAlign = Right;

		var slider = new h2d.Slider( 100, 10, flow );
		slider.minValue = min;
		slider.maxValue = max;
		slider.value = get();

		var textInput = new h2d.TextInput( getFont(), flow );
		textInput.text = "" + hxd.Math.fmt( slider.value );
		slider.onChange = function() {
			set( slider.value );
			textInput.text = '${hxd.Math.fmt( slider.value )}';
			flow.needReflow = true;
		};
		textInput.onChange = function() {
			var v = Std.parseFloat( textInput.text );
			if( Math.isNaN( v )) return;
			slider.value = v;
			set( v );
		};
		final setFrame = ( v:Float ) -> {
			slider.value = v;
			textInput.text = '${hxd.Math.fmt( v )}';
			flow.needReflow = true;
		}
		return new SliderView( slider, setFrame );
	}

	function getFont() return hxd.res.DefaultFont.get();

}