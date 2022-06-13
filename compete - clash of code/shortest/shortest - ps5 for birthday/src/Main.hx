import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;

/*
Matt works as a programmer and wants to buy himself a ps5 for his birthday.

He is paid D dollars every 15th of the month, the ps5 cost X dollars, his birthday is in T days and it is currently the Uth day of the month. (for this exercise we assume that every month only contain 30 days)

Will Matt be able to buy a PS5 on his birthday ?
*/
class Main {
	
	static function main() {
		
		final inputs = readline().split(' ').map( s -> parseInt( s ));
		final d = inputs[0];
		final x = inputs[1];
		final t = inputs[2];
		final u = inputs[3];

		var sum = 0;
		for( i in 0...t ) {
			final day = ( u + i ) % 30;
			if( day == 15 ) sum += d;
			// printErr( 'day $day sum $sum' );
		}

		print( sum == 0 ? "ruined" : sum >= x ? true : false );
	}
}

// short solution
/*
d,x,t,u=gets.split.map &:to_i
puts u+t>14?x<=d*t/30+(u<15?d:0):"ruined"
*/