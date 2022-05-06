package gameplayer;

import gameplayer.view.ClickButton;
import gameplayer.view.ScrollBar;
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
	var state:TPlayerState = Paused;

	public var bRewind(default, null):ClickButton;
	public var bPrev(default, null):ClickButton;
	public var bNext(default, null):ClickButton;
	public var bEnd(default, null):ClickButton;
	public var bPlay(default, null):SwitchButton;

	public var scrollbar:ScrollBar;
	
	public var currentFrame(default, set):Float = 0;
	function set_currentFrame( frame:Float ) {
		if( frame != currentFrame ) {
			update( frame );
			this.currentFrame = frame;
		}
		return frame;
	}
	
	public var maxFrame(default, set):Int = 0;
	function set_maxFrame( maxFrame:Int ) {
		if( this.maxFrame != maxFrame ) {
			this.maxFrame = maxFrame;
			if( currentFrame > maxFrame ) currentFrame = maxFrame;
			else update( currentFrame );
		}
		return maxFrame;
	}

	public function new( s2d:Scene, window:Window ) {
		this.s2d = s2d;
		this.window = window;
	}

	public  function init() {
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
		bRewind = clickButtons[0];
		bPrev = clickButtons[1];
		bNext = clickButtons[2];
		bEnd = clickButtons[3];
		bPlay = new SwitchButton( interactives[2], bitmaps[2], bitmaps[5] );
		
		final scrollbarContainer = new Object( container );
		scrollbarContainer.y = -44;
		scrollbar = EntityCreator.createScrollbar( scrollbarContainer );

		window.addResizeEvent( onResize );
		onResize();
		currentFrame = 0;
	}
	
	function play() {
		if( state == Paused ) {
			state = Playing;
			bPlay.setState( 0 );
		}
	}

	function update( frame:Float ) { trace( 'update $frame' );
		if( frame == currentFrame ) return;
		if( frame == 0 ) {
			bRewind.deactivate();
			bPrev.deactivate();
			trace( 'deactivate rewind prev' );
		} else if( currentFrame == 0 ) {
			bRewind.activate();
			bPrev.activate();
			trace( 'activate rewind prev' );
		}
		if( frame == maxFrame ) {
			bNext.deactivate();
			bEnd.deactivate();
			if( state == Playing ) {
				state = Paused;
				bPlay.setState( 1 );
			}
			trace( 'deactivate next end' );
		} else if( currentFrame == maxFrame ) {
			bNext.activate();
			bEnd.activate();
			trace( 'activate next end' );
		}
	}

	function onResize() {
		container.y = window.height;
		var scaleX = window.width / DEFAULT_WIDTH;
		background.scaleX = scaleX;
		scrollbar.resize( scaleX );
	}
}