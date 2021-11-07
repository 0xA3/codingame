package ga;

import haxe.ds.Vector;
import sim.data.Agent;
import sim.data.SurfaceCoords;

class Population {

	final chromosomes:Vector<Chromosome>;
	public final agents:Vector<Agent>;

	public function new( chromosomes:Vector<Chromosome>, agents:Vector<Agent> ) {
		if( chromosomes.length != agents.length ) throw 'Error: cromosomes length must match agents length';
		this.chromosomes = chromosomes;
		this.agents = agents;
	}

	public static function createRandom( numChromosomes:Int, numGenes:Int, surfaceCoords:SurfaceCoords ) {
		final chromosomes = new Vector<Chromosome>( numChromosomes );
		for( i in 0...numChromosomes ) chromosomes[i] = Chromosome.createRandom( numGenes );
		
		final agents = new Vector<Agent>( numChromosomes );
		for( i in 0...agents.length ) agents[i] = new Agent( surfaceCoords );
		
		return new Population( chromosomes, agents );
	}

	public function initAgents( startX:Int, startY:Int, startFuel:Int ) {
		for( agent in agents ) agent.init( startX, startY, startFuel );
	}

	public function run( currentGene:Int ) {
		for( i in 0...agents.length ) {
			final chromosome = chromosomes[i];
			final gene = chromosome.genes[currentGene];
			agents[i].update( gene.rotate, gene.power );
		}
	}
}