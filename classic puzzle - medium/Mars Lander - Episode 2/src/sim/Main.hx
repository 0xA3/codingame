package sim;

import TestCases;
import ga.Population;
import h2d.Graphics;
import h2d.Text;
import haxe.ds.Vector;
import hxd.res.DefaultFont;
import sim.data.Agent;
import sim.data.Position;
import sim.data.SurfaceCoords;
import sim.factory.AgentsPathFactory;
import sim.factory.RocketFactory;
import sim.view.PathView;
import sim.view.Rocket;
import sim.view.Surface;

class Main extends hxd.App {

	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	static final mutationRate = 0.01;
	
	final numChromosomes = 100;
	final numGenes = 150;
	
	var currentFrame = 0;
	var surface:Surface;
	var surfaceCoords:SurfaceCoords;
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
	var simCounter = 0;
	var playCounter = 0;

	var frame = 0;

	var isPlaying = true;
	var isSuccess = false;

	var population:Population;
	var agent:Agent;

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
	
	override function init() {

		final testCase = TestCases.highGround;
		
		final positions = testCase.coords.map( c -> new Position ( c[0], c[1] ));
		surfaceCoords = new SurfaceCoords( positions );
		population = Population.createRandom( numChromosomes, numGenes, testCase, surfaceCoords );
		agent = new Agent( testCase, surfaceCoords );

		scaleFactor = 0.3;
		zero = MAX_Y;

		final g = new Graphics( s2d );
		surface = new Surface( g, surfaceCoords );
		surface.draw( zero, scaleFactor );
		
		final g2 = new Graphics( s2d );

		agentsPaths = AgentsPathFactory.create( numChromosomes, numGenes );
		pathView = new PathView( g2, agentsPaths, testCase.x, testCase.y );

		rocket = RocketFactory.createRocket( s2d );
		rocket.update( agent, zero, scaleFactor );
		
		tSim = new Text( DefaultFont.get(), s2d );
		tSim.x = 20;
		tSim.y = 20;
		s2d.addChild( tSim );
		
		tRocket = new Text( DefaultFont.get(), s2d );
		tRocket.x = 600;
		tRocket.y = 20;
		s2d.addChild( tSim );
	}

	override function update( dt:Float ) {
		if( !isSuccess ) {
			if( simCounter % SIM_FRAME == 0 ) sim();
			simCounter++;
		} else {
			if( playCounter % PLAY_FRAME == 0 ) play();
			playCounter++;
		}
	}

	function sim() {
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
		for( i in 0...population.agents.length ) {
			final agent = population.agents[i];
			final distance = surfaceCoords.getDistance( agent.x, agent.y, surfaceCoords.landX, surfaceCoords.landY );
			// trace( agent.x, agent.y, distance, population.chromosomes[i].fitness );
		}
		
		var maxFitness = 0.0;
		var minFitness = 1.0;
		var sum = 0.0;
		for( c in population.chromosomes ) {
			if( c.fitness > maxFitness ) maxFitness = c.fitness;
			if( c.fitness < minFitness ) minFitness = c.fitness;
			sum += c.fitness;
		}
		final averageFitness = sum / population.chromosomes.length;
		if( maxFitness == 1 ) isSuccess = true;
		tSim.text = '$simCounter\nmaxFitness: $maxFitness\nminFitness: $minFitness\naverageFitness: $averageFitness';
		population.evolve( mutationRate );
	}

	function play() {
		if( frame >= population.chromosomes[0].genes.length || agent.isLanded ) return;

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
		tRocket.text = '$frame\nhSpeed: ${agent.hSpeed}\nvSpeed: ${agent.vSpeed}\nrotate: ${agent.rotate}';
		rocket.update( agent, zero, scaleFactor );
		frame++;
		
	}
}




