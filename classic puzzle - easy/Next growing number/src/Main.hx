import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static var char:Int;

	static function main() {
		
		final n = readline();
		final result = process( n );

		print( result );
	}

	static function process( n:String ) {
		
		final inputArray = n.split( "" ).map( char -> parseInt( char ));
		final outputArray = [0].concat( inputArray );
		outputArray[outputArray.length - 1] += 1;
		// trace( outputArray );
		for( i in -outputArray.length + 1...0 ) {
			if( outputArray[-i] == 10 ) {
				outputArray[-i] = 0;
				outputArray[-i - 1] += 1;
			}
		}
		
		for( i in 1...outputArray.length ) {
			if( outputArray[i] < outputArray[i - 1] ) {
				outputArray[i] = outputArray[i - 1];
				for( o in i + 1...outputArray.length ) {
					outputArray[o] = 0;
				}
			}
		}
		
		if( outputArray[0] == 0 ) outputArray.shift();
		final result = outputArray.join( "" );
		// printErr( result );
		return result;
	}

}
/*

11123159995399999
11123159995400000 + 1
11123359999999999 - my result
11123333333333333 - real result
*/