import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final roundsNo = parseInt( readline() );
		final cash = parseInt( readline() );
		final rounds = [for( i in 0...roundsNo ) readline()];
		
		final result = process( cash, rounds );
		print( result );
	}

	static function process( cash:Int, rounds:Array<String> ) {
		
		final result = rounds.fold(( round, sum ) -> sum + getWin( ceil( sum / 4 ), round ), cash );
		return result;

	}

	static function getWin( amount:Int, round:String ) {
		final parts = round.split(" ");
		final ball = parseInt( parts[0] );
		final call = parts[1];
		final number = parts.length == 3 ? parseInt( parts[2] ) : 0;

		// final p1 =  '$amount on $call ' + ( call == "PLAIN"  ? string( number ) : "" ) + ' - ball $ball - ';

		// trace( p1 + switch call {
		// 	case "EVEN":
		// 		if( ball == 0 ) 'LOSS $amount';
		// 		else if( ball % 2 == 0 ) 'WIN  $amount';
		// 		else 'LOSS $amount';
		// 	case "ODD":
		// 		if( ball % 2 == 1 ) 'WIN  $amount';
		// 		else 'LOSS $amount';
		// 	default: // PLAIN
		// 		if( ball == number ) 'WIN  ${amount * 35}';
		// 		else 'LOSS $amount';
		// });
		
		return switch call {
			case "EVEN":
				if( ball == 0 ) -amount;
				else ball % 2 == 0 ? amount : -amount;
			case "ODD":	ball % 2 == 1 ? amount : -amount;
			default: ball == number ? amount * 35 : -amount; // PLAIN
		}

	}

}
