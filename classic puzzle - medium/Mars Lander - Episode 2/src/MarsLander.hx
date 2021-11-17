#if !sim
import CodinGame.printErr;
#end
import TestCases.TestCase;
import ga.Gene;
import ga.Population;
import sim.data.Agent;
import sim.data.Position;
import sim.data.SurfaceCoords;

class MarsLander {
	
	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;

	final surfaceCoords:SurfaceCoords;
	final agent:Agent;
	final population:Population;
	final numGenes:Int;
	final mutationRate:Float;

	var isSimComplete = false;
	var winnerGenes:Array<Gene> = [];

	var generation = 0;

	public function new( surfaceCoords:SurfaceCoords, agent:Agent, population:Population, numGenes:Int, mutationRate:Float ) {
		this.surfaceCoords = surfaceCoords;
		this.agent = agent;
		this.population = population;
		this.numGenes = numGenes;
		this.mutationRate = mutationRate;
	}

	public function startSimulation() {
		while( !isSimComplete ) {
			simNextGeneration();
		}
	}

	public inline function simNextGeneration() {
		population.resetAgents();
		for( i in 0...numGenes ) population.run( i );
		population.calcFitness();
	
		var maxFitness = 0.0;
		for( i in 0...population.chromosomes.length ) {
			final c = population.chromosomes[i];
			if( c.fitness > maxFitness ) maxFitness = c.fitness;
			if( c.fitness == 1 ) {
				winnerGenes = population.chromosomes[i].genes;
				isSimComplete = true;
				break;
			}
		}

		if( maxFitness < 1 ) population.evolve( mutationRate );

		#if sim	trace( #else printErr( #end
		'Generation: $generation, maxFitness: $maxFitness' );
		
		generation++;
		
		if( generation > 150 ) isSimComplete = true;
	}

	public function update( frame:Int ) {
		final currentGene = winnerGenes[frame];
		agent.update( currentGene.rotate, currentGene.power );
		return '${agent.rotate} ${agent.power}';
	}
}