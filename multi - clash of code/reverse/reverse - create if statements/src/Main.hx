import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final n = parseInt( readline());

	for( i in 0...n ) {
		print(( i == 0 ?'if' : "elif" ) + ' n == ${i + 1}:' );
		print( '    print("n is ${i + 1}")' );
	}
	
	print( 'else:\n    print("number not found :(")' );
}
