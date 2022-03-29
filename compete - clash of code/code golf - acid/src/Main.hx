import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.round;

class Main {
	
	static final validAcidNames = ["Hydrochloric", "Sulfuric", "Nitric", "Citric"];

	static function main() {
		
		final acidName = readline().split(" ")[0];
		final acidCount = parseInt( readline() );
		final waterCount = parseInt( readline() );
		
		final percentage = Std.string( round( acidCount / ( acidCount + waterCount ) * 1000 ));
		final percentageString = percentage.substr( 0, percentage.length - 1 ) + "." + percentage.substr( percentage.length - 1 ) + "%";
		final acidName = ( validAcidNames.contains( acidName ) ? acidName : "Unknown" ) + " Acid";
		print( '$percentageString $acidName' );
	}
}

