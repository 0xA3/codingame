package gameplayer.view;

import h2d.Bitmap;
import h2d.Interactive;
import h2d.Object;

class ClickButton {
	
	static final OVER = 1;
	static final OUT = 0.75;
	static final DEACTIVATED = 0.25;

	public final object:Object;
	public final interactive:Interactive;
	final bitmap:Bitmap;

	var isActivated = false;

	public function new( object:Object, interactive:Interactive, bitmap:Bitmap ) {
		this.object = object;
		this.interactive = interactive;
		this.bitmap = bitmap;
		bitmap.alpha = 0.75;
		activate();
	}

	public function activate() {
		if( !isActivated ) {
			bitmap.alpha = OUT;
			interactive.cursor = Button;
			interactive.onOver = e -> bitmap.alpha = OVER;
			interactive.onOut = e -> bitmap.alpha = OUT;
			interactive.onClick = onClick;
			isActivated = true;
		}
		
	}

	public function deactivate() {
		if( isActivated ){
			bitmap.alpha = DEACTIVATED;
			interactive.cursor = Default;
			interactive.onOver = e -> {};
			interactive.onOut = e -> {};
			interactive.onClick = e -> {};
			isActivated = false;
		}
	}

	public dynamic function onClick( e:hxd.Event ) {}
}