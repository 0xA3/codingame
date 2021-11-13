package sim;

import TestCases;
import ga.Population;
import h2d.Graphics;
import h2d.Text;
import haxe.ds.Vector;
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
	static final mutationRate = 0.01;
	
	final numChromosomes = 100;
	final numGenes = 150;
	
	var currentFrame = 0;
	var surface:Surface;
	var surfaceCoords:SurfaceCoords;
	var surfaceGraphics:Graphics;
	var pathGraphics:Graphics;
	var rocket:Rocket;
	var marsLander:MarsLander;
	var agentsPaths:Vector<Vector<Position>>;
	var pathView:PathView;
	var tSim:Text;
	var tRocket:Text;

	var zero:Int;
	var scaleFactor:Float;

	
	static inline var SIM_FRAME = 1;
	static inline var PLAY_FRAME = 5;
	var frame = 0;
	var simCounter = 0;
	var playCounter = 0;

	var state = Initial;
	var testCaseId = 0;

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
		s2d.addChild( tSim );
		
		tRocket = new Text( DefaultFont.get(), s2d );
		tRocket.x = 600;
		tRocket.y = 20;
		s2d.addChild( tSim );
		
		scaleFactor = 0.3;
		zero = MAX_Y;
		
		testCases = [
			TestCases.easyOnTheRight,
			TestCases.initialSpeedCorrectSide,
			TestCases.initialSpeedWrongSide,
			TestCases.deepCanyon,
			TestCases.highGround,
			TestCases.caveCorrectSide,
			TestCases.caveWrongSide
		];
		
		changeState( Simulating );
	}

	public function select( id:Int ) {
		if( testCaseId == id ) {
			changeState( Simulating );
		} else {
			testCaseId = id;
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
				initPlay();
			
			case [Playing, PlayPaused]:
				Main.playPaused();
			
			case [PlayPaused, Playing]:
				Main.playStarted();
			
			case [Playing, Finished]:
				Main.playFinished();
			
			case [Finished, Playing]:
				Main.playStarted();
				initPlay();
			
			default: throw 'Error: no conditions for change from $state to $nextState';
		}
		state = nextState;
	}

	function initSimulation() {
		simCounter = 0;
		
		final testCase = testCases[testCaseId];
		final positions = testCase.coords.map( c -> new Position( c[0], c[1] ));
		surfaceCoords = new SurfaceCoords( positions );
		
		agent = new Agent( testCase, surfaceCoords );
		population = Population.createRandom( numChromosomes, numGenes, testCase, surfaceCoords );
		surface = new Surface( surfaceGraphics, surfaceCoords );
		outputAgent();
		
		agentsPaths = AgentsPathFactory.create( numChromosomes, numGenes );

		pathView.init( testCase.x, testCase.y, agentsPaths );
		rocket.init();
		rocket.update( agent, zero, scaleFactor );
		surface.draw( zero, scaleFactor );
	}

	public function initPlay() {
		agent.reset();
		frame = 0;
		playCounter = 0;
	}

	override function update( dt:Float ) {
		switch state {
			case Simulating:
				if( simCounter % SIM_FRAME == 0 ) simNextFrame();
				simCounter++;
			case Playing:
				if( playCounter % PLAY_FRAME == 0 ) playNextFrame();
				playCounter++;
			default: // no-op
		}
	}

	function simNextFrame() {
		population.resetAgents();
		for( i in 0...numGenes ) {
			population.run( i );
			for( c in 0...population.agents.length ) {
				final agent = population.agents[c];
				final path = agentsPaths[c];
				final p = path[i];
				p.x = agent.x;
				p.y = agent.y;
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
		for( c in population.chromosomes ) {
			if( c.fitness > maxFitness ) maxFitness = c.fitness;
			if( c.fitness < minFitness ) minFitness = c.fitness;
			sum += c.fitness;
		}
		final averageFitness = sum / population.chromosomes.length;
		outputSim( maxFitness, minFitness, averageFitness );
		if( maxFitness == 1 ) {
			changeState( Playing );
			return;
		}
		population.evolve( mutationRate );
	}

	function playNextFrame() {
		if( frame >= population.chromosomes[0].genes.length || agent.isLanded ) {
			changeState( Finished );
			return;
		}

		final gene = population.chromosomes[0].genes[frame];
		final rotate = gene.rotate;
		final power = gene.power;
		// trace( 'X=${rocket.x}m, Y=${rocket.y}m, HSpeed=${rocket.hSpeed}m/s VSpeed=${rocket.vSpeed}m/s\nFuel=${rocket.fuel}l, Angle=${rocket.rotate}°, Power=${rocket.power}m/s2' );
		
		// final response = marsLander.update( rocket.x, rocket.y, rocket.hSpeed, rocket.vSpeed, rocket.fuel, rocket.rotate, rocket.power );
		// final parts = response.split(' ');
		// final rotate = parseInt( parts[0] );
		// final power = parseInt( parts[1] );
		// trace( response );
		
		agent.update( rotate, power );
		outputAgent();
		rocket.update( agent, zero, scaleFactor );
		frame++;
	}

	inline function outputSim( maxFitness:Float, minFitness:Float, averageFitness:Float ) {
		tSim.text = '$simCounter\nmaxFitness: $maxFitness\nminFitness: $minFitness\naverageFitness: $averageFitness';
	}

	inline function outputAgent() {
		tRocket.text = '$frame\nhSpeed: ${agent.hSpeed}\nvSpeed: ${agent.vSpeed}\nrotate: ${agent.rotate}\npower: ${agent.power}';
	}



}




