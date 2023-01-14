import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var FIZZ = "Fizz";
	static inline var BUZZ = "Buzz";
	static inline var FIZZBUZZ = "FizzBuzz";

	static function main() {
		
		final n = parseInt( readline() );
		final lines = [for( i in 0...n ) readline()];
				
		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<String> ) {
		
		final numbers = lines.map( n -> parseInt( n ));
		
		var start = 1;
		for( i in 0...numbers.length ) {
			// trace( '$i number ${numbers[i]}' );
			if( numbers[i] != null ) {
				start = numbers[i] - i;
				break;
			}
		}
		
		final fizzes = [for( i in 0...lines.length ) if( lines[i] == FIZZ || lines[i] == FIZZBUZZ ) i + start];
		final buzzes = [for( i in 0...lines.length ) if( lines[i] == BUZZ || lines[i] == FIZZBUZZ ) i + start];
		
		final fizz = fizzes.length > 1 ? fizzes[1] - fizzes[0] : fizzes[0];
		final buzz = buzzes.length > 1 ? buzzes[1] - buzzes[0] : buzzes[0];
		
		return '$fizz $buzz';
	}

}
