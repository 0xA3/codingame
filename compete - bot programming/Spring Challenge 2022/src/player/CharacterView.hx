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
	function get_isVisible() return container.visible;
	function set_isVisible( v:Bool ) return container.visible = v;

	public function new( container:Object, object:Object ) {
		this.container = container;
		this.object = object;
	}
	
	public function show() {
		container.visible = true;
	}
	public function hide() {
		container.visible = false;
	}

	public function die() {
		container.visible = false;
	}

	public function live() {
		container.visible = true;
	}

	public function rotate( angle:Float ) object.rotation = angle;
	
	public function place( x:Float, y:Float ) {
		if( !container.visible ) return;
		container.x = this.x = sX( x );
		container.y = this.y = sY( y );
	}

}