import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

/*
You must output the correct string concatenation depending on the sum result.
If it's positive, output "Foo"
If it's negative, output "Bar"
If it's even, concatenate " & Baz" to the output
If it's odd, concatenate " & Qux" to the output

Input
1
6

Output
Foo & Baz
*/

function main() {

	final n = parseInt( readline());
	final sum = [for( _ in 0...n ) parseInt( readline())].fold(( v, sum ) -> sum + v, 0 );
	
	final p1 = sum >= 0 ? "Foo" : "Bar";
	final p2 = sum % 2 == 0 ? "& Baz" : "& Qux";
	print( '$p1 $p2' );
}
