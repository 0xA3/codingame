package game;

import Std.parseInt;
import game.data.FrameDataset;
import game.view.GameView;
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

	var gameView:game.view.GameView;
	var sliderContainer:Object;
	var sliderView:game.view.SliderView;
	
	public function new( initDataset:FrameDataset ) {
		super();
		frameDatasets = [initDataset];
	}

	override function init() {
		final scene = new Object( s2d );
		final entityCreator = new EntityCreator();
		entityCreator.createBackground( scene );
		gameView = new GameView( scene, entityCreator );
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

	public function simulateNextFrame() {
		// final lastFrameDataset = frameDatasets[frameDatasets.length - 1];
		// final lastFrameScore = frameScores[frameDatasets.length - 1];
		
		// final aiInput:FrameDataset = {
		// 	ashX: lastFrameDataset.ashX,
		// 	ashY: lastFrameDataset.ashY,
		// 	humans: lastFrameDataset.humans.filter( h -> h.isAlive ),
		// 	zombies: lastFrameDataset.zombies.filter( z -> z.isUndead )
		// }
		// final zombiePositions = [for( z in aiInput.zombies ) if( z.isUndead ) 'id: ${z.id} pos ${z.x}:${z.y} next ${z.xNext}:${z.yNext}' ].join( "\n" );
		// trace( 'frame $currentFrame ash ${aiInput.ashX}:${aiInput.ashY} zombies\n$zombiePositions' );
	
		// final ashMovement = ai.process( aiInput ).split(" ").map( s -> parseInt( s ));
		// final ashTargetX = ashMovement[0];
		// final ashTargetY = ashMovement[1];
		
		// final lastFrameHumans = getRemainingHumans( lastFrameDataset );
		// final lastFrameZombies = getRemainingZombies( lastFrameDataset );

		// Game.setMutFrameDataset( lastFrameDataset, mutFrameDataset );

		// Game.executeRound( ashTargetX, ashTargetY, mutFrameDataset );
		// final nextFrameDataset = getFrameDataset( mutFrameDataset );
		// frameDatasets.push( nextFrameDataset );

		// final remainingHumans = nextFrameDataset.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
		// final remainingZombies = nextFrameDataset.zombies.fold(( z, sum ) -> z.isUndead ? sum + 1 : sum, 0 );

		// final nextFrameScore = remainingHumans == 0 ? 0 : lastFrameScore + Game.calculateScore( lastFrameHumans, lastFrameZombies - remainingZombies );
		// frameScores.push( nextFrameScore );

		// currentFrame = frameDatasets.length - 1;
		// sliderView.maxValue = currentFrame;
		// sliderView.setFrame( currentFrame );
		// goToFrame( currentFrame );
		
		// if( remainingHumans == 0 || remainingZombies == 0 ) {
		// // if(( lastFrameHumans == 0 && remainingHumans == 0 ) || ( lastFrameZombies == 0 && remainingZombies == 0 )) {
		// 	goToFrame( currentFrame );
		// 	changeState( PlayPaused );
		// }
	}

	// inline function getFrameDataset( mfd:MutFrameDataset ) {
	// 	final fd:FrameDataset = {
	// 		ashX: mfd.ashX,
	// 		ashY: mfd.ashY,
	// 		humans: mfd.humans.map( h -> {
	// 			id: h.id,
	// 			isAlive: h.isAlive,
	// 			x: h.x,
	// 			y: h.y
	// 		}),
	// 		zombies: mfd.zombies.map( z -> {
	// 			id: z.id,
	// 			isUndead: z.isUndead,
	// 			x: z.x,
	// 			y: z.y,
	// 			xNext: z.xNext,
	// 			yNext: z.yNext
	// 		})
	// 	}
	// 	return fd;
	// }

	// inline function getRemainingHumans( frameDataset:FrameDataset ) return frameDataset.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
	// inline function getRemainingZombies( frameDataset:FrameDataset ) return frameDataset.zombies.fold(( h, sum ) -> h.isUndead ? sum + 1 : sum, 0 );

	function goToFrame( f:Float ) {
		final currentFrame = Math.floor( f );
		final nextFrame = Std.int( Math.min( frameDatasets.length - 1, currentFrame + 1 ));
		final subFrame = f - currentFrame;
		gameView.update( frameDatasets[currentFrame], frameDatasets[nextFrame], subFrame );
	}
}
