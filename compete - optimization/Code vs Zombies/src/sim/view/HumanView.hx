package sim.view;

import data.Vec2;
import h2d.Object;

class HumanView {
	
	final object:Object;
	var x( default, null ):Int;
	var y( default, null ):Int;

	public function new( object:Object, position:Vec2 ) {
		this.object = object;
		moveTo( position );
	}

	public function rotate( angle:Float ) {
		object.rotation = angle;
	}

	public function moveTo( position:Vec2, isAlive = true ) {
		if( !isAlive ) {
			object.x = -1000;
			return;
		}
		x = position.x;
		y = position.y;
		object.x = position.x / App.WIDTH * ( App.SCENE_WIDTH - App.X0 ) + App.X0;
		object.y = position.y / App.HEIGHT * ( App.SCENE_HEIGHT - App.Y0 ) + App.Y0;
	}

}