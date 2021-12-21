package sim;

import Math.floor;
import Std.parseInt;
import ai.Ai;
import ai.Simple;
import data.FrameDataset;
import data.HumanDataset;
import data.Position;
import data.ZombieDataset;
import h2d.Object;
import sim.State;
import sim.contexts.ParseInput.parseInput;
import sim.view.AshView;
import sim.view.HumanView;
import sim.view.ZombieView;
import xa3.MathUtils.distance;
import xa3.MathUtils.distanceSq;
import xa3.MathUtils.length;

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

	static inline var ASH_RANGE = 2000;
	static inline var ASH_STEP = 1000;
	static inline var ZOMBIE_RANGE = 400;
	static inline var ZOMBIE_STEP = 400;
	
	var width = SCENE_WIDTH;
	var height = SCENE_HEIGHT;
	
	var currentFrame = 0;

	var scaleFactor = 1.0;

	var state = Initial;
	var simCounter = 0;
	var playCounter = 0;

	var testCaseId = 0;
	final frameDatasets:Array<FrameDataset> = [];

	var entityCreator:EntityCreator;
	var scene:Object;
	var ash:AshView;
	var humans:Array<HumanView> = [];
	var zombies:Array<ZombieView> = [];

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
		
		scene = new Object( s2d );
		entityCreator = new EntityCreator();
		entityCreator.createBackground( scene );
		initEntities( testCaseDataset );
		ash = entityCreator.createAsh( scene, testCaseDataset.ash );
		resize();

		changeState( Simulating );
	}

	function initEntities( testCaseDataset:FrameDataset ) {
		for( humanData in testCaseDataset.humans ) {
			if( humans[humanData.id] == null ) {
				final human = entityCreator.createHuman( scene, humanData.position );
				humans[humanData.id] = human;
			} else {
				final human = humans[humanData.id];
				human.moveTo( humanData.position );
			}
		}
		for( zombieData in testCaseDataset.zombies ) {
			if( zombies[zombieData.id] == null ) {
				final zombie = entityCreator.createZombie( scene, zombieData.position );
				zombies[zombieData.id] = zombie;
			} else {
				final zombie = zombies[zombieData.id];
				zombie.moveTo( zombieData.position );
			}
		}
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
		scene.scaleX = scene.scaleY = minScale;
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
				if( simCounter % SIM_FRAME == 0 ) {
					simulateNextFrame();
				}
				simCounter++;
			case Playing:
				if( playCounter % PLAY_FRAME == 0 ) {
					playNextFrame( frameDatasets[currentFrame] );
					currentFrame++;
					if( currentFrame >= frameDatasets.length ) changeState( Finished );
				}
				playCounter++;
			default: // no-op
		}
	}

	public function simulateNextFrame() {
		final frame = frameDatasets[frameDatasets.length - 1];
		final input:FrameDataset = {
			ash: frame.ash,
			humans: frame.humans.filter( h -> h.isAlive ),
			zombies: frame.zombies.filter( z -> z.isExisting )
		}
		final ashMovement = ai.process( input ).split(" ");
		final ashTargetX = parseInt( ashMovement[0] );
		final ashTargetY = parseInt( ashMovement[1] );
		
		final movedZombies = [];
		for( zombie in frame.zombies ) movedZombies[zombie.id] = moveZombie( zombie, frame.ash.x, frame.ash.y, frame.humans );
		
		final nextAsh = moveAsh( frame.ash, ashTargetX, ashTargetY );
		
		final deadAliveZombies = [];
		for( zombie in movedZombies ) deadAliveZombies[zombie.id] = killZombieIfInRange( nextAsh, zombie );
		
		final humanDatasets = [];
		for( human in frame.humans ) humanDatasets[human.id] = killHumanIfInRange( human, deadAliveZombies );

		final nextFrame:FrameDataset = {
			ash: nextAsh,
			humans: humanDatasets,
			zombies: deadAliveZombies
		}

		frameDatasets.push( nextFrame );

		final aliveHumans = nextFrame.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
		final existingZombies = nextFrame.zombies.fold(( z, sum ) -> z.isExisting ? sum + 1 : sum, 0 );
		playNextFrame( nextFrame );
		
		if( aliveHumans == 0 || existingZombies == 0 ) changeState( Playing );
	}

	function moveZombie( zombieDataset:ZombieDataset, ashX:Int, ashY:Int, humanDatasets:Array<HumanDataset> ) {
		final zombieX = zombieDataset.positionNext.x;
		final zombieY = zombieDataset.positionNext.y;
		
		var minDistanceSq = distanceSq( zombieX, zombieY, ashX, ashY );
		var xClosestHuman = ashX;
		var yClosestHuman = ashY;
		for( humanData in humanDatasets ) {
			if( humanData.isAlive )	{
				final humanDistanceSq = distanceSq( zombieX, zombieY, humanData.position.x, humanData.position.y );
				if( humanDistanceSq < minDistanceSq ) {
					minDistanceSq = humanDistanceSq;
					xClosestHuman = humanData.position.x;
					yClosestHuman = humanData.position.y;
				}
			}
		}
		final dx = xClosestHuman - zombieX;
		final dy = yClosestHuman - zombieY;

		final dLength = length( dx, dy );
		final scaleFactor = dLength > ZOMBIE_STEP ? ZOMBIE_STEP / dLength : 1;
		
		final xNext = floor( zombieX + dx * scaleFactor );
		final yNext = floor( zombieY + dy * scaleFactor );

		final dataset:ZombieDataset = {
			id: zombieDataset.id,
			isExisting: zombieDataset.isExisting,
			position: { x: zombieX, y: zombieY },
			positionNext: { x: xNext, y: yNext }
		}
	
		return dataset;
	}

	function moveAsh( ashPosition:Position, targetX:Int, targetY:Int ) {
		final dx = targetX - ashPosition.x;
		final dy = targetY - ashPosition.y;

		final dLength = length( dx, dy );
		final scaleFactor = dLength > ASH_STEP ? ASH_STEP / dLength : 1;
		
		final xNext = floor( ashPosition.x + dx * scaleFactor );
		final yNext = floor( ashPosition.y + dy * scaleFactor );

		final ashNextPosition:Position = { x: xNext, y: yNext };

		return ashNextPosition;
	}

	function killZombieIfInRange( ashPosition:Position, zombieDataset:ZombieDataset ) {
		if( !zombieDataset.isExisting ) return zombieDataset;
		
		final distanceZombie = distance( ashPosition.x, ashPosition.y, zombieDataset.position.x, zombieDataset.position.y );
		
		final zombieIsExisting = distanceZombie > ASH_RANGE;
		if( !zombieIsExisting ) trace( 'ash kills zombie ${zombieDataset.id}' );
		final zombie:ZombieDataset = {
			id: zombieDataset.id,
			isExisting: zombieIsExisting,
			position: zombieDataset.position,
			positionNext: zombieDataset.positionNext
		}

		return zombie;
	}

	function killHumanIfInRange( humanDataset:HumanDataset, zombieDatasets:Array<ZombieDataset> ) {
		if( !humanDataset.isAlive ) return humanDataset;
		
		var isAlive = true;
		for( zombie in zombieDatasets ) {
			if( zombie.isExisting ) {
				final zombieKills = humanDataset.position.x == zombie.positionNext.x && humanDataset.position.y == zombie.positionNext.y;
				if( zombieKills ) {
					trace( 'zombie ${zombie.id} kills human ${humanDataset.id}' );
					isAlive = false;
					break;
				}
			}
		}
		final human:HumanDataset = {
			id: humanDataset.id,
			isAlive: isAlive,
			position: humanDataset.position
		}

		return human;
	}

	function playNextFrame( frame:FrameDataset ) {
		// trace( currentFrame );
		ash.moveTo( frame.ash );
		for( human in frame.humans ) {
			humans[human.id].moveTo( human.position, human.isAlive );
		}
		for( zombie in frame.zombies ) {
			zombies[zombie.id].moveTo( zombie.position, zombie.isExisting );
		}

	}
}
