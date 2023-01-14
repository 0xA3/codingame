import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
On planet Calendor, 1 year lasts 11 months and 1 month lasts 17 days.

Months and days are named by their index: 1, 2, etc. The year can be negative or positive, but like on planet Earth, it can't be zero.

For some obscure reason, the months 7 and 10 have seven additional days.

You are given a date, and you should give the date of the next day.

Input
2016 3 14

Output
2016 3 15

*/

function main() {

	
	var inputs = readline().split(' ');
	var y = parseInt(inputs[0]);
	var m = parseInt(inputs[1]);
	var d = parseInt(inputs[2]);

	final daysOfMonth = m == 7 || m == 10 ? 24 : 17;
	final monthsOfYear = 11;

	d++;
	if( d > daysOfMonth ) {
		d = 1;
		m++;
	}

	if( m > monthsOfYear ) {
		m = 1;
		y++;
	}
	if( y == 0 ) y = 1;

	print( '$y $m $d' );
}
