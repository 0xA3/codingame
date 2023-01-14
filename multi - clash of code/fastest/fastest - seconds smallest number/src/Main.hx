import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = readline();
	final nums = readline().split(" ").map( s -> parseInt( s ));
	nums.sort(( a, b ) -> a - b );
	
	print( '${nums[1]}' );
}
