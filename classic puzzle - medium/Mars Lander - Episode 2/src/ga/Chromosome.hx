package ga;

import Math.round;
import haxe.ds.Vector;
import sim.data.Agent.MAX_POWER;
import sim.data.Agent.MAX_ROTATION_ANGLE;
import sim.data.Agent.MIN_POWER;
import sim.data.Agent.MIN_ROTATION_ANGLE;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

class Chromosome {
	

	public final genes:Vector<Gene>;
	public var fitness = 0.0;
	
	final startRotate:Int;
	final startPower:Int;

	public function new( genes:Vector<Gene>, startRotate:Int, startPower:Int ) {
		this.genes = genes;
		this.startRotate = startRotate;
		this.startPower = startPower;
	}

	public static function createRandom( numGenes:Int, startRotate:Int, startPower:Int ) {
		final genes = new Vector<Gene>( numGenes );
		final gene:Gene = { rotate: startRotate, power: startPower };
		genes[0] = gene;
		for( i in 1...numGenes ) {
			final gene:Gene = { rotate: genes[i - 1].rotate + Gene.getRandomRotate(), power: genes[i - 1].power + Gene.getRandomPower() };
			genes[i] = gene;
		}
		
		// physics test
		// final start = 20;
		// for( i in 1...start ) {
		// 	final gene:Gene = { rotate: -45, power: 4 };
		// 	genes[i] = gene;

		// }
		// for( i in start...numGenes ) {
		// 	final gene:Gene = { rotate: -90, power: 0 };
		// 	genes[i] = gene;

		// }
		return new Chromosome( genes, startRotate, startPower );
	}
	
	public function copy() {
		final genesCopy = new Vector<Gene>( genes.length );
		for( i in 0...genes.length ) genesCopy[i] = genes[i].copy();
		return new Chromosome( genesCopy, startRotate, startPower );
	}
	
	public function setTo( chromosome:Chromosome ) {
		for( i in 0...genes.length ) {
			genes[i].rotate = chromosome.genes[i].rotate;
			genes[i].power = chromosome.genes[i].power;
		}
	}

	public function randomize() {
		genes[0].rotate = startRotate + Gene.getRandomRotate();
		genes[0].power = Gene.getRandomPower();
		for( i in 1...genes.length ) {
			final gene = genes[i];
			gene.rotate = max( MIN_ROTATION_ANGLE, min( MAX_ROTATION_ANGLE, genes[i - 1].rotate + Gene.getRandomRotate() ));
			gene.power = max( MIN_POWER, min( MAX_POWER, genes[i - 1].power + Gene.getRandomPower() ));
			// gene.rotate = genes[i - 1].rotate + Gene.getRandomRotate();
			// gene.power = genes[i - 1].power + Gene.getRandomPower();
		}
	}

	public function crossover( partnerGenes:Vector<Gene>, nextChromosome:Chromosome ) {
		for( i in 0...genes.length ) {
			final r1 = Math.random();
			final r2 = Math.random();
			final ur1 = 1 - r1;
			final ur2 = 1 - r2;
			final rotate = genes[i].rotate * r1 + partnerGenes[i].rotate * ur1;
			final power = genes[i].power * r2 + partnerGenes[i].power * ur2;
			
			final gene = nextChromosome.genes[i];
			 gene.rotate = max( MIN_ROTATION_ANGLE, min( MAX_ROTATION_ANGLE, round( rotate )));
			 gene.power = max( MIN_POWER, min( MAX_POWER, round( power )));
			// final gene:Gene = r < 0.5 ? { rotate: genes[i].rotate, power: genes[i].power } : { rotate: partnerGenes[i].rotate, power: partnerGenes[i].power }
		}
	}

	public function mutate( mutationRate:Float ) {
		for( i in 1...genes.length ) {
			if( Math.random() < mutationRate ) {
				final rotate = genes[i - 1].rotate + Gene.getRandomRotate();
				final power = genes[i - 1].power + Gene.getRandomPower();
				genes[i].rotate = max( MIN_ROTATION_ANGLE, min( MAX_ROTATION_ANGLE, rotate ));
				genes[i].power = max( MIN_POWER, min( MAX_POWER, power ));
			}
		}
	}
}