package game.view;

import h2d.Object;

class CharacterView {

	public final object:Object;
	var x( default, null ):Float;
	var y( default, null ):Float;
	public var isVisible( get, set ):Bool;
	function get_isVisible() return object.visible;
	function set_isVisible( v:Bool ) return object.visible = v;

	public function new( object:Object, x:Int, y:Int ) {
		this.object = object;
		place( x, y );
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
	
	public function place( x:Int, y:Int ) {
		if( !object.visible ) return;
		object.x = this.x = GameView.sX( x );
		object.y = this.y = GameView.sY( y );
		trace( 'xy: $x:$y  oxy ${object.x}:${object.y}' );
	}

}