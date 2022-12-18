package viewer;

import gameengine.core.GameManager;
import gameplayer.Gameplayer;
import h2d.Object;
import hxd.Window;
import view.FrameViewDataset;
import view.GlobalViewDataset;

using Lambda;

class App extends hxd.App {

	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	public static final CANVAS_WIDTH = 1920;
	public static final CANVAS_HEIGHT = 1080;
	
	final gameManager:GameManager;
	final onInitComplete:()->Void;
	
	var width = CANVAS_WIDTH;
	var height = CANVAS_HEIGHT;
	
	public static var scaleFactor = 1.0;
	
	var window:Window;
	var currentFrame:Int;
	final frameDatasets:Array<FrameViewDataset> = [];

	var gameView:viewer.GameView;
	var gameplayer:gameplayer.Gameplayer;
	
	public function new( gameManager:GameManager, onInitComplete:()->Void ) {
		super();
		this.gameManager = gameManager;
		this.onInitComplete = onInitComplete;
	}

	override function init() {
		window = Window.getInstance();
		final scene = new Object( s2d );
		
		final entityCreator = new viewer.EntityCreator();
		entityCreator.initTiles();
		
		gameView = new viewer.GameView( s2d, scene, entityCreator );
		gameView.init( gameManager.players[0].name, gameManager.players[1].name );
		
		gameplayer = new gameplayer.Gameplayer( s2d, window );
		gameplayer.init( 2 );
		gameplayer.onChange = goToFrame;

		window.addResizeEvent( onResize );
		onResize();
		onInitComplete();
	}

	override public function onResize() {
		final scaleX = window.width / CANVAS_WIDTH;
		final scaleY = window.height / CANVAS_HEIGHT;

		final minScale = Math.min( scaleX, scaleY );
		trace( 'onResize $minScale' );
		gameView.scene.scaleX = scaleFactor = gameView.scene.scaleY = minScale;
	}

	public function receiveViewGlobalData( dataset:GlobalViewDataset ) {
		trace( 'receiveViewGlobalData\n$dataset' );
		width = dataset.width;
		height = dataset.height;
	}

	public function receiveFrameViewData( frame:Int, dataset:FrameViewDataset ) {
		trace( 'receiveFrameViewData $frame\n$dataset' );
		frameDatasets.push( dataset );
		gameView.addFrameViewData( frame, dataset );

		if( frameDatasets.length > 1 ) {
			final nextFrame = frameDatasets.length - 1;
			gameplayer.maxFrame = nextFrame;
		}
	}

	function goToFrame( frame:Float ) {
		currentFrame = Math.floor( frame );
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
