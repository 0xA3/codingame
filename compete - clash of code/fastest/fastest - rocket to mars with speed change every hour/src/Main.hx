import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
A rocket with astronauts on board is on a mission to MARS to attend a conference with the alien chiefs on a confidential matter. The distance between the rocket to the Mars is dist. But, the aliens are so strict about the timings and set a time limit timeLimit, within which you must reach Mars. You will be given the initial speed speed (in km/hr), for which it will continue to move for the first hour. But the rocket briefly fires its engines to change its speed every hour. The same variation speedChange in speed occurs once every hour throughout the mission. At the end of the time limit, your program must output whether the rocket is able to reach Mars or not...

Remember: The rocket changes it'speed speed only once every hour. And the value for speedChange can be either negative or positive. The output must be true if the rocket reaches Mars exactly at timeLimit hours or before, if it fails, then false. You must also output the distance it would actually cover at the end of timeLimit hours.

*/

function main() {

	final inputs = readline().split(" ");
	final dist = parseInt( inputs[0] );
	final timeLimit = parseInt( inputs[1] );
	final speed = parseInt( inputs[2] );
	final speedChange = parseInt( inputs[3] );
	
	var totalDist = 0;
	for( i in 0...timeLimit ) {
		final distance = speed + i * speedChange;
		totalDist += distance;
	}

	print(( totalDist >= dist ? "true" : "false" ) + ' $totalDist' );
}
