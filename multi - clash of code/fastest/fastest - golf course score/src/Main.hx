import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
In golf course, each hole has a "par", value which is the maximum number of swings that players should ideally need to clear the hole.
Once a player has cleared the hole, the par is subtracted from the player's effective swing count, resulting in the player's score for that hole (i.e. 2 swings for a par 3 scores -1).
The final score for a player on a course is the total of his scores for each hole in the course.
Given a score card for a 18-hole course, your program must output the player's score.
*/

function main() {

	final inputs = readline().split(' ');
	final pars = [for( s in inputs ) parseInt(s)];
	
	final inputs = readline().split(' ');
	final counts = [for( s in inputs ) parseInt(s)];
	
	var sum = 0;
	for( i in 0...counts.length ) sum += counts[i] - pars[i];

	print( sum );
}
