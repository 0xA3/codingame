class State {
	
	public final id:String;
	final transitions:Map<String, State> = [];

	public static final nullState = new State( "null" );

	public function new( id:String ) {
		this.id = id;
	}

	public function setTransition( transition:String, state:State ) {
		transitions.set( transition, state );
	}

	public function transform( s:String ) {
		if( transitions.exists( s )) {
			// trace( '$id -> $s -> ${transitions[s].id}' );
			return transitions[s];
		} else {
			// trace( 'Error no transform for $id -> $s' );
			return nullState;
		}
	}

	public function toString() {
		return 'id: $id, transitions: ' + [for( transition => state in transitions ) '$transition -> ${state.id}'].join( ", " );
	}

}