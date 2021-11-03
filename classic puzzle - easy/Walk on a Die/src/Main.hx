import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final startingPosition = [for( i in 0...3 ) readline()];
	final commands = readline().split( "" );
			
	final result = process( startingPosition, commands );
	print( result );
}

function process( startingPosition:Array<String>, commands:Array<String> ) {
	
	var cube:Cube = {
		current: parseInt( startingPosition[1].charAt( 1 )),
		front: parseInt( startingPosition[0].charAt( 1 )),
		left: parseInt( startingPosition[1].charAt( 0 )),
		right: parseInt( startingPosition[1].charAt( 2 )),
		opposite: parseInt( startingPosition[1].charAt( 3 )),
		behind: parseInt( startingPosition[2].charAt( 1 ))
	}

	for( command in commands ) {
		switch command {
			case "U":
				//  1       4
				// 2354 -> 2156
				//  6       3
				cube = {
					current: cube.front,
					front: cube.opposite,
					left: cube.left,
					right: cube.right,
					opposite: cube.behind,
					behind: cube.current
				}
			case "L":
				//  1       2       4
				// 2354 -> 6314 -> 6215
				//  6       5       3
				cube = {
					current: cube.left,
					front: cube.opposite,
					left: cube.behind,
					right: cube.front,
					opposite: cube.right,
					behind: cube.current
				}
			case "D":
				//  1       6       4
				// 2354 -> 5324 -> 5621
				//  6       1       3
				cube = {
					current: cube.behind,
					front: cube.opposite,
					left: cube.right,
					right: cube.left,
					opposite: cube.front,
					behind: cube.current
				}
			case "R":
				//  1       5       4
				// 2354 -> 1364 -> 1562
				//  6       2       3
				cube = {
					current: cube.right,
					front: cube.opposite,
					left: cube.front,
					right: cube.behind,
					opposite: cube.left,
					behind: cube.current
				}
			}
	}
	return cube.current;
}

typedef Cube = {
	final current:Int;
	final front:Int;
	final left:Int;
	final right:Int;
	final opposite:Int;
	final behind:Int;
}