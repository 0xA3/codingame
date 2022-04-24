package game;

import Std.parseInt;
import h2d.Object;
import view.FrameViewData;

using Lambda;

class App extends hxd.App {

	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	public static inline var SCENE_WIDTH = 1628;
	public static inline var SCENE_HEIGHT = 832;
	public static inline var CANVAS_WIDTH = 1724;
	public static inline var CANVAS_HEIGHT = 970;
	
	var width = SCENE_WIDTH;
	var height = SCENE_HEIGHT;
	
	var scaleFactor = 1.0;
	
	final frameViewDatasets:Array<FrameViewData> = [];

	var gameView:view.GameView;
	var sliderContainer:Object;
	var sliderView:view.SliderView;
	
	public function new() {
		super();
	}

	override function init() {
		final scene = new Object( s2d );
		final entityCreator = new EntityCreator();
		entityCreator.createBackground( scene );
		gameView = new view.GameView( scene, entityCreator );
		gameView.initEntities();
		
		sliderContainer = new Object( s2d );
		sliderView = entityCreator.createSlider( sliderContainer, "Frame", () -> 0, goToFrame );

		resize();
	}

	public function setDimensions( width:Int, height:Int ) {
		// trace( 'setDimensions $width $height' );
		this.width = width;
		this.height = height;
	}

	public function resize() {
		// trace( 'resize' );
		final scaleX = width / SCENE_WIDTH;
		final scaleY = height / SCENE_HEIGHT;
		final minScale = Math.min( scaleX, scaleY );
		gameView.scene.scaleX = gameView.scene.scaleY = minScale;

		sliderContainer.y = scaleX < scaleY ? CANVAS_HEIGHT * scaleX : CANVAS_HEIGHT * scaleY - 60;
		sliderView.width = width;
	}

	public function addFrameViewData( dataset:FrameViewData ) {
		frameViewDatasets.push( dataset );
		if( frameViewDatasets.length > 1 ) {
			final currentFrame = frameViewDatasets.length - 2;
			final nextFrame = frameViewDatasets.length - 1;
			gameView.update( frameViewDatasets[currentFrame], frameViewDatasets[nextFrame], 0 );
		}
	}

	// public function select( id:Int ) {
	// 	final startFrameDataset = parseInput( testCases[id] );
	// 	initFrameDatasets( startFrameDataset );
	// 	gameView.initEntities( startFrameDataset );
	// 	changeState( Simulating );
	// }

	// public function playClick() {
	// 	final nextState = state == Playing ? PlayPaused : Playing;
	// 	changeState( nextState );
	// }

	// function changeState( nextState:TState ) {
	// 	switch nextState {
	// 		case Initial: //no-op
	// 		case Simulating:
	// 			// ai.reset();	
	// 			currentFrame = 0;
	// 		case Playing:
	// 		case PlayPaused:
	// 		case Finished:
	// 	}
	// 	state = nextState;
	// }
	
	// public function resetPlay() {
	// }

	// function initFrameDatasets( startFrameDataset:FrameDataset ) {
	// 	frameViewDatasets.splice( 0, frameViewDatasets.length );
	// 	frameViewDatasets.push( startFrameDataset );
	// }

	override function update( dt:Float ) {
		// switch state {
		// 	case Simulating:
		// 		if( simCounter == 0 ) {
		// 			simulateNextFrame();
		// 		}
		// 		simCounter = ( simCounter + 1 ) % SIM_FRAME;
		// 	case Playing:
		// 		if( playCounter == 0 ) {
		// 			goToFrame( currentFrame );
		// 			currentFrame++;
		// 			if( currentFrame >= frameViewDatasets.length ) changeState( Finished );
		// 		}
		// 		playCounter = ( playCounter + 1 ) % PLAY_FRAME;
		// 	default: // no-op
		// }
	}

	function goToFrame( f:Float ) {
		final currentFrame = Math.floor( f );
		final nextFrame = Std.int( Math.min( frameViewDatasets.length - 1, currentFrame + 1 ));
		final subFrame = f - currentFrame;
		gameView.update( frameViewDatasets[currentFrame], frameViewDatasets[nextFrame], subFrame );
	}
}
