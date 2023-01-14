import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.int;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final cards = readline().split(" ");
		var sum = 0;
		for( card in cards ) {
			if( card == "D" ) sum += 8;
			if( card == "G" ) sum += 9;
			if( card == "K" ) sum += 10;
			else sum += parseInt( card );
		}
	
		final score = sum % 10;

		print( score == 0 ? "Karaa" : score == 9 ? "Noufi" : score );
	}
}

