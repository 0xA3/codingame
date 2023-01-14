
/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using StringTools;
using Lambda;

class Main {
	
	static function main() {
		
		var inputs = CodinGame.readline().split(' ');
		final w = Std.parseInt(inputs[0]);
		final h = Std.parseInt(inputs[1]);
		
		// CodinGame.printErr( 'w: $w, h: $h' );
		final input = [for( i in 0...h ) CodinGame.readline()];
		if( input.length < 3 ) CodinGame.printErr( 'Error: height < 3' );
		// for( i in input ) CodinGame.printErr( i );

		final top = input[0];
		final bottom = input[ input.length - 1 ];
		final lines = input.slice( 1, input.length - 1);
		
		final topLabels = parseLabels( top );
		final bottomLabels = parseLabels( bottom );
		final directionLines = lines.map( line -> parseDirection( line ));
		
		// CodinGame.printErr( topLabels );
		// CodinGame.printErr( bottomLabels );

		// imperative solution
/*		final results:Array<String> = [];
		for( i in 0...topLabels.length ) {
			var currentIndex = i;
			// CodinGame.printErr( topLabels[currentIndex] );
			for( d in 0... directionLines.length ) {
				// switch directionLines[d][currentIndex] {
				// 	case Down: CodinGame.printErr( "Down" );
				// 	case Left: CodinGame.printErr( "Left" );
				// 	case Right: CodinGame.printErr( "Right" );
				// }
				currentIndex = currentIndex + switch directionLines[d][currentIndex] {
					case Down: 0;
					case Left: -1;
					case Right: 1;
				}
				// if( i == 0 ) CodinGame.printErr( bottomLabels[currentIndex] );
			}
			results.push( topLabels[i] + bottomLabels[currentIndex] );
		}
*/
		// declarative solution
		final results = topLabels.mapi((i, topLabel) -> {
			// CodinGame.printErr( topLabel );
			final resultColumnIndex = directionLines.fold(( directionLine, progress ) -> {
				// CodinGame.printErr( 'currentColumn ' + Std.string( progress ));
				// switch directionLine[progress] {
				// 	case Down: CodinGame.printErr( "Down" );
				// 	case Left: CodinGame.printErr( "Left" );
				// 	case Right: CodinGame.printErr( "Right" );
				// }
				return switch directionLine[progress] {
					case Down: progress + 0;
					case Left: progress - 1;
					case Right: progress + 1;
				}
			}, i );
			// CodinGame.printErr( resultColumnIndex + " " + topLabel + bottomLabels[ resultColumnIndex ] );
			return topLabel + bottomLabels[ resultColumnIndex ];
		});
		
		for( result in results ) CodinGame.print( result );
		
	}

	static function parseLabels( s:String ):Array<String> {
		return s.replace( "  ", "" ).split( "" );
	}

	static function parseDirection( s:String ):Array<Direction> {
		
		final extendedS = ' $s ';
		if( extendedS.length % 3 != 0 ) CodinGame.printErr( 'Error: invald line $s' );
		final chunksNumber = Std.int( extendedS.length / 3 );
		
		final chunks = [for(i in 0...chunksNumber) extendedS.substr( i * 3, 3 )];
		final directions = chunks.map( c -> {
			switch c {
				case " | ": Down;
				case "-| ": Left;
				case _: Right; // is " |-"
			}
		});

		return directions;
	}

	
}

enum Direction {
	Down;
	Left;
	Right;
}