package gameplayer;

import Std.int;
import gameplayer.view.ClickButton;
import gameplayer.view.Slider;
import gameplayer.view.SwitchButton;
import gameplayer.view.Tooltip;
import h2d.Object;
import h2d.Scene;
import h2d.Text;
import hxd.Window;

class Gameplayer {
	
	static final DEFAULT_WIDTH = 800;
	public static final HEIGHT = 58;

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
	var frameCounter:Text;

	var slider:Slider;
	var tooltip:Tooltip;

	var currentFrame = -1.0;
	
	var framesPerSecond = 1.0;

	public function new( s2d:Scene, window:Window ) {
		this.s2d = s2d;
		this.window = window;
	}

	public var maxFrame(default, set):Int = 0;
	function set_maxFrame( max:Int ) {
		if( max == maxFrame ) return max;
		if( max > maxFrame ) {
			if( currentFrame == maxFrame ) {
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
		slider.update( currentFrame, maxFrame );
		frameCounter.text = '${int( currentFrame )}/$maxFrame';
		return maxFrame;
	}
	
	public function init( framesPerSecond = 1.0 ) {
		EntityCreator.populateLibrary( window, new Object( s2d ), library );
		try { library.verify(); }
		catch( e ) {
			trace( e );
			Sys.exit( 0 );
		}
	
		this.framesPerSecond = framesPerSecond;
		
		gameplayerContainer = library.gameplayerContainer;
		gameplayerBackground = library.gameplayerBackground;
		bRewind = library.bRewind;
		bPrev = library.bPrev;
		bPlay = library.bPlay;
		bNext = library.bNext;
		bEnd = library.bEnd;
		slider = library.slider;
		tooltip = library.tooltip;
		
		bRewind.onClick = rewind;
		bPrev.onClick = prev;
		bPlay.onClick = playPause;
		bNext.onClick = next;
		bEnd.onClick = end;
		frameCounter = library.frameCounter;

		slider.onPush = onSliderPush;
		slider.onRelease = tooltip.hide;
		slider.onChange = onSliderChange;

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
			final frame = Math.min( maxFrame, currentFrame + ( dt * framesPerSecond ));
			slider.update( frame, maxFrame );
			updateButtons( frame );
			currentFrame = frame;
			if( frame == maxFrame ) pause();
			onChange( currentFrame );
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
		frameCounter.text = '${int( frame )}/$maxFrame';
	}

	public function rewind( ?e:hxd.Event ) {
		pause();
		final frame = 0;
		slider.update( frame, maxFrame );
		updateButtons( frame );
		currentFrame = frame;
		onChange( currentFrame );
	}

	public function prev( ?e:hxd.Event ) {
		pause();
		final frame = currentFrame % 1 < 0.1 ? Math.floor( currentFrame - 1 ) : Math.floor( currentFrame );
		slider.update( frame, maxFrame );
		updateButtons( frame );
		currentFrame = frame;
		onChange( currentFrame );
	}
	
	public function playPause( ?e:hxd.Event ) {
		// trace( 'playPause' );
		switch state {
			case Paused: play();
			case Playing: pause();
		}
	}
	
	public function pause( ?e:hxd.Event ) {
		if( state == Playing ) {
			// trace( 'onPause' );
			state = Paused;
			bPlay.setState( 1 );
		}
	}

	public function play( ?e:hxd.Event ) {
		if( state == Paused ) {
			// trace( 'onPlay' );
			state = Playing;
			bPlay.setState( 0 );

		}
	}
	
	public function next( ?e:hxd.Event ) {
		pause();
		final frame = currentFrame % 1 > 0.9 ? Math.floor( currentFrame + 2 ) : Math.floor( currentFrame + 1 );
		slider.update( frame, maxFrame );
		updateButtons( frame );
		currentFrame = frame;
		onChange( currentFrame );
	}

	public function end( ?e:hxd.Event ) {
		pause();
		final frame = maxFrame;
		slider.update( frame, maxFrame );
		updateButtons( frame );
		currentFrame = frame;
		onChange( currentFrame );
	}

	function onResize() {
		gameplayerContainer.y = window.height;
		var scaleX = window.width / DEFAULT_WIDTH;
		gameplayerBackground.scaleX = scaleX;
		slider.resize( scaleX );
	}
	
	function onSliderPush() {
		pause();
		tooltip.show();
	}
	
	function onSliderChange() {
		final frame = slider.dragFraction * maxFrame;
		updateButtons( frame );
		tooltip.update( frame, maxFrame );
		currentFrame = frame;
		onChange( currentFrame );
	}

	public dynamic function onChange( f:Float ) { }
}