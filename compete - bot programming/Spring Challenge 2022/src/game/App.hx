package game;

import Std.parseInt;
import game.data.FrameDataset;
import h2d.Object;

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
	
	final frameDatasets:Array<FrameDataset>;

	var gameView:view.GameView;
	var sliderContainer:Object;
	var sliderView:view.SliderView;
	
	public function new( referee:Referee ) {
		super();
		frameDatasets = [];
	}

	override function init() {
		final scene = new Object( s2d );
		final entityCreator = new EntityCreator();
		entityCreator.createBackground( scene );
		gameView = new view.GameView( scene, entityCreator );
		gameView.initEntities( frameDatasets[0] );
		
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
	// 	frameDatasets.splice( 0, frameDatasets.length );
	// 	frameDatasets.push( startFrameDataset );
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
		// 			if( currentFrame >= frameDatasets.length ) changeState( Finished );
		// 		}
		// 		playCounter = ( playCounter + 1 ) % PLAY_FRAME;
		// 	default: // no-op
		// }
	}

	function goToFrame( f:Float ) {
		final currentFrame = Math.floor( f );
		final nextFrame = Std.int( Math.min( frameDatasets.length - 1, currentFrame + 1 ));
		final subFrame = f - currentFrame;
		gameView.update( frameDatasets[currentFrame], frameDatasets[nextFrame], subFrame );
	}
}
