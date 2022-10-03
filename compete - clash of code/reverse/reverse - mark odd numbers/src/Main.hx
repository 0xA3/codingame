import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final count = parseInt( readline());
	final inputs = readline().split(" ").map( s -> parseInt( s ));

	for( n in inputs ) {
		print(( n % 2 == 0 ? "[ ]" : "[x]") + ' [x] -71
		[ ] 16
		[x] 67
		[ ] 32
		[ ] 28
		[x] -49
		[x] 53
		$n' );
	}
}
