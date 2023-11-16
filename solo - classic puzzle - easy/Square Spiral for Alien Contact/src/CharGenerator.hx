class CharGenerator {
	
	static final SPACE = " ";

	final char:String;
	final amount:Int;
	final charDelta:Int;
	final amountDelta:Int;

	var currentChar:String;
	var currentCharCode:Int;
	var currentAmount:Int;
	var counter = 0;

	public function new( char:String, charDelta:Int, amount:Int, amountDelta:Int ) {
		this.char = char;
		this.charDelta = charDelta;
		this.amount = amount;
		this.amountDelta = amountDelta;

		currentChar = char;
		currentCharCode = char.charCodeAt( 0 );
		currentAmount = amount;
	}

	public function next() {
		if( currentChar == SPACE ) return SPACE;
		
		if( counter == currentAmount ) {
			currentCharCode += charDelta;
			currentChar = String.fromCharCode( currentCharCode );
			currentAmount += amountDelta;
			counter = 0;

			if( currentCharCode > "Z".code || currentCharCode < "A".code ) currentChar = SPACE;
		}
		
		counter++;

		return currentChar;
	}
}