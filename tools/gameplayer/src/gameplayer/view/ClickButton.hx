package gameplayer.view;

import h2d.Bitmap;
import h2d.Interactive;

class ClickButton {
	
	public final interactive:Interactive;
	final bitmap:Bitmap;

	public function new( interactive:Interactive, bitmap:Bitmap ) {
		this.interactive = interactive;
		this.bitmap = bitmap;
		bitmap.alpha = 0.75;

		interactive.onOver = e -> bitmap.alpha = 1;
		interactive.onOut = e -> bitmap.alpha = 0.75;
	}
}