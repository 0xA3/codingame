package gameplayer.view;

import h2d.Bitmap;
import h2d.Interactive;

class SwitchButton {
	
	public final interactive:Interactive;
	final bitmap1:Bitmap;
	final bitmap2:Bitmap;
	
	var currentBitmap:Bitmap;
	var otherBitmap:Bitmap;

	public function new( interactive:Interactive, bitmap1:Bitmap, bitmap2:Bitmap ) {
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
}