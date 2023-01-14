import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final v = readline();
	final i = readline();
	
	final nums = v.split( "." ).map( s -> parseInt( s ));
	switch i {
		case "MAJOR":
			nums[0]++;
			nums[1] = 0;
			nums[2] = 0;
		case "MINOR":
			nums[1]++;
			nums[2] = 0;
		case "PATCH":
			nums[2]++;
	}

	print( nums.join(".") );
}
