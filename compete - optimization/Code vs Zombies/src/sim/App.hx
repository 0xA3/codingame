package sim;

import ParseInput.parseInput;
import Std.parseInt;
import ai.Ai;
import ai.Simple;
import data.FrameDataset;
import h2d.Flow;
import h2d.Object;
import h2d.Slider;
import sim.State;
import sim.view.SimView;
import sim.view.SliderView;

using Lambda;

class App extends hxd.App {

	public static inline var WIDTH = 16000;
	public static inline var HEIGHT = 9000;
	public static inline var X0 = 354;
	public static inline var Y0 = 200;
	public static inline var SCENE_WIDTH = 2560;
	public static inline var SCENE_HEIGHT = 1440;
	static inline var SIM_FRAME = 5;
	static inline var PLAY_FRAME = 15;
	
	var width = SCENE_WIDTH;
	var height = SCENE_HEIGHT;
	
	var currentFrame = 0;

	var scaleFactor = 1.0;

	var state = Initial;
	var simCounter = 0;
	var playCounter = 0;

	var testCases:Array<String> = [];
	var testCaseId = 0;
	final frameDatasets:Array<FrameDataset> = [];

	var simView:SimView;
	var sliderContainer:Object;
	var sliderView:SliderView;
	var ai:Ai;

	override function init() {
		trace( "init" );
		
		ai = new Simple();
		
		testCases = [
			TestCases.simple,
			TestCases.twoZombies,
			TestCases.twoZombiesRedux,
			TestCases.scaredHuman,
			TestCases.threeVsThree,
			TestCases.comboOpportunity,
			TestCases.rowsToDefend,
			TestCases.rowsToDefendRedux,
			TestCases.rectangle,
			TestCases.cross,
			TestCases.unavoidableDeaths,
			TestCases.columnsOfDeath,
			TestCases.rescueMission,
			TestCases.triangle,
			TestCases.graveDanger,
			TestCases.grid,
			TestCases.horde,
			TestCases.flanked,
			TestCases.splitSecondReflex,
			TestCases.swervyPattern,
			TestCases.devastation
		];
		
		final testCaseDataset = parseInput( testCases[0] );
		initFrameDatasets( testCaseDataset );

		final scene = new Object( s2d );
		final entityCreator = new EntityCreator();
		entityCreator.createBackground( scene );
		final ash = entityCreator.createAsh( testCaseDataset.ashX, testCaseDataset.ashY );
		simView = new SimView( scene, ash, entityCreator );
		simView.initEntities( testCaseDataset );
		
		sliderContainer = new Object( s2d );
		sliderView = entityCreator.createSlider( sliderContainer, "Frame", () -> 0, goToFrame );

		resize();

		changeState( Simulating );
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
		simView.scene.scaleX = simView.scene.scaleY = minScale;

		sliderContainer.y = scaleX < scaleY ? SCENE_HEIGHT * scaleX : SCENE_HEIGHT * scaleY - 60;
		sliderView.width = width;
	}

	public function select( id:Int ) {
		final startFrameDataset = parseInput( testCases[id] );
		initFrameDatasets( startFrameDataset );
		simView.initEntities( startFrameDataset );
		changeState( Simulating );
	}

	public function playClick() {
		final nextState = state == Playing ? PlayPaused : Playing;
		changeState( nextState );
	}

	function changeState( nextState:State ) {
		switch nextState {
			case Initial: //no-op
			case Simulating: currentFrame = 0;
			case Playing:
			case PlayPaused:
			case Finished:
		}
		state = nextState;
	}
	
	public function resetPlay() {
	}

	function initFrameDatasets( startFrameDataset:FrameDataset ) {
		frameDatasets.splice( 0, frameDatasets.length );
		frameDatasets.push( startFrameDataset );
	}

	override function update( dt:Float ) {
		switch state {
			case Simulating:
				if( simCounter == 0 ) {
					simulateNextFrame();
				}
				simCounter = ( simCounter + 1 ) % SIM_FRAME;
			case Playing:
				if( playCounter == 0 ) {
					goToFrame( currentFrame );
					currentFrame++;
					if( currentFrame >= frameDatasets.length ) changeState( Finished );
				}
				playCounter = ( playCounter + 1 ) % PLAY_FRAME;
			default: // no-op
		}
	}

	public function simulateNextFrame() {
		final currentFrameDataset = frameDatasets[frameDatasets.length - 1];
		
		final aiInput:FrameDataset = {
			ashX: currentFrameDataset.ashX,
			ashY: currentFrameDataset.ashY,
			humans: currentFrameDataset.humans.filter( h -> h.isAlive ),
			zombies: currentFrameDataset.zombies.filter( z -> z.isExisting )
		}
		final ashMovement = ai.process( aiInput ).split(" ").map( s -> parseInt( s ));
		final ashTargetX = ashMovement[0];
		final ashTargetY = ashMovement[1];
		
		final nextFrameDataset = Game.executeRound( ashTargetX, ashTargetY, currentFrameDataset );
		frameDatasets.push( nextFrameDataset );

		final aliveHumans = nextFrameDataset.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
		final existingZombies = nextFrameDataset.zombies.fold(( z, sum ) -> z.isExisting ? sum + 1 : sum, 0 );
		currentFrame = frameDatasets.length - 1;
		sliderView.maxValue = currentFrame;
		sliderView.setFrame( currentFrame );
		goToFrame( currentFrame );
		
		if( aliveHumans == 0 || existingZombies == 0 ) {
			goToFrame( currentFrame );
			changeState( PlayPaused );
		}
	}

	function goToFrame( f:Float ) {
		final currentFrame = Math.floor( f );
		final previousFrame = Std.int( Math.max( 0, currentFrame - 1 ));
		final nextFrame = Std.int( Math.min( frameDatasets.length - 1, currentFrame + 1 ));
		final subFrame = f - currentFrame;
		simView.update( frameDatasets[previousFrame].ashX, frameDatasets[previousFrame].ashY, frameDatasets[currentFrame], frameDatasets[nextFrame], subFrame );
		
	}
}
