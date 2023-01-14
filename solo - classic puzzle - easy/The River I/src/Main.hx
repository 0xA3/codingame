/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Lambda;

class Main {
	
	static function main() {

		var a = Std.parseInt( CodinGame.readline());
		var b = Std.parseInt( CodinGame.readline());
		
		// CodinGame.printErr( r1 );
		// CodinGame.printErr( r2 );

		while( a != b ) {
			a < b ? a = next( a ) : b = next( b );
		}
		CodinGame.print( a );
	}

	static function next( v:Int ):Int {
		return v + followValue( v );
	}

	static function followValue( v:Int ):Int {
		return Std.string( v ).split( "" ).map( s -> Std.parseInt( s )).fold(( sum, value ) -> sum + value, 0 );
	}
}
