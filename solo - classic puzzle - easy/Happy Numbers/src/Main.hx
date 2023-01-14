import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final lines = [for( i in 0...n ) readline()];

		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<String> ) {
		
		final checked = lines.map( number -> number + ( checkHappy( number ) ? " :)" : " :(" ));
		return checked.join( "\n" );
	}

	static function checkHappy( number:String ) {
		
		var sSquare = number;
		while( true ) {
			final intSum = sSquare.split("").fold(( digit, sum ) -> sum + Math.pow( parseInt( digit ), 2 ), 0 );
			sSquare = Std.string( intSum );
			if( intSum == 1 || intSum == 4 ) break;
		}
		
		return sSquare == "1";
	}

}

