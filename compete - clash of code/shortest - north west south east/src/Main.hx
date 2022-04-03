import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.round;

class Main {
	
	static function main() {
		
		final s = [
			"NORTH" => "*\n|",
			"SOUTH"=> "|\n*",
			"EAST"=> "----*",
			"WEST"=> "*----",
			"NORTHEAST"=> " *\n/",
			"SOUTHWEST"=> " /\n*",
			"NORTHWEST"=> "*\n \\",
			"SOUTHEAST"=> "\\\n *"
		];

		print( s[readline()] );

	}
}

