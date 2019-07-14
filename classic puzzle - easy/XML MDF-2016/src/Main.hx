import haxe.ds.GenericStack;

using Lambda;

class Main {
	
	static function main() {
		
		final sequence = CodinGame.readline();
		// CodinGame.printErr( sequence );
		final letterWeights = getLetterWeights( sequence );
		// CodinGame.printErr( letterWeights );
		final averageWeights = getAverageWeights( letterWeights );
		averageWeights.sort(( a, b ) -> {
			if( a.weight < b.weight ) return 1;
  			else if( a.weight > b.weight ) return -1;
  			return 0;
		});
		// CodinGame.printErr( averageWeights );
		final smallestWeights = averageWeights.filter( averageWeight -> averageWeight.weight == averageWeights[0].weight );
		smallestWeights.sort(( a, b ) -> {
			if( a.letter < b.letter ) return -1;
  			else if( a.letter > b.letter ) return 1;
  			return 0;
		});
		// CodinGame.printErr( averageWeights );
		CodinGame.print( smallestWeights[0].letter );

	}


	static function getLetterWeights( sequence:String ):Map<String, Array<Int>> {

		final letterWeights:Map<String, Array<Int>> = [];
		var depth = 1;
		var i = 0;
		while( i < sequence.length ) {
			
			final char = sequence.charAt( i++ );
			if( char == "-" ) {
				depth--;
				i++;
			} else {
				letterWeights.exists( char ) ? letterWeights.get( char ).push( depth ) : letterWeights.set( char, [ depth ]);
				depth++;
			}
		}

		return letterWeights;
	}

	static function getAverageWeights( letterWeights:Map<String, Array<Int>> ):Array<AverageWeight> {

		final averageWeights:Array<AverageWeight> = [];
		for( letter => weights in letterWeights ) {
			final weight = weights.fold(( weight, sum ) -> sum + 1 / weight, 0 );
			averageWeights.push({ letter: letter, weight: weight });
		}
		return averageWeights;
	}

}

typedef AverageWeight = {
	final letter:String;
	final weight:Float;
}