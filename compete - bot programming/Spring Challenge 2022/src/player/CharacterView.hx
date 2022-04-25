package player;

import h2d.Object;
import player.GameView.sX;
import player.GameView.sY;

class CharacterView {

	public final container:Object;
	public final object:Object;
	var x( default, null ) = 0.0;
	var y( default, null ) = 0.0;
	public var isVisible( get, set ):Bool;
	function get_isVisible() return object.visible;
	function set_isVisible( v:Bool ) return object.visible = v;

	public function new( container:Object, object:Object ) {
		this.container = container;
		this.object = object;
	}
	
	public function show() {
		object.visible = true;
	}
	public function hide() {
		object.visible = false;
	}

	public function die() {
		object.visible = false;
	}

	public function live() {
		object.visible = true;
	}

	public function rotate( angle:Float ) object.rotation = angle;
	
	public function place( x:Float, y:Float ) {
		if( !object.visible ) return;
		container.x = this.x = sX( x );
		container.y = this.y = sY( y );
	}

}