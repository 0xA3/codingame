package sim;

import Math.round;
import data.Vec2;
import h2d.Bitmap;
import h2d.Flow;
import h2d.Graphics;
import h2d.Object;
import h2d.Tile;
import h3d.mat.BlendMode;
import sim.view.AshView;
import sim.view.PersonView;
import sim.view.SliderView;
import sim.view.ZombieView;

class EntityCreator {
	
	final backgroundTile = hxd.Res.background.toTile();
	final ashGlowTile = hxd.Res.ash_glow.toTile();
	final ashShadowTile = hxd.Res.ash_shadow.toTile();
	final ashTile = hxd.Res.ash.toTile().center();
	final humanTile = hxd.Res.human.toTile().center();
	final zombie1Tile = hxd.Res.zombie1.toTile().center();
	final bloodTiles = [
		hxd.Res.blood_splatter_01.toTile().center(),
		hxd.Res.blood_splatter_02.toTile().center(),
		hxd.Res.blood_splatter_03.toTile().center(),
		hxd.Res.blood_splatter_04.toTile().center(),
		hxd.Res.blood_splatter_05.toTile().center(),
		hxd.Res.blood_splatter_06.toTile().center(),
		hxd.Res.blood_splatter_07.toTile().center(),
		hxd.Res.blood_splatter_08.toTile().center(),
		hxd.Res.blood_splatter_09.toTile().center(),
		hxd.Res.blood_splatter_10.toTile().center()
	];
	

	public function new() {

	}

	public function createBackground( scene:Object ) {
		new Bitmap( backgroundTile, new Graphics( scene ) );
	}

	public function createAsh( x:Int, y:Int ) {
		final ashObject = new Object();
		final glowBitmap = new Bitmap( ashGlowTile, ashObject );
		final shadowBitmap = new Bitmap( ashShadowTile, ashObject );
		final splatterBitmap = new Bitmap();
		final ashBitmap = new Bitmap( ashTile, ashObject );
		
		glowBitmap.alpha = 0.3;
		glowBitmap.x = -round( ashGlowTile.width / 2 );
		glowBitmap.y = -round( ashGlowTile.height / 2 );
		shadowBitmap.alpha = 0.5;
		shadowBitmap.x = -85;
		shadowBitmap.y = -10;
		final ash = new AshView( ashObject, splatterBitmap, ashBitmap, x, y );
		return ash;
	}

	public function createHuman( parent:Object, x:Int, y:Int, bloodSplatter:Bitmap ) {
		final humanObject = new Object( parent );
		final humanBitmap = new Bitmap( humanTile, humanObject );
		humanBitmap.x = -round( humanTile.width / 2 );
		humanBitmap.y = -round( humanTile.height / 2 );
		humanBitmap.rotation = Math.random() * Math.PI * 2;
		
		final human = new PersonView( humanObject, bloodSplatter, x, y );
		return human;
	}
	
	public function createZombie( parent:Object, x:Int, y:Int, bloodSplatter:Bitmap ) {
		final zombieObject = new Object( parent );
		final zombieBitmap = new Bitmap( zombie1Tile, zombieObject );
		
		final zombie = new ZombieView( zombieObject, bloodSplatter, x, y );
		return zombie;
	}

	public function createBlood( parent:Object ) {
		final bloodBitmap = new Bitmap( bloodTiles[Std.random( bloodTiles.length )], parent );
		bloodBitmap.rotation = Math.random() * Math.PI * 2;
		bloodBitmap.blendMode = BlendMode.Multiply;
		return bloodBitmap;		
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