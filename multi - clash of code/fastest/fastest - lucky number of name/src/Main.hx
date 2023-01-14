import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import xa3.MathUtils;

using Lambda;
using xa3.StringUtils;

/*
to find your lucky number, you simply have to calculate the sum of all the digits of the alphabetic position (1 for A, 2 for B... 26 for Z) of each character of your name until the sum's length is equal to one.
Uppercase and lowercase letters are treated as the same and everything that is not in the alphabet will be ignored:

example for "john":

john => 10 + 15 + 8 +14 = 47
47 => 4+7 => 11
11 => 1+ 1 => 2

john's lucky number is 2 !

*/

function main() {

	final name = readline().split( "" );
	
	final chars = name.map( s -> {
		final char = s.toLowerCase();
		if( !char.isLowercase() ) return 0;
		return char.charCodeAt( 0 ) - "a".code + 1;
	});

	var sum = chars.fold(( v, sum ) -> sum + v, 0 );

	while( sum > 9 ) sum = MathUtils.digitSum( sum );

	print( sum );
}
