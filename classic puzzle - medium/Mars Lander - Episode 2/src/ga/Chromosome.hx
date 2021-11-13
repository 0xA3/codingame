package ga;

import haxe.ds.Vector;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

class Chromosome {
	
	public var genes:Vector<Gene>;
	public var fitness = 0.0;

	public function new( genes:Vector<Gene> ) {
		this.genes = genes;
	}

	public static function createRandom( numGenes:Int, startRotate:Int, startPower:Int ) {
		final genes = new Vector<Gene>( numGenes );
		final gene:Gene = { rotate: startRotate, power: startPower };
		genes[0] = gene;
		for( i in 1...numGenes ) {
			final gene:Gene = { rotate: genes[i - 1].rotate + Gene.getRandomRotate(), power: Gene.getRandomPower() };
			genes[i] = gene;

		}
		return new Chromosome( genes );
	}
	
	public function randomize() {
		genes[0].rotate = Gene.getRandomRotate();
		genes[0].power = Gene.getRandomPower();
		for( i in 1...genes.length ) {
			final gene = genes[i];
			// gene.rotate = max( -90, min( 90, genes[i - 1].rotate + Gene.getRandomRotate() ));
			// gene.power = max( 0, min( 4, genes[i - 1].power + Gene.getRandomPower() ));
			gene.rotate = genes[i - 1].rotate + Gene.getRandomRotate();
			gene.power = Gene.getRandomPower();
		}
	}

	public function crossover( partnerGenes:Vector<Gene> ) {
		final nextGenes = new Vector<Gene>( genes.length );
		for( i in 0...genes.length ) {
			final r = Math.random();
			final ur = 1 - r;
			final rotate = genes[i].rotate * r + partnerGenes[i].rotate * ur;
			final power = genes[i].power * r + partnerGenes[i].power * ur;
			final gene:Gene = { rotate: Math.round( rotate ), power: Math.round( power )};
			// final gene:Gene = r < 0.5 ? { rotate: genes[i].rotate, power: genes[i].power } : { rotate: partnerGenes[i].rotate, power: partnerGenes[i].power }
			nextGenes[i] = gene;
		}
		return new Chromosome( nextGenes );
	}

	public function mutate( mutationRate:Float ) {
		for( i in 0...genes.length ) {
			if( Math.random() < mutationRate ) {
				genes[i].rotate = Std.random( 181 ) - 90;
				genes[i].power = Gene.getRandomPower();
			}
		}
	}
}