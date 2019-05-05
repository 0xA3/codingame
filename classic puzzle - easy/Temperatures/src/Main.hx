/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Lambda;

class Main {
	
	static function main() {
		
		final n = Std.parseInt( CodinGame.readline()); // the number of temperatures to analyse
		var inputs = CodinGame.readline().split( ' ' );
		
		// imperative solution
/* 		var closestTemparature = 0;
		var closestDifference = 5526;
		for ( i in 0...n ) {
			final t = Std.parseInt( inputs[i] ); // a temperature expressed as an integer ranging from -273 to 5526
			final absDifference = Std.int( Math.abs( t ));
			
			if( absDifference == closestDifference ) {
				if( closestTemparature < 0 ) closestTemparature = t;
			} else if( absDifference < closestDifference ) {
				closestDifference = absDifference;
				closestTemparature = t;
			}
		}
		
		CodinGame.print( closestTemparature );
 */
		// declarative solution
		final temperatures = inputs.map( input -> Std.parseInt( input )).filter( input -> input != null );
		final absoluteValues = temperatures.map( temperature -> Std.int( Math.abs( temperature )));
		final smallestValue = absoluteValues.fold(( value, smallest ) -> value < smallest ? value : smallest, 5526 );
		CodinGame.print( n == 0 ? 0 : temperatures.indexOf( smallestValue ) != -1 ? smallestValue : -smallestValue );

	}
}
