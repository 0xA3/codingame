import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
CodeBoy likes muffins a lot, he eats at least N muffins daily to keep himself HAPPY.
His mother is a busy lady. She can prepare M muffins only in the morning (6:00 AM).
Muffins get stale at rate of R muffins per hour, so if R=1: muffin 1 will get stale in 1 hour, muffin 2 will get stale in next hour and so on.

CodeBoy doesn't eat any stale muffin as it makes him sick and unhappy.
But he will eat all good muffins T hours after his mom has cooked them.
Can you tell whether the CodeBoy be HAPPY?

Example: CodeBoy needs to eat N=10 muffins, his mother cooks M=14 muffins in the morning, and R=2 stale muffins per hour.
If he waits T⩽2 hours to eat, he will have enough good muffins to eat and will be HAPPY.
If he waits T⩾3 hours before eating the muffins, he will have less good one to eat and will be NOT HAPPY.

Input
1 1 1 0

Output
HAPPY
*/

function main() {

	final inputs = readline().split(' ');
	final n = parseInt( inputs[0] );
	final m = parseInt( inputs[1] );
	final r = parseInt( inputs[2] );
	final t = parseInt( inputs[3] );
	
	final goodMuffins = m - r * t;
	// printErr( 'n $n  m $m  r $r  t $t  goodMuffins $goodMuffins' );
	print( goodMuffins >= n ? "HAPPY" : "NOT HAPPY" );
}
