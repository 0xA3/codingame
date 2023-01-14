import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Given two strings of the same length, your task is to transform one into the other by changing one character at a time, from left to right.

For example, if the strings are "bubble gum" and "turtle ham", the transformation goes as follows:
bubble gum
tubble gum
turble gum
turtle gum
turtle hum
turtle ham

Input
bubble gum
turtle ham

Output
bubble gum
tubble gum
turble gum
turtle gum
turtle hum
turtle ham

*/

class Main {
	
	static function main() {
		
		final source = readline();
		final target = readline();
	
		for( i in 0...source.length ) {
			if( source.charAt( i ) != target.charAt( i )) print( target.substr( 0, i ) + source.substr( i ));
		}
		
		print( target );
	}
}

