package game;

import Math.round;
import game.view.CharacterView;
import game.view.SliderView;
import h2d.Bitmap;
import h2d.Flow;
import h2d.Graphics;
import h2d.Object;
import h2d.Tile;
import h3d.mat.BlendMode;

class EntityCreator {
	
	final backgroundTile = hxd.Res.background.toTile();
	final heartTile = hxd.Res.heart.toTile();
	final heroTiles = [
		hxd.Res.hero1.toTile().center(),
		hxd.Res.hero2.toTile().center()
	];

	final monsterTiles = [
		hxd.Res.monster1.toTile().center(),
		hxd.Res.monster2.toTile().center()
	];

	public function new() {}

	public function createBackground( scene:Object ) {
		final background = new Bitmap( backgroundTile, new Graphics( scene ) );
		// background.scaleX = background.scaleY = 4;
	}

	public function createHeart( parent:Object, x:Int, y:Int ) {
		final heart = new Bitmap( heartTile, new Graphics( parent ) );
		heart.x = x;
		heart.y = y;
		return heart;
	}

	public function createHero( parent:Object, x:Int, y:Int, rotation:Float, player:Int ) {
		final heroObject = new Object( parent );
		final heroBitmap = new Bitmap( heroTiles[player], heroObject );
		
		final hero = new CharacterView( heroObject, x, y );
		hero.rotate( rotation );
		return hero;
	}
	
	public function createMonster( parent:Object, x:Int, y:Int, type:Int ) {
		final monsterObject = new Object( parent );
		new Bitmap( monsterTiles[type], monsterObject );
		
		final monster = new CharacterView( monsterObject, x, y );
		return monster;
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