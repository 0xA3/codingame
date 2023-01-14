import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Jeff needs your help calculating his final balance after a series of deposits (D) and withdrawals (W) done to his bank account! He already has V in his bank account.

40 3
W 120
D 120
D 30

Output
70
*/

function main() {

	final inputs = readline().split(" ").map( s -> parseInt( s ));
	final v = inputs[0];
	final n = inputs[0];
	
	final transactions = [for( _ in 0...inputs[1] ) {
		final ip = readline().split(" ");
		{ type: ip[0], amount: parseInt( ip[1] )};
	}];
	// final inputs = [for( _ in 0...n ) parseInt( readline())];
	var balance = v;
	for( transaction in transactions ) {
		if( transaction.type == "W" ) balance -= transaction.amount;
		else if( transaction.type == "D" ) balance += transaction.amount;
	}

	print( balance );
}
