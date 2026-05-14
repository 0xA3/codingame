package ai.contexts;

import Std.int;

class WarCry {
	
	static final warcries = CompileTime.readFile( "warcries.txt" ).split( "\r\n" );

	var warcryCounter = 2;
	var warcry = "";

	public function new() {
		
	}

	public function get() {
		warcryCounter--;
		
		if( warcryCounter == 0 ) {
			if( warcry == "" ) {
				warcryCounter = int( 10 + MainAi.mtRandom.nextFloat() * 20 );
				warcry = warcries[MainAi.mtRandom.nextInt( warcries.length )];
			} else {
				warcryCounter = int( 2 + MainAi.mtRandom.nextFloat() * 5 );
				warcry = "";
			}
		}

		return warcry;
	}
}