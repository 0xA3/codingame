package ai.contexts;

import Std.int;
import xa3.MTRandom;

class WarCry {
	
	static final warcries = CompileTime.readFile( "warcries.txt" ).split( "\r\n" );

	final mtRandom:MTRandom;

	var warcryCounter = 2;
	var warcry = "";

	public function new( mtRandom:MTRandom ) {
		this.mtRandom = mtRandom;
	}

	public function get() {
		warcryCounter--;
		
		if( warcryCounter == 0 ) {
			if( warcry == "" ) {
				warcryCounter = int( 10 + mtRandom.nextFloat() * 20 );
				warcry = warcries[mtRandom.nextInt( warcries.length )];
			} else {
				warcryCounter = int( 2 + mtRandom.nextFloat() * 5 );
				warcry = "";
			}
		}

		return warcry;
	}
}