package sim;

import Math.round;
import TestCases;
import ga.Population;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import hxd.res.DefaultFont;
import sim.State;
import sim.data.Agent;
import sim.data.Position;
import sim.data.SurfaceCoords;
import sim.factory.AgentsPathFactory;
import sim.factory.RocketFactory;
import sim.view.PathView;
import sim.view.Rocket;
import sim.view.Surface;

class App extends hxd.App {

	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	static inline var SIM_FRAME = 1;
	static inline var PLAY_FRAME = 5;
	static final mutationRate = 0.1;
	
	final numChromosomes = 100;
	final numGenes = 150;
	
	var currentFrame = 0;
	var surface:Surface;
	var surfaceCoords:SurfaceCoords;
	var surfaceGraphics:Graphics;
	var pathGraphics:Graphics;
	var rocket:Rocket;
	var marsLander:MarsLander;
	var agentsPaths:Array<Array<Position>>;
	var pathView:PathView;
	var tSim:Text;
	var tRocket:Text;

	var intersectObject:Object;
	var tIntersect:Text;
	
	var zero:Int;
	var scaleFactor:Float;

	var generation = 0;
	var frame = 0;
	var simCounter = 0;
	var playCounter = 0;

	var state = Initial;
	var testCaseId = 0;
	var winnerChromosomId = 0;

	var population:Population;
	var agent:Agent;
	var testCases:Array<TestCase>;

	override function init() {
		surfaceGraphics = new Graphics( s2d );
		pathGraphics = new Graphics( s2d );
		pathView = new PathView( pathGraphics );
		rocket = RocketFactory.createRocket( s2d );

		tSim = new Text( DefaultFont.get(), s2d );
		tSim.x = 20;
		tSim.y = 20;
		
		tRocket = new Text( DefaultFont.get(), s2d );
		tRocket.x = 600;
		tRocket.y = 20;

		intersectObject = new Object( s2d );
		final intersectCircle = new Graphics( intersectObject );
		intersectCircle.clear();
		intersectCircle.lineStyle( 1, 0xcccccc );
		intersectCircle.drawCircle( 0, 0, 4 );

		tIntersect = new Text( DefaultFont.get(), intersectObject );
		tIntersect.y = 10;

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
		switch [state, nextState] {
			case [Initial, Simulating]:
				Main.simulationStarted();
				initSimulation();
			
			case [Simulating, SimulationPaused]:
				Main.simulationPaused();
			
			case [SimulationPaused, Simulating]:
				Main.simulationStarted();
			
			case [_, Simulating]:
				initSimulation();
				Main.simulationStarted();
			
			case [Simulating, Playing]:
				Main.simulationFinished();
				Main.playStarted();
				resetPlay();
			
			case [Playing, PlayPaused]:
				Main.playPaused();
			
			case [PlayPaused, Playing]:
				Main.playStarted();
			
			case [Playing, Finished]:
				Main.playFinished();
			
			case [Finished, Playing]:
				Main.playStarted();
				resetPlay();
			
			default: throw 'Error: no conditions for change from $state to $nextState';
		}
		state = nextState;
	}

	function initSimulation() {
		generation = 0;
		
		final testCase = testCases[testCaseId];
		final positions = testCase.coords.map( c -> new Position( c[0], c[1] ));
		surfaceCoords = new SurfaceCoords( positions );
		
		agent = new Agent( testCase, surfaceCoords );
		population = Population.createRandom( numChromosomes, numGenes, testCase, surfaceCoords );
		surface = new Surface( surfaceGraphics, surfaceCoords );
		outputAgent();
		
		agentsPaths = AgentsPathFactory.create( numChromosomes, numGenes );

		pathView.reset( testCase.x, testCase.y, agentsPaths );
		rocket.reset();
		rocket.update( agent, zero, scaleFactor );
		surface.draw( zero, scaleFactor );
	}

	public function resetPlay() {
		agent.reset();
		rocket.reset();
		frame = 0;
		playCounter = 0;
	}

	override function update( dt:Float ) {
		switch state {
			case Simulating:
				if( simCounter % SIM_FRAME == 0 ) simNextGeneration();
				simCounter++;
			case Playing:
				if( playCounter % PLAY_FRAME == 0 ) playNextFrame();
				playCounter++;
			default: // no-op
		}
	}

	function simNextGeneration() {
		population.resetAgents();
		for( i in 0...numGenes ) {
			population.run( i );
			for( c in 0...population.simAgents.length ) {
				final agent = population.simAgents[c];
				final path = agentsPaths[c];
				final point = path[i];
				point.x = Math.round( agent.x );
				point.y = Math.round( agent.y );
			}
		}

		pathView.draw( zero, scaleFactor );
		population.calcFitness();
		// for( i in 0...population.agents.length ) {
		// 	final agent = population.agents[i];
		// 	final distance = surfaceCoords.getDistance( agent.x, agent.y, surfaceCoords.landX, surfaceCoords.landY );
			// trace( agent.x, agent.y, distance, population.chromosomes[i].fitness );
		// }
		
		var maxFitness = 0.0;
		var minFitness = 1.0;
		var sum = 0.0;
		for( i in 0...population.chromosomes.length ) {
			final c = population.chromosomes[i];
			if( c.fitness > maxFitness ) maxFitness = c.fitness;
			if( c.fitness < minFitness ) minFitness = c.fitness;
			if( c.fitness == 1 ) {
				winnerChromosomId = i;
				var rotate = c.startRotate;
				var output = [];
				for( i in 0...c.genes.length ) {
					rotate = xa3.MathUtils.max( Agent.MIN_ROTATION_ANGLE, xa3.MathUtils.min( Agent.MAX_ROTATION_ANGLE, rotate + c.genes[i].rotate ));
					output.push( rotate );
				}
				// trace( [for( i in 0...output.length ) '$i:${output[i]}'].join( "," ));
			}
			sum += c.fitness;
		}
		final averageFitness = sum / population.chromosomes.length;
		outputSim( maxFitness, minFitness, averageFitness );
		if( maxFitness == 1 ) {
			changeState( Playing );
			return;
		}
		population.evolve( mutationRate );
		generation++;
		// changeState( SimulationPaused );
	}

	function playNextFrame() {
		if( agent.isFinished || frame > population.chromosomes[winnerChromosomId].genes.length - 1 ) {
			changeState( Finished );
			return;
		}

		final gene = population.chromosomes[winnerChromosomId].genes[frame];
		final rotate = gene.rotate;
		final power = gene.power;
		// trace( 'X=${rocket.x}m, Y=${rocket.y}m, HSpeed=${rocket.hSpeed}m/s VSpeed=${rocket.vSpeed}m/s\nFuel=${rocket.fuel}l, Angle=${rocket.rotate}°, Power=${rocket.power}m/s2' );
		
		// final response = marsLander.update( rocket.x, rocket.y, rocket.hSpeed, rocket.vSpeed, rocket.fuel, rocket.rotate, rocket.power );
		// final parts = response.split(' ');
		// final rotate = parseInt( parts[0] );
		// final power = parseInt( parts[1] );
		// trace( response );
		
		agent.update( rotate, power );
		agent.checkFinishedPlay();
		outputAgent();
		rocket.update( agent, zero, scaleFactor );
		frame++;
	}

	inline function outputSim( maxFitness:Float, minFitness:Float, averageFitness:Float ) {
		tSim.text = 'generation: $generation\nmaxFitness: $maxFitness\nminFitness: $minFitness\naverageFitness: $averageFitness';
	}

	inline function outputAgent() {
		tRocket.text = 'frame $frame\nhSpeed: ${agent.hSpeed}\nvSpeed: ${agent.vSpeed}\nrotate: ${agent.rotate}\npower: ${agent.power}\nfuel: ${agent.fuel}';
	}

	public function onMouseMove( windowX:Int ) {
		final x = round( windowX / scaleFactor );
		final hitFitness = surfaceCoords.getHitFitness( x, MAX_Y, x, 0 );

		final vIntersect:sim.data.Vec2 = { x: 0, y: 0 };
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




