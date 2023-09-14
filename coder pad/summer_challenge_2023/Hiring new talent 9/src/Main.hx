import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
@:keep function process() {

	while( true ) {
		final s = readline();
		final numbers = s.split(" ").map( s -> parseInt( s ));

		var char = 0;
		var output = [];
		for( number in numbers ) {
			char += number;
			output.push( char );
		}

		print( output.join( "" ));
	}
}
