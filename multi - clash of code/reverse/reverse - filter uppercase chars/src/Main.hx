import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

function main() {

	final s = readline().split("");
	
	print( s.filter( char -> char.isUppercase()).join("") );
}
