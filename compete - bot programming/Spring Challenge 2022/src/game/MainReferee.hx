package game;

import Std.parseInt;

class MainReferee {
	
	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		
		final referee = new Referee();

		for( i in 0...repeats ) {
			referee.init( i );
			referee.run();
		}
	
	}
}