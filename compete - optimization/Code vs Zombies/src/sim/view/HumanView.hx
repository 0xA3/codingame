package sim.view;

import data.Position;
import h2d.Object;

class HumanView {
	
	final object:Object;
	
	public function new( object:Object, position:Position ) {
		this.object = object;
		moveTo( position );
	}

	public function moveTo( position:Position, isAlive = true ) {
		if( !isAlive ) object.x = -1000;
		object.x = position.x / App.WIDTH * ( App.SCENE_WIDTH - App.X0 ) + App.X0;
		object.y = position.y / App.HEIGHT * ( App.SCENE_HEIGHT - App.Y0 ) + App.Y0;
	}

}