using ArrayUtils;

class Word {
	final chars:Array<Char>;
	public final word:String;

	public function new( chars:Array<Char> ) {
		this.chars = chars;
		word = chars.map( c -> c.s ).join( "" );
	}

	public function getScore( width:Int, tiles:Map<String, Int>, tileMultipliers:Array<Int>, wordMultipliers:Array<Int> ) {
		var sum = 0;
		var wordMultiplier = 1;
		for( char in chars ) {
			final index = char.y * width + char.x;
			final charScore = char.getScore( tiles ) * ( char.isJustPlayed ? tileMultipliers[index] : 1 );
			wordMultiplier *= char.isJustPlayed ? wordMultipliers[index] : 1;

			sum += charScore;
			// trace( '${char.s} index: $index, score: ${char.getScore( tiles )}, tileMultiplier ${tileMultipliers[index]}, charScore: $charScore' );
		}
		sum *= wordMultiplier;

		return sum;
	}

	public function toString() return '${chars.map( c -> c.s ).join( "" )}';
}