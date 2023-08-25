package resources.view.pixi;

import h2d.Bitmap;
import h2d.Tile;
import h3d.Vector;

class Sprite extends Bitmap {
	
	public final anchor:SpriteAnchor;
	public final position:SpritePosition;
	public final sscale:SpriteScale;

	public var interactive = false;
	public var zIndex = 0;
		
	@:isVar public var tint(get, set):Int;
	function get_tint() {
		final rgb = this.color.clone();
		rgb.a = 0;
		return rgb.toColor();
	}
	function set_tint( c:Int ) {
		final rgb = Vector.fromColor( c );
		rgb.a = 1;
		this.color = rgb;
		return c;
	}

	public function new( tile:Tile, ?parent:h2d.Object ) {
		super( tile, parent );
		anchor = new SpriteAnchor( tile );
		position = new SpritePosition( this );
		sscale = new SpriteScale( this );
	}
}

class SpriteAnchor {
	
	final tile:Tile;

	public function new( tile:Tile ) {
		this.tile = tile;
	}

	public function set( x:Float, ?y:Float ) {
		tile.dx = x * -tile.width;
		tile.dy = y == null ? x * -tile.height : y * -tile.height;
		// trace( 'SpriteAnchor.set( ${tile.dx}, ${tile.dy })' );

	}
}

class SpritePosition {
	
	final sprite:Sprite;

	public function new( sprite:Sprite ) {
		this.sprite = sprite;
	}

	public function set( x:Float, y:Float ) {
		sprite.x = x;
		sprite.y = y;
		// trace( 'SpritePosition.set( $x, $y )' );
	}
}

class SpriteScale {
	
	@:var public var x(get, set):Float;
	function get_x() return sprite.scaleX;
	function set_x( x:Float ) return sprite.scaleX = x;

	@:var public var y(get, set):Float;
	function get_y() return sprite.scaleY;
	function set_y( y:Float ) return sprite.scaleY = y;

	final sprite:Sprite;

	public function new( sprite:Sprite ) {
		this.sprite = sprite;
	}

	public function set( x:Float, y:Float ) {
		sprite.x = x;
		sprite.y = y;
		// trace( 'SpritePosition.set( $x, $y )' );
	}
}