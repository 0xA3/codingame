package sim.view;

import data.Position;
import h2d.Bitmap;
import h2d.Object;

class AshView extends HumanView {
	
	final ash:Bitmap;

	public function new( object:Object, ash:Bitmap, position:Position ) {
		super( object, position );
		this.ash = ash;
	}

}