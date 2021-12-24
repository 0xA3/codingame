package sim.view;

import h2d.Bitmap;
import h2d.Object;

class AshView extends PersonView {
	
	final ash:Bitmap;

	public function new( object:Object, bloodSplatter:Bitmap, ash:Bitmap, x:Int, y:Int ) {
		super( object, bloodSplatter, x, y );
		this.ash = ash;
		show();
	}

	override function rotate( angle:Float ) {
		ash.rotation = angle;
	}


}