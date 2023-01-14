import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;

/*
A robot operates on a 2D plane system, at a given time, the robot is at specific coordinates a,b.
The robot wants to get to a specific destination x,y.
The robot can only move one unit each step in either UP, DOWN, RIGHT, or LEFT directions.
Your job is to calculate the number of moves the robot needs to make to reach the destination.

0 0
1 0

Output
1
*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final robotX = parseInt(inputs[0]);
		final robotY = parseInt(inputs[1]);
		final inputs = readline().split(' ');
		final destX = parseInt(inputs[0]);
		final destY = parseInt(inputs[1]);	
		print( '${abs( destX - robotX ) + abs( destY - robotY)}' );
	}
}

