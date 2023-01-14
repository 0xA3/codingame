import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
The problem is to find the extra letters in the figure.

You are given a string s of the letters that are allowed in the figure.
You are also given a figure of n rows and n columns. The figure consists of letters, . and #.

The rules are:
1. Some letters may appear more than once in the figure.
2. Some letters may appear more than once in s.
3. . and # in the figure should be ignored.
4. The number of occurrences of each letter in s should be the same as that in the figure. For example, if A appears 3 times in s, then A should also appear exactly 3 times in the figure.
5. If all occurrences match, output Correct.
6. If the figure shows more letters than s, output Incorrect followed by a space and all the extra letters sorted in alphabetical order, e.g. Incorrect AABZ.

Example1:

ABCDEFG
3
ABC
DEF
GHD


Output => Incorrect DH

Example2:

WERTY
5
.W...
...R.
..E..
Y..T.
.....


Output => Correct

*/

using Lambda;

class Main {
	
	static function main() {
		
		final s = readline().split( "" );
		final n = parseInt( readline());
		final figure = [for( _ in 0...n ) readline().split("").filter( s -> s != "." && s != "#")].flatten();
	
		final incorrect = [];
		for( char in figure ) {
			if( s.indexOf( char ) == -1 ) {
				incorrect.push( char );
			} else {
				s.remove( char );
			}
		}
		
		if( incorrect.length == 0 ) print( "Correct" );
		else {
			incorrect.sort(( a, b ) -> {
				if( a > b ) return 1;
				if( a < b ) return -1;
				return 0;
			});
			print( 'Incorrect ${incorrect.join( "" )}' );
		}
	}
}

