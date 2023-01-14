import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var FIFTY = 50;
	

	static function main() {
		
		final initialScore = parseInt( readline() );
		
		final result = process( initialScore );
		print( result );
	}

	static function process( initialScore:Int ) {
		
		var possibleThrows = 0;
		final pinGroup = new PinGroup( initialScore );

		var validThrows = [pinGroup];
		for( i in 0...4 ) {
			final throws = validThrows.flatMap( pinGroup -> pinGroup.getChildPinGroups());
			final winThrows = throws.filter( pinGroup -> pinGroup.score == 50 ).length;
			possibleThrows += winThrows;
			validThrows = throws.filter( pinGroup -> pinGroup.score < 50 );
		}

		return possibleThrows;
	}

}
