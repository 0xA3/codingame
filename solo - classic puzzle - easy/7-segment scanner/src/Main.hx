import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;

using StringTools;

class Main {
	
	static function main() {
		
		final lines = [for( i in 0...3 ) readline()];

		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<String> ) {
		final count = int( lines[0].length / 3 );
		final digits:Array<Int> = [];
		for( i in 0...count ) {
			final digitGrid = [for( y in 0...3 ) for( x in 0...3 ) lines[y].charAt( i * 3 + x )].join("");
			final digit = digitDefinitions.indexOf( digitGrid );
			digits.push( digit );
		}
		return digits.join("");
	}

	static final digitDefinitions = [
" _ 
| |
|_|",
"   
  |
  |",
" _ 
 _|
|_ ",
" _ 
 _|
 _|",
"   
|_|
  |",
" _ 
|_ 
 _|",
" _ 
|_ 
|_|",
" _ 
  |
  |",
" _ 
|_|
|_|",
" _ 
|_|
 _|"].map( line -> line.replace( "\n", "" ))
 .map( line -> line.replace( "\r", "" ));
}

