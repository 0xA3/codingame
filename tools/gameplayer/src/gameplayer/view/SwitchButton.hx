package gameplayer.view;

import h2d.Bitmap;
import h2d.Interactive;
import h2d.Object;

class SwitchButton {
	
	public final object:Object;
	public final interactive:Interactive;
	final bitmap1:Bitmap;
	final bitmap2:Bitmap;
	
	public function new( object:Object, interactive:Interactive, bitmap1:Bitmap, bitmap2:Bitmap ) {
		this.object = object;
		this.interactive = interactive;
		this.bitmap1 = bitmap1;
		this.bitmap2 = bitmap2;
		
		interactive.onOver = e -> {
			bitmap1.alpha = 0.75;
			bitmap2.alpha = 0.75;
		}
		
		interactive.onOut = e -> {
			bitmap1.alpha = 1;
			bitmap2.alpha = 1;
		}
	}

	public function setState( state:Int ) {
		switch state {
			case 0:
				bitmap1.visible = true;
				bitmap2.visible = false;
			case 1:
				bitmap1.visible = false;
				bitmap2.visible = true;
			default: throw 'Error: state must be 0 or 1';
		}
	}

	public dynamic function onClick( e:hxd.Event ) {}
}