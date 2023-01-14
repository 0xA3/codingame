/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Lambda;

class Main {
	
	static function main() {

		var r1 = Std.parseInt( CodinGame.readline());
		CodinGame.printErr( r1 );

		var result = checkRiversBelow( r1 );
		
		CodinGame.print( result ? "YES" : "NO" );
	}

	static function checkRiversBelow( r:Int ):Bool {
		for( i in 1...r ) {
			if( next( r - i ) == r ) return true;
		}
		return false;
	}

	static function next( v:Int ):Int {
		return v + followValue( v );
	}

	static function followValue( v:Int ):Int {
		return Std.string( v ).split( "" ).map( s -> Std.parseInt( s )).fold(( sum, value ) -> sum + value, 0 );
	}
}
