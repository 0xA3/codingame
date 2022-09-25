import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

final ROCK = "ROCK";
final PAPER = "PAPER";
final SCISSORS = "SCISSORS";

function main() {

	final inputs = readline().split(' ');
	final call1 = inputs[0];
	final call2 = inputs[1];

	final winner = switch [call1, call2] {
		case [ROCK,PAPER]: 2;
		case [ROCK,SCISSORS]: 1;
		case [PAPER,SCISSORS]: 2;
		case [PAPER,ROCK]: 1;
		case [SCISSORS,ROCK]: 2;
		case [SCISSORS,PAPER]: 1;
		default: 0;
	}
	
	print( winner == 0 ? "DRAW" : 'PLAYER$winner' );
}
