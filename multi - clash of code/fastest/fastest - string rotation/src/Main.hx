import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
A string rotation is done by taking each character of a string one-by-one and pushing it by one character to the right or to the left. Characters that are pushed "out" of the string return on the opposite side of the string. Rotating the string abc to the right once turns it into cab. Rotating it twice turns it into bca.

Given a string s1 and s2, determine whether s2 is a rotation (by any amount) of s1, regardless of case.

Example 1:
s1 = AbcD and s2 = CDab, print true
s2 can be rotated 2 times to the right to be equal to s1: (CDab => bCDa => abCD)

Example 2:
s1 = ZYXW and s2 = XYzW, print false
No matter how many times you rotate s2, it'll never be equal to s1

Input
AbcD
CDab

Output
true
*/

function main() {

	var s1 = readline().toLowerCase();
	final s2 = readline().toLowerCase();
	
	for( _ in 0...s1.length ) {
		s1 = rotate( s1 );
		if( s1 == s2 ) {
			print( "true" );
			return;
		}
	}
	print( false );
}

function rotate( s:String ) return s.charAt( s.length - 1 ) + s.substr( 0, s.length - 1 );
