import haxe.io.StringInput;

class StateMachine {
	
	final startState:State;
	final endStates:Array<State>;

	var input:StringInput;

	public function new( startState:State, endStates:Array<State> ) {
		this.startState = startState;
		this.endStates = endStates;
	}

	public function run( word:String ) {
		
		var state = startState;
		// trace( 'start: ${state.id}, word: $word' );

		input = new haxe.io.StringInput( word );
		while( true ) {
			final char = readChar();
			if( state == State.nullState || char == 0 ) break;
			final transition = String.fromCharCode( char );
			state = state.transform( transition );
		}
		// trace( 'end: ${state.id}' );
		return state;
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}

}