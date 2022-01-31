class Interpreter {
	
	static final POINTER_OUT_OF_BOUNDS = "POINTER OUT OF BOUNDS";
	static final INCORRECT_VALUE = "INCORRECT VALUE";
	static final SYNTAX_ERROR = "SYNTAX ERROR";

	final cells:Array<Int>;
	final alphabetLength:Int;
	var pointer = 0;
	
	public function new( cellsNum:Int, alphabetLength:Int ) {
		this.cells = [for( _ in 0...cellsNum ) 0];
		this.alphabetLength = alphabetLength;
	}

	public function init() {
		for( cell in cells ) cell = 0;
		pointer = 0;
	}

	public function execute( commands:Array<Int> ) {
		init();
		
		// remove later to optimize for speed
		final noOpen = commands.filter( c -> c == "[".code ).length;
		final noClose = commands.filter( c -> c == "]".code ).length;
		if( noOpen != noClose ) throw SYNTAX_ERROR;
		//

		var outputCharCodes = [];
		var c = 0;
		while( c < commands.length ) {
			switch commands[c] {
			case ">".code:
				pointer++;
				if( pointer >= cells.length ) pointer = 0;
			case "<".code:
				pointer--;
				if( pointer < 0 ) pointer = cells.length - 1;
			case "+".code:
				cells[pointer]++;
				if( cells[pointer] > alphabetLength ) cells[pointer] = 0;
			case "-".code:
				cells[pointer]--;
				if( cells[pointer] < 0 ) cells[pointer] = alphabetLength - 1;
			case ".".code: outputCharCodes.push( cells[pointer] );
			case "[".code:
				if( cells[pointer] == 0 ) {	
					var bracketLevel = 1;
					while( true ) {
						c++;
						if( c >= commands.length ) throw SYNTAX_ERROR;
						switch commands[c] {
						case "[".code: bracketLevel++;
						case "]".code:
							bracketLevel--;
							if( bracketLevel == 0 ) break;
						default: // no-op
						}
						outputState( c, commands[c], outputCharCodes );
					}
				}
			case "]".code:
				if( cells[pointer] != 0 ) {
					var bracketLevel = 1;
					while( true ) {
						c--;
						if( c < 0 ) throw SYNTAX_ERROR;
						switch commands[c] {
						case "[".code:
							bracketLevel--;
							if( bracketLevel == 0 ) break;
						case "]".code: bracketLevel++;
						default: // no-op
						}
						outputState( c, commands[c], outputCharCodes );
					}
				}
			}
			// trace( outputState( c, commands[c], output ));
			c++;
		}
		
		return outputCharCodes;
	}

	function outputState( position:Int, command:Int, outputCharCodes:Array<Int> ) {
		return '$position   ${String.fromCharCode( command )}   pointer: $pointer, cell[$pointer]: ${cells[pointer]}    cells $cells  output: ${outputCharCodes.map( v -> String.fromCharCode( v )).join( "" )}';
	}
}