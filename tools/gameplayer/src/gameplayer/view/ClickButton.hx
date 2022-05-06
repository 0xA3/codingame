package gameplayer.view;

import h2d.Bitmap;
import h2d.Interactive;

class ClickButton {
	
	static final OVER = 1;
	static final OUT = 0.75;
	static final DEACTIVATED = 0.25;

	public final interactive:Interactive;
	final bitmap:Bitmap;

	public function new( interactive:Interactive, bitmap:Bitmap ) {
		this.interactive = interactive;
		this.bitmap = bitmap;
		bitmap.alpha = 0.75;
	}

	public function activate() {
		bitmap.alpha = OUT;
		interactive.cursor = Button;
		interactive.onOver = e -> bitmap.alpha = OVER;
		interactive.onOut = e -> bitmap.alpha = OUT;
		interactive.onClick = click;
	}

	public function deactivate() {
		bitmap.alpha = DEACTIVATED;
		interactive.cursor = Default;
		interactive.onOver = e -> {};
		interactive.onOut = e -> {};
		interactive.onClick = e -> {};
	}

	public dynamic function click( e:hxd.Event ) {}
}