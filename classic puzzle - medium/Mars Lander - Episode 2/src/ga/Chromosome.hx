package ga;

import Math.round;

class Chromosome {
	
	public final genes:Array<Gene>;
	public var fitness = 0.0;
	
	public final startRotate:Int;
	public final startPower:Int;

	public function new( genes:Array<Gene>, startRotate:Int, startPower:Int ) {
		this.genes = genes;
		this.startRotate = startRotate;
		this.startPower = startPower;
	}

	public static function createRandom( numGenes:Int, startRotate:Int, startPower:Int ) {
		final genes = [];
		for( i in 0...numGenes ) {
			final gene:Gene = { rotate: Gene.getRandomRotate(), power: Gene.getRandomPower() };
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
		// trace( genes.map( gene -> '${gene.power}' ).join( "," ));
		return new Chromosome( genes, startRotate, startPower );
	}
	
	public function copy() {
		final genesCopy = [];
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
		for( i in 0...genes.length ) {
			final gene = genes[i];
			gene.rotate = Gene.getRandomRotate();
			gene.power = Gene.getRandomPower();
		}
	}

	public function crossover( partnerGenes:Array<Gene>, nextChromosome:Chromosome ) {
		for( i in 0...genes.length ) {
			final r1 = Math.random();
			final r2 = Math.random();
			
			final gene = nextChromosome.genes[i];
			 gene.rotate = round( genes[i].rotate * r1 + partnerGenes[i].rotate * ( 1 - r1 ));
			 gene.power = round( genes[i].power * r2 + partnerGenes[i].power * ( 1 - r2 ));
		}
	}

	public function mutate( mutationRate:Float ) {
		for( gene in genes ) {
			if( Math.random() < mutationRate ) {
				gene.rotate = Gene.getRandomRotate();
				gene.power = Gene.getRandomPower();
			}
		}
	}

}