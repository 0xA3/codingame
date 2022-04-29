package player;

import gameengine.core.GameManager;
import h2d.Interactive;
import h2d.Object;
import hxd.Window;
import tink.CoreApi.Noise;
import tink.core.Signal;
import view.FrameViewData;
import xa3.MapUtils.size;

using Lambda;

class App extends hxd.App {

	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	public static inline var SCENE_WIDTH = 1628;
	public static inline var SCENE_HEIGHT = 832;
	// public static inline var CANVAS_WIDTH = 1920 / 2;
	// public static inline var CANVAS_HEIGHT = 1080 / 2;
	public static inline var CANVAS_WIDTH = 1724;
	public static inline var CANVAS_HEIGHT = 970;
	
	public var initComplete(default, null):Signal<Noise>;
	var initTrigger:SignalTrigger<Noise>;
	
	final gameManager:GameManager;
	
	var width = SCENE_WIDTH;
	var height = SCENE_HEIGHT;
	
	public static var scaleFactor = 1.0;
	
	var stage:Window;
	var currentFrame:Int;
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
		
		stage = Window.getInstance();
		stage.addResizeEvent( onResize );
		final scene = new Object( s2d );
		final entityCreator = new player.EntityCreator();
		entityCreator.createBackground( scene );
		
		sliderContainer = new Object( s2d );
		sliderView = entityCreator.createSlider( sliderContainer, "Frame", () -> 0, goToFrame, over );

		gameView = new player.GameView( s2d, scene, entityCreator );
		gameView.initEntities();
		
		onResize();
		initTrigger.trigger( Noise );
	}

	public function setDimensions( width:Int, height:Int ) {
		// trace( 'setDimensions $width $height' );
		this.width = width;
		this.height = height;
	}

	override public function onResize() {
		final scaleX = stage.width / CANVAS_WIDTH;
		final scaleY = stage.height / CANVAS_HEIGHT;

		final minScale = Math.min( scaleX, scaleY );
		gameView.scene.scaleX = scaleFactor = gameView.scene.scaleY = minScale;

		sliderContainer.y = stage.height - 40;
		sliderView.width = stage.width;
	}

	public function addFrameViewData( dataset:FrameViewData ) {
		frameDatasets.push( dataset );
		gameView.createMobs( dataset );

		if( frameDatasets.length > 1 ) {
			final nextFrame = frameDatasets.length - 1;
			sliderView.maxValue = nextFrame;
			

			// final previousFrame = Std.int( Math.max( 0, frameDatasets.length - 3 ));
			// final currentFrame = frameDatasets.length - 2;
			// gameView.update( frameDatasets[previousFrame], frameDatasets[currentFrame], frameDatasets[nextFrame], 0 );
		}
	}

	public function updateFirstFrame() {
		if( frameDatasets.length < 2 ) return;
		gameView.update( frameDatasets[0], frameDatasets[1], frameDatasets[1], 0 );
	}

	function goToFrame( f:Float ) {
		currentFrame = Math.floor( f );
		final previousFrame = Std.int( Math.max( 0, currentFrame - 1 ));
		final nextFrame = Std.int( Math.min( frameDatasets.length - 1, currentFrame + 1 ));
		final subFrame = f - currentFrame;
		over( f );
		gameView.update( frameDatasets[previousFrame], frameDatasets[currentFrame], frameDatasets[nextFrame], subFrame );
	}

	function over( f:Float ) {
		gameView.over( s2d.mouseX, sliderContainer.y - 4, f );
	}

	override function update( dt:Float ) {
		if( s2d.mouseY < sliderContainer.y - 10 ) {
			gameView.mouseOver( s2d.mouseX, s2d.mouseY, frameDatasets[currentFrame] );
		}
	}
}
