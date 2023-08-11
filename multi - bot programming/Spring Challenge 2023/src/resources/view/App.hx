package resources.view;

import gameplayer.Gameplayer;
import h2d.Object;
import hxd.Event;
import hxd.Window;
import main.view.FrameViewData;
import main.view.GlobalViewData;
import resources.view.Types.FrameData;
import resources.view.Types.FrameInfo;
import resources.view.Types.PlayerInfo;
import xa3.MathUtils.max;

using Lambda;

class App extends hxd.App {

	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	public static final CANVAS_WIDTH = 1920;
	public static final CANVAS_HEIGHT = 1080;
	
	final onInitComplete:()->Void;
	var width = CANVAS_WIDTH;
	var height = CANVAS_HEIGHT;
	
	public static var scaleFactor = 1.0;
	
	var window:Window;
	var currentFrame:Int;
	final frameInfoDatasets:Array<FrameInfo> = [];
	final frameDatasets:Array<FrameData> = [];
	
	var viewModule:ViewModule;
	var gameplayer:gameplayer.Gameplayer;
	
	public function new( onInitComplete:()->Void ) {
		super();
		this.onInitComplete = onInitComplete;
	}

	override function init() {
		window = Window.getInstance();
		final scene = new Object( s2d );

		// final entityCreator = new resources.view.EntityCreator();
		// entityCreator.initTiles();
		// final tooltipManager = new TooltipManager( scene, entityCreator.timesFont );
		viewModule = new ViewModule();
		
		// gameView = new resources.view.GameView( s2d, scene );
		// gameView.init( playerMeName, playerOppName );
		
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
		// gameView.scene.scaleX = scaleFactor = gameView.scene.scaleY = minScale;
	}

	public function receiveViewGlobalData( players:Array<PlayerInfo>, dataset:GlobalViewData ) {
		trace( 'receiveViewGlobalData\n${dataset.cells}' );
		viewModule.handleGlobalData( players, dataset );
	}

	public function receiveFrameViewData( dataset:FrameViewData ) {
		trace( 'receiveFrameViewData\n$dataset' );
		
		final number = frameDatasets.length;
		final duration = dataset.duration;
		final date = frameInfoDatasets.length == 0 ? 0 : frameInfoDatasets[frameInfoDatasets.length - 1].date + duration;

		final frameInfoDataset:FrameInfo = {
			number: number,
			frameDuration: duration,
			date: date
		}
		frameInfoDatasets.push( frameInfoDataset );
		
		final dataset = viewModule.handleFrameData( frameInfoDataset, dataset );
		frameDatasets.push( dataset );
		viewModule.updateScene( frameDatasets[frameDatasets.length - 1], dataset, 0 );
		
		if( frameDatasets.length > 1 ) {
			final nextFrame = frameDatasets.length - 1;
			gameplayer.maxFrame = nextFrame;
			gameplayer.next();
		}
	}

	function goToFrame( frame:Float ) {
		currentFrame = max( 0, Math.floor( frame ));
		
		final subFrame = frame - currentFrame;
		// gameView.update( frame, currentFrame, subFrame, frameDatasets );
	}

	override function update( dt:Float ) {
		// gameplayer.update( dt );
		// if( s2d.mouseY < window.height - Gameplayer.HEIGHT ) {
		// 	if( frameDatasets.length > 0 ) gameView.mouseOver( s2d.mouseX, s2d.mouseY, frameDatasets[currentFrame] );
		// } else gameView.mouseOut();
	}
}
