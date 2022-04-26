package player;

import gameengine.core.GameManager;
import h2d.Object;
import tink.CoreApi.Noise;
import tink.core.Signal;
import view.FrameViewData;

using Lambda;

class App extends hxd.App {

	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	public static inline var SCENE_WIDTH = 1628;
	public static inline var SCENE_HEIGHT = 832;
	// public static inline var CANVAS_WIDTH = 1920 / 2;
	// public static inline var CANVAS_HEIGHT = 1080 / 2;
	public static inline var CANVAS_WIDTH = 1724 / 2;
	public static inline var CANVAS_HEIGHT = 970 / 2;
	
	public var initComplete(default, null):Signal<Noise>;
	var initTrigger:SignalTrigger<Noise>;
	
	final gameManager:GameManager;
	
	var width = SCENE_WIDTH;
	var height = SCENE_HEIGHT;
	
	var scaleFactor = 1.0;
	
	final frameDatasets:Array<FrameViewData> = [];

	var gameView:player.GameView;
	var sliderContainer:Object;
	var sliderView:view.SliderView;
	
	public function new( gameManager:GameManager ) {
		super();
		this.gameManager = gameManager;
		
		initTrigger = Signal.trigger();
		initComplete = initTrigger.asSignal();
	}

	override function init() {
		
		final scene = new Object( s2d );
		final entityCreator = new player.EntityCreator();
		entityCreator.createBackground( scene );
		gameView = new player.GameView( scene, entityCreator );
		gameView.initEntities();
		
		sliderContainer = new Object( s2d );
		sliderView = entityCreator.createSlider( sliderContainer, "Frame", () -> 0, goToFrame );

		resize();
		initTrigger.trigger( Noise );
	}

	public function setDimensions( width:Int, height:Int ) {
		// trace( 'setDimensions $width $height' );
		this.width = width;
		this.height = height;
	}

	public function resize() {
		// final scaleX = CANVAS_WIDTH / width;
		// final scaleY = CANVAS_HEIGHT / height;
		final scaleX = 0.5;
		final scaleY = 0.5;
		final minScale = Math.min( scaleX, scaleY );
		gameView.scene.scaleX = gameView.scene.scaleY = minScale;
		// trace( 'resize $scaleX $scaleY  width $width  height $height' );

		// sliderContainer.y = scaleX < scaleY ? CANVAS_HEIGHT * scaleX : CANVAS_HEIGHT * scaleY - 10;
		sliderContainer.y = CANVAS_HEIGHT - 40;
		sliderView.width = CANVAS_WIDTH;
	}

	public function addFrameViewData( dataset:FrameViewData ) {
		frameDatasets.push( dataset );

		if( frameDatasets.length > 1 ) {
			final previousFrame = Std.int( Math.max( 0, frameDatasets.length - 3 ));
			final currentFrame = frameDatasets.length - 2;
			final nextFrame = frameDatasets.length - 1;
			sliderView.maxValue = nextFrame;
			// gameView.update( frameDatasets[previousFrame], frameDatasets[currentFrame], frameDatasets[nextFrame], 0 );
		}
	}

	public function updateFirstFrame() {
		if( frameDatasets.length < 2 ) return;
		gameView.update( frameDatasets[0], frameDatasets[1], frameDatasets[1], 0 );
	}

	function goToFrame( f:Float ) {
		final currentFrame = Math.floor( f );
		final previousFrame = Std.int( Math.max( 0, currentFrame - 1 ));
		final nextFrame = Std.int( Math.min( frameDatasets.length - 1, currentFrame + 1 ));
		final subFrame = f - currentFrame;
		gameView.update( frameDatasets[previousFrame], frameDatasets[currentFrame], frameDatasets[nextFrame], subFrame );
	}
}
