package sim.view;

import data.Vec2;
import h2d.Bitmap;
import h2d.Object;

class AshView extends HumanView {
	
	final ash:Bitmap;

	public function new( object:Object, ash:Bitmap, position:Vec2 ) {
		super( object, position );
		this.ash = ash;
	}

	override function rotate( angle:Float ) {
		ash.rotation = angle;
	}


}