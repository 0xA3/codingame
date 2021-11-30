package ga;

import TestCases;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;

using Lambda;

class Population {

	public var chromosomes:Array<Chromosome>;
	public var nextChromosomes:Array<Chromosome>;
	public final simAgents:Array<Agent>;

	public var usedGenesNo = 0;

	public function new( chromosomes:Array<Chromosome>, simAgents:Array<Agent> ) {
		if( chromosomes.length != simAgents.length ) throw 'Error: cromosomes length ${chromosomes.length} must match simAgents length ${simAgents.length}';
		this.chromosomes = chromosomes;
		this.simAgents = simAgents;
		
		nextChromosomes = [];
		for( i in 0...chromosomes.length ) nextChromosomes[i] = chromosomes[i].copy();
	}

	public static function createRandom( numChromosomes:Int, numGenes:Int, testCase:TestCase, surfaceCoords:SurfaceCoords ) {
		final chromosomes = [];
		for( i in 0...numChromosomes ) chromosomes[i] = Chromosome.createRandom( numGenes, testCase.angle, testCase.power );
		
		final simAgents = [];
		for( i in 0...numChromosomes ) simAgents[i] = new Agent( testCase, surfaceCoords, numGenes );
		return new Population( chromosomes, simAgents );
	}

	public function resetAgents() for( agent in simAgents ) agent.reset();

	public function run( currentGene:Int ) {
		for( i in 0...chromosomes.length ) {
			final chromosome = chromosomes[i];
			final gene = chromosome.genes[currentGene];
			final agent = simAgents[i];
			if( agent.isFinished ) {
				gene.rotate = 0;
				gene.power = 0;
			} else {
				agent.update( gene.rotate, gene.power );
				agent.checkFinishedSim();
				if( agent.isInLandingParameters ) {
					// trace( 'agent $i is in landing parameters at gene $currentGene. geneRotate: ${chromosome.genes[currentGene].rotate} agentRotate ${agent.rotate}' );
					// trace( agent.rotates.mapi((i, r ) -> '$i:$r' ).join( ", " ));
					chromosome.genes[currentGene].rotate = -agent.rotates[currentGene - 1];
					agent.rotates[currentGene] = 0;
					// trace( 'geneRotate: ${chromosome.genes[currentGene].rotate} agentRotate ${agent.rotates[currentGene]}' );
				}
				usedGenesNo = currentGene;
			}
		}
	}

	public function calcFitness() {
		for( i in 0...simAgents.length ) chromosomes[i].fitness = simAgents[i].calcFitness();
	}

	public function evolve( mutationRate:Float ) {
		var total = 0.0;
		for( c in chromosomes ) total += c.fitness;
		sortChromosomes();
	
		final eliteNum = Std.int( chromosomes.length * 0.2 );
		for( i in 0...eliteNum ) nextChromosomes[i].setTo( chromosomes[i] );
		for( i in eliteNum...chromosomes.length ) {
			final a = probabilitySelect( chromosomes, total );
			final b = probabilitySelect( chromosomes, total );
			a.crossover( b.genes, nextChromosomes[i] );
			nextChromosomes[i].mutate( mutationRate );
		}

		for( i in 0...simAgents.length ) simAgents[i].reset();
		
		final temp = chromosomes;
		chromosomes = nextChromosomes;
		nextChromosomes = temp;
	}

	public inline function sortChromosomes() {
		chromosomes.sort(( a, b ) -> {
			if( a.fitness < b.fitness ) return 1;
			if( a.fitness > b.fitness ) return -1;
			return 0;
		});
	}
	
	static function probabilitySelect( a:Array<Chromosome>, total:Float ) {
		var index = 0;
		var r = Math.random() * total;
		if( r == 0 ) return a[0];
		
		while( r > 0 ) {
			r = r - a[index].fitness;
			index++;
		}
		return a[index - 1];
	}
}