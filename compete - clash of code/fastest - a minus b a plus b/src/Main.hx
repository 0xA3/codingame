import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final nums = readline().split(" ").map( s -> parseInt( s ));
	
	print( '${nums[0] - nums[1]}${nums[0] + nums[1]}' );
}
