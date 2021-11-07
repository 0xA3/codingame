package ga;

import haxe.ds.Vector;


class Chromosome {
	
	public final genes:Vector<Gene>;

	public function new( genes:Vector<Gene>) {
		this.genes = genes;
	}

	public static function createRandom( numGenes:Int ) {
		final genes = new Vector<Gene>( numGenes );
		for( i in 0...numGenes ) {
			final gene:Gene = { rotate: Gene.getRandomRotate(), power: Gene.getRandomPower() };
			genes[i] = gene;

		}
		return new Chromosome( genes );
	}
	
	public function randomize() {
		for( gene in genes ) {
			gene.rotate = Gene.getRandomRotate();
			gene.power = Gene.getRandomPower();
		}
	}

	public function crossover( partnerGenes:Vector<Gene> ) {
		final nextGenes = new Vector<Gene>( genes.length );
		for( i in 0...genes.length ) nextGenes[i] = Math.random() < 0.5 ? genes[i] : partnerGenes[i];
		return new Chromosome( nextGenes );
	}

	public function mutate( mutationRate:Float ) {
		for( i in 0...genes.length ) {
			if( Math.random() < mutationRate ) {
				genes[i].rotate = Gene.getRandomRotate();
				genes[i].power = Gene.getRandomPower();
			}
		}
	}
}