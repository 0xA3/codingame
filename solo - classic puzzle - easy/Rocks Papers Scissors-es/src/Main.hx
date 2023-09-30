import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

enum Move {
	Rock;
	Paper;
	Scissors;
}

function main() {
	final n = parseInt( readline());
	final moves = [for( _ in 0...n ) parseMove( readline())];
	
	final result = process( moves );
	print( result );
}

function parseMove( s:String ) {
	switch s {
		case "Rock": return Rock;
		case "Paper": return Paper;
		case "Scissors": return Scissors;
	}
	throw 'Error: unknown move $s';
}

function moveToString( m:Move ) {
	switch m {
		case Rock: return "Rock";
		case Paper: return "Paper";
		case Scissors: return "Scissors";
	}
}

function process( oppMoves:Array<Move> ) {
	
	final myMoves = [Rock, Paper, Scissors];

	var myBestMove = Rock;
	var bestStart = 0;
	var maxWins = 0;
	for( myMove in myMoves ) {
		for( start in 0...oppMoves.length ) {
			final wins = getWins( start, myMove, oppMoves );
			// trace( 'start $start  move $myMove  wins $wins\n' );
			if( wins > maxWins ) {
				myBestMove = myMove;
				maxWins = wins;
				bestStart = start;
				// trace( 'changed myBestMove $myBestMove  bestStart $bestStart\n' );
			}
		}
	}

	return '${moveToString( myBestMove )}\n$bestStart';
}

function getWins( start:Int, myMove:Move, oppMoves:Array<Move> ) {
	var wins = 0;
	for( i in start...start + oppMoves.length ) {
		final oppMove = oppMoves[i % oppMoves.length];
		// trace( '${i % oppMoves.length}  play $myMove $oppMove  ${compareMove( myMove, oppMove )}' );
		final result = compareMove( myMove, oppMove );
		if( i == start && result != 1 ) break;
		else if( result == 1 ) wins++;
		else if( result == -1 ) break;
	}

	return wins;
}

function compareMove( m1:Move, m2:Move ) {
	switch [m1, m2] {
		case [Rock, Rock]: return 0;
		case [Rock, Paper]: return -1;
		case [Rock, Scissors]: return 1;
		case [Paper, Rock]: return 1;
		case [Paper, Paper]: return 0;
		case [Paper, Scissors]: return -1;
		case [Scissors, Rock]: return -1;
		case [Scissors, Paper]: return 1;
		case [Scissors, Scissors]: return 0;
	}
}
