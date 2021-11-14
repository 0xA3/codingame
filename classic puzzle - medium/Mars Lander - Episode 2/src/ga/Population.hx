package ga;

import TestCases;
import haxe.ds.Vector;
import sim.data.Agent;
import sim.data.SurfaceCoords;

using Lambda;

class Population {

	public var chromosomes:Vector<Chromosome>;
	// public var nextChromosomes:Vector<Chromosome>;
	public final agents:Vector<Agent>;

	public function new( chromosomes:Vector<Chromosome>, agents:Vector<Agent> ) {
		if( chromosomes.length != agents.length ) throw 'Error: cromosomes length must match agents length';
		this.chromosomes = chromosomes;
		this.agents = agents;
	}

	public static function createRandom( numChromosomes:Int, numGenes:Int, testCase:TestCase, surfaceCoords:SurfaceCoords ) {
		final chromosomes = new Vector<Chromosome>( numChromosomes );
		for( i in 0...numChromosomes ) chromosomes[i] = Chromosome.createRandom( numGenes, testCase.angle, testCase.power );
		
		final agents = new Vector<Agent>( numChromosomes );
		for( i in 0...agents.length ) agents[i] = new Agent( testCase, surfaceCoords );
		
		return new Population( chromosomes, agents );
	}

	public function resetAgents() {
		for( agent in agents ) agent.reset();
	}

	public function run( currentGene:Int ) {
		for( i in 0...agents.length ) {
			final agent = agents[i];
			if( !agent.isLost && !agent.isLandedSim && !agent.isExploded ) {
				final chromosome = chromosomes[i];
				final gene = chromosome.genes[currentGene];
				agent.update( gene.rotate, gene.power );
				if( agent.isLandedSim ) {
					trace( 'agent $i landed at frame $currentGene' );
					chromosome.genes[currentGene - 1].rotate = 0;
					chromosome.genes[currentGene].rotate = 0;
				}
			}
		}
	}

	public function calcFitness() {
		for( i in 0...agents.length ) chromosomes[i].fitness = agents[i].calcFitness();
	}

	public function evolve( mutationRate:Float ) {
		// final selected:Array<Float> = [];
		var total = 0.0;
		for( c in chromosomes ) total += c.fitness;
		sortChromosomes();
	
		final childChromosomes = new Vector<Chromosome>( chromosomes.length );
		final eliteNum = Std.int( chromosomes.length * 0.2 );
		for( i in 0...eliteNum ) childChromosomes[i] = chromosomes[i];
		for( i in eliteNum...chromosomes.length ) {
			final a = probabilitySelect( chromosomes, total );
			final b = probabilitySelect( chromosomes, total );
			final child = a.crossover( b.genes );
			child.mutate( mutationRate );
			childChromosomes[i] = child;
			
			// selected.push( a.fitness );
			// selected.push( b.fitness );
		}

		for( i in 0...chromosomes.length ) {
			chromosomes[i] = childChromosomes[i];
			agents[i].reset();
		}
		// selected.sort(( a, b ) -> {
		// 	if( a < b ) return -1;
		// 	if( a > b ) return 1;
		// 	return 0;
		// });
		// trace( selected );
	}

	public inline function sortChromosomes() {
		chromosomes.sort(( a, b ) -> {
			if( a.fitness < b.fitness ) return 1;
			if( a.fitness > b.fitness ) return -1;
			return 0;
		});
	}
	static function probabilitySelect( a:Vector<Chromosome>, total:Float ) {
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