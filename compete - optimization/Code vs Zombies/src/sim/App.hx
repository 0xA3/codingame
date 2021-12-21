package sim;

import Math.floor;
import Std.parseInt;
import ai.Ai;
import ai.Simple;
import data.FrameDataset;
import data.Vec2;
import h2d.Object;
import sim.State;
import sim.contexts.ParseInput.parseInput;
import sim.view.AshView;
import sim.view.HumanView;
import sim.view.SimView;
import sim.view.ZombieView;

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

	var testCaseId = 0;
	final frameDatasets:Array<FrameDataset> = [];

	var simView:SimView;
	var ai:Ai;

	override function init() {
		ai = new Simple();
		
		final testCases = [
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
		frameDatasets.push( testCaseDataset );
		

		final scene = new Object( s2d );
		final entityCreator = new EntityCreator();
		entityCreator.createBackground( scene );
		final ashView = entityCreator.createAsh( scene, testCaseDataset.ash );
		simView = new SimView( scene, ashView, entityCreator );
		simView.initEntities( testCaseDataset );
		
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
	}

	public function select( id:Int ) {

	}

	public function playClick() {
		final nextState = state == Playing ? PlayPaused : Playing;
		changeState( nextState );
	}

	function changeState( nextState:State ) {
		switch nextState {
			case Initial: //no-op
			case Simulating: currentFrame = 0;
			case Playing: currentFrame = 0;
			case PlayPaused:
			case Finished:
		}
		state = nextState;
	}
	
	public function resetPlay() {
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
					final previousPosition = currentFrame == 0 ? frameDatasets[0].ash : frameDatasets[currentFrame - 1].ash;
					playNextFrame( previousPosition, frameDatasets[currentFrame] );
					currentFrame++;
					if( currentFrame >= frameDatasets.length ) changeState( Finished );
				}
				playCounter = ( playCounter + 1 ) % PLAY_FRAME;
			default: // no-op
		}
	}

	public function simulateNextFrame() {
		final frame = frameDatasets[frameDatasets.length - 1];
		
		final aiInput:FrameDataset = {
			ash: frame.ash,
			humans: frame.humans.filter( h -> h.isAlive ),
			zombies: frame.zombies.filter( z -> z.isExisting )
		}
		final ashMovement = ai.process( aiInput ).split(" ").map( s -> parseInt( s ));
		final ashTarget:Vec2 = { x: ashMovement[0], y: ashMovement[1] };
		
		final nextFrame = Game.executeRound( ashTarget, frame );
		frameDatasets.push( nextFrame );

		final aliveHumans = nextFrame.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
		final existingZombies = nextFrame.zombies.fold(( z, sum ) -> z.isExisting ? sum + 1 : sum, 0 );
		playNextFrame( frame.ash, nextFrame );
		
		if( aliveHumans == 0 || existingZombies == 0 ) changeState( Playing );
	}


	function playNextFrame( previousPosition:Vec2, frame:FrameDataset ) {
		simView.update( previousPosition, frame );
	}
}
