package viewer;

import gameengine.core.GameManager;
import gameengine.core.MultiplayerGameManager;
import gameplayer.Gameplayer;
import h2d.Object;
import hxd.Event;
import hxd.Window;
import view.FrameViewData;
import view.GlobalViewData;
import xa3.MathUtils.max;

using Lambda;

class App extends hxd.App {

	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	public static final CANVAS_WIDTH = 1920;
	public static final CANVAS_HEIGHT = 1080;
	
	final playerMeName:String;
	final playerOppName:String;
	
	final onInitComplete:()->Void;
	var width = CANVAS_WIDTH;
	var height = CANVAS_HEIGHT;
	
	public static var scaleFactor = 1.0;
	
	var window:Window;
	var currentFrame:Int;
	final frameDatasets:Array<FrameViewData> = [];

	var gameView:viewer.GameView;
	var gameplayer:gameplayer.Gameplayer;
	
	public function new( playerMeName:String, playerOppName:String, onInitComplete:()->Void ) {
		super();
		this.playerMeName = playerMeName;
		this.playerOppName = playerOppName;
		this.onInitComplete = onInitComplete;
	}

	override function init() {
		window = Window.getInstance();
		final scene = new Object( s2d );

		// final entityCreator = new viewer.EntityCreator();
		// entityCreator.initTiles();
		// final tooltipManager = new TooltipManager( scene, entityCreator.timesFont );
		// final viewModule = new ViewModule( tooltipManager, entityCreator );
		
		gameView = new viewer.GameView( s2d, scene );
		gameView.init( playerMeName, playerOppName );
		
		gameplayer = new gameplayer.Gameplayer( s2d, window );
		gameplayer.init( 2 );
		gameplayer.onChange = goToFrame;

		window.addResizeEvent( onResize );
		window.addEventTarget( onEvent );
		onResize();
		onInitComplete();
	}

	function onEvent( e:Event ) {
		switch( e.kind ) {
			case EKeyDown: //trace('keyCode: ${e.keyCode}');
				switch e.keyCode {
					case 32: gameplayer.playPause();
					case 37: gameplayer.prev();
					case 38: gameplayer.rewind();
					case 39: gameplayer.next();
					case 40: gameplayer.end();
					default: // no-op
				}
			// case EKeyUp: trace('UP keyCode: ${e.keyCode}');
			default: // no-op
		}
	}

	override public function onResize() {
		final scaleX = window.width / CANVAS_WIDTH;
		final scaleY = window.height / CANVAS_HEIGHT;

		final minScale = Math.min( scaleX, scaleY );
		// trace( 'onResize $minScale' );
		gameView.scene.scaleX = scaleFactor = gameView.scene.scaleY = minScale;
	}

	public function receiveViewGlobalData( dataset:GlobalViewData ) {
		trace( 'receiveViewGlobalData\n$dataset' );
	}

	public function receiveFrameViewData( dataset:FrameViewData ) {
		frameDatasets.push( dataset );
		gameView.updateFrame( frameDatasets.length - 1, dataset );
		
		if( frameDatasets.length > 1 ) {
			final nextFrame = frameDatasets.length - 1;
			gameplayer.maxFrame = nextFrame;
			gameplayer.next();
		}
	}

	function goToFrame( frame:Float ) {
		currentFrame = max( 0, Math.floor( frame ));
		
		final subFrame = frame - currentFrame;
		gameView.update( frame, currentFrame, subFrame, frameDatasets );
	}

	override function update( dt:Float ) {
		gameplayer.update( dt );
		if( s2d.mouseY < window.height - Gameplayer.HEIGHT ) {
			if( frameDatasets.length > 0 ) gameView.mouseOver( s2d.mouseX, s2d.mouseY, frameDatasets[currentFrame] );
		} else gameView.mouseOut();
	}
}
