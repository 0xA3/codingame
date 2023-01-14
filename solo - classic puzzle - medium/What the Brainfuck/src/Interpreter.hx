class Interpreter {
	
	static final POINTER_OUT_OF_BOUNDS = "POINTER OUT OF BOUNDS";
	static final INCORRECT_VALUE = "INCORRECT VALUE";
	static final SYNTAX_ERROR = "SYNTAX ERROR";

	final cells:Array<Int>;
	var pointer = 0;
	
	public function new( cellsNum:Int ) {
		this.cells = [for( _ in 0...cellsNum ) 0];
	}

	public function init() {
		for( cell in cells ) cell = 0;
		pointer = 0;
	}

	public function execute( program:String, ?inputs:Array<Int> ) {
		if( inputs == null ) inputs = [];
		init();
		
		final commands = program.split( "" );
		
		final noOpen = commands.filter( c -> c == "[" ).length;
		final noClose = commands.filter( c -> c == "]" ).length;
		if( noOpen != noClose ) return SYNTAX_ERROR;

		var outputCharCodes = [];
		var c = 0;
		while( c < commands.length ) {
			switch commands[c] {
			case ">":
				pointer++;
				if( pointer >= cells.length ) return POINTER_OUT_OF_BOUNDS;
			case "<":
				pointer--;
				if( pointer < 0 ) return POINTER_OUT_OF_BOUNDS;
			case "+":
				cells[pointer]++;
				if( cells[pointer] > 255 ) return INCORRECT_VALUE;
			case "-":
				cells[pointer]--;
				if( cells[pointer] < 0 ) return INCORRECT_VALUE;
			case ".": outputCharCodes.push( cells[pointer] );
			case ",":
				if( inputs.length == 0 ) throw "Error: no input";
				cells[pointer] = inputs.shift();
			case "[":
				if( cells[pointer] == 0 ) {	
					var bracketLevel = 1;
					while( true ) {
						c++;
						if( c >= program.length ) return SYNTAX_ERROR;
						switch commands[c] {
						case "[": bracketLevel++;
						case "]":
							bracketLevel--;
							if( bracketLevel == 0 ) break;
						default: // no-op
						}
						outputState( c, commands[c], outputCharCodes );
					}
				}
			case "]":
				if( cells[pointer] != 0 ) {
					var bracketLevel = 1;
					while( true ) {
						c--;
						if( c < 0 ) return SYNTAX_ERROR;
						switch commands[c] {
						case "[":
							bracketLevel--;
							if( bracketLevel == 0 ) break;
						case "]": bracketLevel++;
						default: // no-op
						}
						outputState( c, commands[c], outputCharCodes );
					}
				}
			}
			// trace( outputState( c, commands[c], output ));
			c++;
		}
		
		return outputCharCodes.map( v -> String.fromCharCode( v )).join( "" );
	}

	function outputState( position:Int, command:String, outputCharCodes:Array<Int> ) {
		return '$position   $command   pointer: $pointer, cell[$pointer]: ${cells[pointer]}    cells $cells  output: ${outputCharCodes.map( v -> String.fromCharCode( v )).join( "" )}';
	}
}