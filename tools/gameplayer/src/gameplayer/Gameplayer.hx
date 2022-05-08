package gameplayer;

import gameplayer.view.ClickButton;
import gameplayer.view.Slider;
import gameplayer.view.SwitchButton;
import h2d.Object;
import h2d.Scene;
import hxd.Window;

class Gameplayer {
	
	static final DEFAULT_WIDTH = 800;

	final s2d:Scene;
	final window:Window;
	final library = new GameplayerLibrary();
	var gameplayerContainer:Object;
	var gameplayerBackground:Object;
	var state:TPlayerState = Paused;

	var bRewind:ClickButton;
	var bPrev:ClickButton;
	var bNext:ClickButton;
	var bEnd:ClickButton;
	var bPlay:SwitchButton;

	public var slider:Slider;

	var currentFrame = -1.0;
	
	public function new( s2d:Scene, window:Window ) {
		this.s2d = s2d;
		this.window = window;
	}

	public var maxFrame(default, set):Int = 0;
	function set_maxFrame( max:Int ) {
		trace( 'set_maxFrame $max' );
		if( max == maxFrame ) return max;
		if( max > maxFrame ) {
			trace( 'max > maxFrame' );
			if( currentFrame == maxFrame ) {
				trace( 'currentFrame == maxFrame' );
				bNext.activate();
				bEnd.activate();
			}
		} else { // max < maxFrame
			if( currentFrame >= max ) {
				bNext.deactivate();
				bEnd.deactivate();
				currentFrame = max;
			}
		}
		maxFrame = max;
		slider.update( currentFrame / maxFrame );
		return maxFrame;
	}
	
	public function init() {
		EntityCreator.populateLibrary( window, new Object( s2d ), library );
		try { library.verify(); }
		catch( e ) {
			trace( e );
			Sys.exit( 0 );
		}
		
		gameplayerContainer = library.gameplayerContainer;
		gameplayerBackground = library.gameplayerBackground;
		bRewind = library.bRewind;
		bPrev = library.bPrev;
		bPlay = library.bPlay;
		bNext = library.bNext;
		bEnd = library.bEnd;
		slider = library.slider;
		slider.onChange = onSliderChange;
		
		bRewind.onClick = rewind;
		bPrev.onClick = prev;
		bPlay.onClick = playPause;
		bNext.onClick = next;
		bEnd.onClick = end;

		bRewind.deactivate();
		bPrev.deactivate();
		bNext.deactivate();
		bEnd.deactivate();

		window.addResizeEvent( onResize );
		onResize();
		updateButtons( 0 );
		currentFrame = 0;
	}
	
	public function update( dt:Float ) {
		if( state == Playing ) {
			final frame = Math.min( maxFrame, currentFrame + dt / 60 );
			slider.update( frame / maxFrame );
			updateButtons( frame );
		}
	}

	function updateButtons( frame:Float ) {
		if( frame < currentFrame ) {
			if( frame <= 0 ) {
				bRewind.deactivate();
				bPrev.deactivate();
			}
			if( currentFrame == maxFrame ) {
				bNext.activate();
				bEnd.activate();
			}
		} else if( frame > currentFrame ) {
			if( currentFrame == 0 ) {
				bRewind.activate();
				bPrev.activate();
			}
			if( frame >= maxFrame ) {
				bNext.deactivate();
				bEnd.deactivate();
			}
		}
	}

	public function rewind( ?e:hxd.Event ) {
		pause();
		final frame = 0;
		slider.update( frame / maxFrame );
		updateButtons( frame );
		currentFrame = frame;
	}

	public function prev( ?e:hxd.Event ) {
		pause();
		final frame = currentFrame % 1 < 0.5 ? Math.floor( currentFrame - 1 ) : Math.floor( currentFrame ) ;
		slider.update( frame / maxFrame );
		updateButtons( frame );
		currentFrame = frame;
	}
	
	public function playPause( ?e:hxd.Event ) {
		switch state {
			case Paused: play();
			case Playing: pause();
		}
	}
	
	public function pause( ?e:hxd.Event ) {
		if( state == Playing ) {
			trace( 'onPause' );
			state = Paused;
			bPlay.setState( 0 );
		}
	}

	public function play( ?e:hxd.Event ) {
		if( state == Paused ) {
			trace( 'onPlay' );
			state = Playing;
			bPlay.setState( 1 );
		}
	}
	
	public function next( ?e:hxd.Event ) {
		pause();
		final frame = Math.floor( currentFrame + 1 );
		slider.update( frame / maxFrame );
		updateButtons( frame );
		currentFrame = frame;
	}

	public function end( ?e:hxd.Event ) {
		pause();
		final frame = maxFrame;
		slider.update( frame / maxFrame );
		updateButtons( frame );
		currentFrame = frame;
	}

	function onResize() {
		gameplayerContainer.y = window.height;
		var scaleX = window.width / DEFAULT_WIDTH;
		gameplayerBackground.scaleX = scaleX;
		slider.resize( scaleX );
	}
	
	function onSliderChange() {
		final frame = slider.dragFraction * maxFrame;
		updateButtons( frame );
		currentFrame = frame;
		onChange();
	}

	public dynamic function onChange() { }
}