import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final n = parseInt( readline());
	final deck = readline().split(" ");
	
	final result = process( n, deck );
	print( result );
}

function process( n:Int, inputDeck:Array<String> ) {

	var deck = inputDeck.copy();
	for( _ in 0...n ) deck = shuffle( deck );
	
	return deck.join(" ");
}

function shuffle( deck:Array<String> ) {
	final h = int( deck.length / 2 );
	final mod = deck.length % 2;
	final deck2 = [];
	for( i in 0...h ) {
		deck2.push( deck[i] );
		deck2.push( deck[i + h + mod] );
	}
	if( mod == 1 ) deck2.push( deck[h] );
	return deck2;
}