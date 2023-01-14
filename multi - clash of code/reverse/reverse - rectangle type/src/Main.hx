import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	final c = parseInt( readline());
	
	final a2 = a * a;
	final b2 = b * b;
	final c2 = c * c;

	final a2b2 = a2 + b2;

	if( a == 0 || b == 0 || c == 0 ) print( "IMPOSSIBLE" );
	else if( a == b && b == c ) print( "EQUILATERAL" );
	else if( c2 == a2b2 ) print( "RIGHT" );
	else if( a > b + c || b > a + c || c > a + b ) print( "IMPOSSIBLE" );
	else if( a == b || a == c || b == c ) print( "ISOSCELES" );
	else print( "SCALENE" );

}
