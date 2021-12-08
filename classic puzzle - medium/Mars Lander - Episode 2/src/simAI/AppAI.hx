package simAI;

import Math.round;
import TestCases;
import ga.Gene;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import haxe.Json;
import hxd.res.DefaultFont;
import simAI.AICollection;
import simGA.State;
import simGA.data.Agent;
import simGA.data.AgentPath;
import simGA.data.Position;
import simGA.data.SurfaceCoords;
import simGA.factory.AgentsPathFactory;
import simGA.factory.RocketFactory;
import simGA.view.PathView;
import simGA.view.Rocket;
import simGA.view.Surface;

using Lambda;

class AppAI extends hxd.App {

	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	static inline var SIM_FRAME = 1;
	static inline var PLAY_FRAME = 3;
	
	final numAlgorithms = 1;
	final numFrames = 1000;
	
	var currentFrame = 0;
	var surface:Surface;
	var surfaceCoords:SurfaceCoords;
	var surfaceGraphics:Graphics;
	var pathGraphics:Graphics;
	var rocket:Rocket;
	var marsLander:MarsLanderGA;
	var agentsPaths:Array<AgentPath>;
	var pathView:PathView;
	var tSim:Text;
	var tRocket:Text;

	var intersectObject:Object;
	var tIntersect:Text;
	
	var aiCollection:AICollection;

	var zero:Int;
	var scaleFactor:Float;

	var frame = 0;
	var playCounter = 0;

	var state = Initial;
	var testCaseId = 0;
	var winnerGenes:Array<Gene> = [];

	var agent:Agent;
	var testCases:Array<TestCase>;

	override function init() {
		surfaceGraphics = new Graphics( s2d );
		pathGraphics = new Graphics( s2d );
		pathView = new PathView( pathGraphics );
		rocket = RocketFactory.createRocket( s2d );

		tRocket = new Text( DefaultFont.get(), s2d );
		tRocket.x = 600;
		tRocket.y = 20;

		scaleFactor = 0.3;
		zero = MAX_Y;
		
		testCases = [
			TestCases.easyOnTheRight,
			TestCases.initialSpeedCorrectSide,
			TestCases.initialSpeedWrongSide,
			TestCases.deepCanyon,
			TestCases.highGround,
			TestCases.caveCorrectSide,
			TestCases.caveWrongSide,
			TestCases.stalagtiteUpwardStart
		];
		changeState( Simulating );
	}

	public function select( id:Int ) {
		if( testCaseId == id ) {
			changeState( Simulating );
		} else {
			testCaseId = id;
			state = Initial;
			changeState( Simulating );
		}
	}

	public function simClick() {
		final nextState = state == Simulating ? SimulationPaused : Simulating;
		changeState( nextState );
	}

	public function playClick() {
		final nextState = state == Playing ? PlayPaused : Playing;
		changeState( nextState );
	}
	
	public function resize() {
		pathView.draw( zero, scaleFactor );
		surface.draw( zero, scaleFactor );
	}

	function changeState( nextState:State ) {
		// trace( 'changeState $state to $nextState' );
		switch [state, nextState] {
			case [Initial, Simulating]:
				MainSimAI.simulationStarted();
				state = nextState;
				initSimulation();
			
			case [Simulating, SimulationPaused]:
				MainSimAI.simulationPaused();
				state = nextState;
			
			case [SimulationPaused, Simulating]:
				MainSimAI.simulationStarted();
				state = nextState;
			
			case [_, Simulating]:
				initSimulation();
				MainSimAI.simulationStarted();
				state = nextState;
			
			case [Simulating, Playing]:
				MainSimAI.simulationFinished();
				MainSimAI.playStarted();
				resetPlay();
				state = nextState;
			
			case [Playing, PlayPaused]:
				MainSimAI.playPaused();
				state = nextState;
			
			case [PlayPaused, Playing]:
				MainSimAI.playStarted();
				state = nextState;
			
			case [Playing, Finished]:
				MainSimAI.playFinished();
				state = nextState;
			
			case [Finished, Playing]:
				MainSimAI.playStarted();
				resetPlay();
				state = nextState;
			
			default: throw 'Error: no conditions for change from $state to $nextState';
		}
	}

	function initSimulation() {
		final testCase = testCases[testCaseId];
		final positions = testCase.coords.map( c -> new Position( c[0], c[1] ));
		surfaceCoords = new SurfaceCoords( positions );
		
		agent = new Agent( testCase, surfaceCoords, numFrames );
		aiCollection = AICollection.create( testCase, surfaceCoords, numFrames );
		surface = new Surface( surfaceGraphics, surfaceCoords );
		outputAgent();
		
		agentsPaths = AgentsPathFactory.create( aiCollection.simAgents.length, numFrames, 0x666666 );

		pathView.reset( testCase.x, testCase.y, agentsPaths );
		rocket.reset();
		rocket.update( agent, zero, scaleFactor );
		surface.draw( zero, scaleFactor );
		
		// marsLander = new MarsLander( surfaceCoords, agent, population, numGenes, mutationRate );
		// marsLander.startSimulation();
		// changeState( Playing );
	}

	public function resetPlay() {
		agent.reset();
		rocket.reset();
		frame = 0;
		playCounter = 0;
	}

	override function update( dt:Float ) {
		switch state {
			case Simulating: simulate();
			case Playing:
				if( playCounter % PLAY_FRAME == 0 ) playNextFrame();
				playCounter++;
			default: // no-op
		}
	}

	function simulate() {
		aiCollection.resetAgents();
		for( i in 0...numFrames ) {
			aiCollection.run( i );
			for( c in 0...aiCollection.simAgents.length ) {
				final agent = aiCollection.simAgents[c];
				final path = agentsPaths[c];
				final point = path.positions[i];
				if( agent.isLanded ) path.color = 0x00ff00;
				point.x = Math.round( agent.x );
				point.y = Math.round( agent.y );
			}
		}

		pathView.draw( zero, scaleFactor );
		winnerGenes = aiCollection.genePool[0];
		changeState( Playing );
	}

	function playNextFrame() {
		if( agent.isFinished || frame > numFrames - 1 ) {
			var commands = [for( c in 0...frame ) { c: c, rotate: agent.rotates[c], power: agent.powers[c] }];
			// trace( Json.stringify( commands ));
			changeState( Finished );
			return;
		}

		final gene = winnerGenes[frame];
		final rotate = gene.rotate;
		final power = gene.power;
		
		agent.update( rotate, power );
		agent.checkFinishedPlay();
		outputAgent();
		// trace( 'Standard Output Stream:\n> $rotate $power\nGame information                                   $frame\nX=${sRound( agent.x )}m, Y=${sRound( agent.y )}m, HSpeed=${sRound( agent.hSpeed )}m/s, VSpeed=${sRound( agent.vSpeed )}m/s\nFuel=${agent.fuel}l, Angle=${agent.rotate}°, Power=${agent.power} (${agent.power}.0m/s2)' );
		rocket.update( agent, zero, scaleFactor );
		frame++;
	}

	function sRound( v:Float ) {
		final rounded = round( Math.abs( v ));
		return v < 0 ? -rounded : rounded;
	}

	inline function outputAgent() {
		tRocket.text = 'frame $frame\nhSpeed: ${agent.hSpeed}\nvSpeed: ${agent.vSpeed}\nrotate: ${agent.rotate}\npower: ${agent.power}\nfuel: ${agent.fuel}';
	}

	public function onMouseMove( windowX:Int ) {
		final x = round( windowX / scaleFactor );
		final hitFitness = surfaceCoords.getHitFitness( x, MAX_Y, x, 0 );

		final vIntersect:simGA.data.Vec2 = { x: 0, y: 0 };
		final coords = surfaceCoords.coords;
		for( i in 1...coords.length ) {
			final x0 = coords[i - 1].x;
			final y0 = coords[i - 1].y;
			final x1 = coords[i].x;
			final y1 = coords[i].y;
			final isIntersection = xa3.MathUtils.segmentIntersect( x0, y0, x1, y1, x, 0, x, MAX_Y, vIntersect );
			if( isIntersection ) {
				intersectObject.x = windowX;
				intersectObject.y = ( zero - vIntersect.y ) * scaleFactor;
				tIntersect.text = 'x: $x\ny: ${vIntersect.y}\nhitFitness: $hitFitness';
			}
		}
	}
}




