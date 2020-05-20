using Lambda;

import Std.parseInt;
import CodinGame.readline;
import CodinGame.print;

class Main {
	
	static final beats = [
		Rock => [Scissors, Lizard],
		Paper => [Rock, Spock],
		Scissors => [Paper, Lizard],
		Lizard => [Paper, Spock],
		Spock => [Scissors, Rock],
	];

	static function main() {
		
		final n = parseInt( readline());
		final players:Array<Player> = [];
		for ( i in 0...n ) {
			var inputs = readline().split(' ');
			final NUMPLAYER = parseInt(inputs[0]);
			final SIGNPLAYER = inputs[1];

			final player:Player = { num: NUMPLAYER, sign: parseSign( SIGNPLAYER ), opponents: [] };
			players.push( player );
		}
		
		final winner = play( players );
		print( '${winner.num}' );
		print( '${winner.opponents.join(" ")}' );
	}

	static function play( players:Array<Player> ) {
		if( players.length == 1 ) return players[0];
		final matches = Std.int( players.length / 2 );
		final winners:Array<Player> = [];
		for( i in 0...matches ) {
			final p1 = players[i * 2];
			final p2 = players[i * 2 + 1];
			switch [compare( p1.sign, p2.sign ), p1.num < p2.num] {
				case [ 1, _] | [0, true]:  winners.push({ num: p1.num, sign: p1.sign, opponents: p1.opponents.concat( [p2.num] ) });
				case [-1, _] | [0, false]: winners.push({ num: p2.num, sign: p2.sign, opponents: p2.opponents.concat( [p1.num] ) });
				default: // no-op
			}
		}
		return play( winners );
	}

	static inline function compare( s1:Sign, s2:Sign ) {
		if( s1 == s2 ) return 0;
		if( beats[s1].contains( s2 )) return 1;
		return -1;
	}

	static inline function parseSign( s:String ) {
		return switch s {
			case "R": Rock;
			case "P": Paper;
			case "C": Scissors;
			case "L": Lizard;
			case "S": Spock;
			case _: throw 'Error: no pattern';
		}		
	}

}

typedef Player = {
	final num:Int;
	final sign:Sign;
	final opponents:Array<Int>;
}

enum abstract Sign(String) {
	var Rock ="R";
	var Paper = "P";
	var Scissors = "C";
	var Lizard = "L";
	var Spock = "S";
}