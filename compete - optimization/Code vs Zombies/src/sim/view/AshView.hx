package sim.view;

import data.Vec2;
import h2d.Bitmap;
import h2d.Object;

class AshView extends PersonView {
	
	final ash:Bitmap;

	public function new( object:Object, bloodSplatter:Bitmap, ash:Bitmap, position:Vec2 ) {
		super( object, bloodSplatter, position );
		this.ash = ash;
		show();
	}

	override function rotate( angle:Float ) {
		ash.rotation = angle;
	}


}