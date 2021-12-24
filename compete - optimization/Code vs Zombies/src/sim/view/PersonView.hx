package sim.view;

import data.Vec2;
import h2d.Bitmap;
import h2d.Object;

class PersonView {

	public final object:Object;
	public final bloodSplatter:Bitmap;
	var x( default, null ):Float;
	var y( default, null ):Float;
	public var isVisible( get, set ):Bool;
	function get_isVisible() return object.visible;
	function set_isVisible( v:Bool ) return object.visible = v;

	public function new( object:Object, bloodSplatter:Bitmap, position:Vec2 ) {
		this.object = object;
		this.bloodSplatter = bloodSplatter;
		place( position.x, position.y );
		hide();
	}
	
	public function show() {
		object.visible = true;
		bloodSplatter.visible = false;
	}
	public function hide() {
		object.visible = false;
		bloodSplatter.visible = false;
	}

	public function die() {
		object.visible = false;
		bloodSplatter.x = object.x;
		bloodSplatter.y = object.y;
		bloodSplatter.visible = true;
	}

	public function live() {
		bloodSplatter.visible = false;
		object.visible = true;
	}

	public function rotate( angle:Float ) object.rotation = angle;
	
	public function place( x:Float, y:Float ) {
		if( !object.visible ) return;
		this.x = x;
		this.y = y;
		object.x = x / App.WIDTH * ( App.SCENE_WIDTH - App.X0 ) + App.X0;
		object.y = y / App.HEIGHT * ( App.SCENE_HEIGHT - App.Y0 ) + App.Y0;
	}

}