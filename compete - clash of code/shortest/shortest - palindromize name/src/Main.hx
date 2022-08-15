import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

class Main {
	
	static function main() {
		
		final name = readline();
	
		var output = "";
		for( i in 0...name.length ) {
			output += name.charAt( i ) + name.charAt( name.length - i - 1 );
		}
		print( output );
	}
}

