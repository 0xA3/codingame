import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

/*
ou are given a string of unique lowercase letters s and a number n.

Your task is to create new strings by removing letters of the original string s. You can remove none, any or all of the letters. The order of those letters is preserved.

Now create all strings following the rules above.
Then sort the resulting list first by length, then alphabetically.
Then output the n-th string of the list (starting from 1).

Example: s is "cab", n is 6
Possible strings are: "", "a", "b", "c", "ab", "ca", "cb", "cab"
Your output should be "ca"

Input
cab
6

Output
"ca"

*/

class Main {
	
	static function main() {
		
		final s = readline();
		final n = parseInt( readline());
		print( process( s, n ));
	}

	static function process( s:String, n:Int ) {
		final combinations = [""].concat( s.combinations());
		
		combinations.sort(( a, b ) -> {
			if( a.length < b.length ) return -1;
			if( a.length > b.length ) return 1;
			if( a < b ) return -1;
			if( a > b ) return 1;
			return 0;
		});

		return combinations[n - 1];
	}
}
