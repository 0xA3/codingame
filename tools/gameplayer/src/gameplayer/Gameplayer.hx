package gameplayer;

import gameplayer.view.ClickButton;
import gameplayer.view.SwitchButton;
import h2d.Object;
import h2d.Scene;
import hxd.Window;

class Gameplayer {
	
	static final DEFAULT_WIDTH = 800;

	final s2d:Scene;
	final window:Window;
	var container:Object;
	var background:Object;

	public function new( s2d:Scene, window:Window ) {
		this.s2d = s2d;
		this.window = window;
	}

	public  function init() {
		trace( 'init' );
		
		container = new Object( s2d );
		background = EntityCreator.createBackground( container );
		final bitmaps = EntityCreator.createBitmaps( container );
		final interactives = EntityCreator.createInteractives( container );
		
		final clickButtons = [];
		for( i in 0...5 ) {
			switch i {
				case 0, 1, 3, 4:
					clickButtons.push( new ClickButton( interactives[i], bitmaps[i] ));
				default: // no-op
			}
		}
		var playButton = new SwitchButton( interactives[2], bitmaps[2], bitmaps[5] );
		
		window.addResizeEvent( onResize );

		onResize();
	}
	
	public function onResize() {
		container.y = window.height;
		background.scaleX = window.width / DEFAULT_WIDTH;
	}
}