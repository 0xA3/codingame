import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

final tricksWorths = [
	"C" => 20,
	"D" => 20,
	"H" => 30,
	"S" => 30,
	"N" => 30
];

function main() {
	final nbTests = parseInt( readline());
	final deals = [for( i in 0...nbTests ) readline()];

	final result = process( deals );
	print( result );
}

function process( deals:Array<String> ) {
	return deals.map( deal -> processDeal( deal )).join( "\n" );
}

function processDeal( deal:String ) {
	final parts = deal.split(" ");
	if( parts[1] == "Pass" ) return 0;
	
	final isVulnerable = parts[0] == "V";
	final contract = parseContract( parts[1] );
	final wins = parseInt( parts[2] );
	final overtricks = wins - contract.winsNeeded;
	final isGameWon = overtricks >= 0;
	
	// trace( 'isGameWon $isGameWon  deal $deal  isVulnerable $isVulnerable  contract $contract, wins $wins, overticks $overtricks' );

	if( isGameWon ) {
		final tricksSingleScore = contract.suit == "N"
		? contract.pass * 30 + 10
		: contract.pass * tricksWorths[contract.suit];

		final tricksScore = switch contract.doubles {
			case 0: tricksSingleScore;
			case 1: tricksSingleScore * 2;
			case 2: tricksSingleScore * 4;
			default: throw 'Error: contract doubles can not be ${contract.doubles}';
		}

		final gameBonus = tricksScore < 100
		? 50
		: isVulnerable ? 500 : 300;
		
		final smallSlamBonus = contract.pass == 6 && wins >= 12
		? isVulnerable ? 750 : 500
		: 0;
		
		final grandSlamBonus = contract.pass == 7 && wins == 13
		? isVulnerable ? 1500 : 1000
		: 0;
		
		final overtricksScore =
			switch [contract.doubles, isVulnerable] {
			case [0, _]: overtricks * tricksWorths[contract.suit];
			case [1, false]: overtricks * 100;
			case [1, true]: overtricks * 200;
			case [2, false]: overtricks * 200;
			case [2, true]: overtricks * 400;
			default: throw 'Error: contract doubles can not be ${contract.doubles}';
		}

		final doubleScore = contract.doubles * 50;

		// trace( '\ntricksScore $tricksScore\ngameBonus $gameBonus\nsmallSlamBonus $smallSlamBonus\ngrandSlamBonus $grandSlamBonus\novertricks $overtricks\novertricksScore $overtricksScore\ndoubleScore $doubleScore' );

		return tricksScore + gameBonus + smallSlamBonus + grandSlamBonus + overtricksScore + doubleScore;

	} else {
		final underticks = -overtricks;
		final nonVulnerableDoubled = [100, 200, 200, 300, 300, 300, 300];
		final vulnerableDoubled = [200, 300, 300, 300, 300, 300, 300];
		
		// trace( 'underticks $underticks  doubles ${contract.doubles}  isVulnerable $isVulnerable' );

		final underticksScore =
		switch [contract.doubles, isVulnerable] {
			case [0, false]: overtricks * 50;
			case [0, true]:  overtricks * 100;
			case [1, false]: -sumNOfArray( underticks, nonVulnerableDoubled );
			case [1, true]: -sumNOfArray( underticks, vulnerableDoubled );
			case [2, false]: -sumNOfArray( underticks, nonVulnerableDoubled ) * 2;
			case [2, true]: -sumNOfArray( underticks, vulnerableDoubled ) * 2;
			default: throw 'Error: contract doubles can not be ${contract.doubles}';
		}

		// trace( 'underticksScore $underticksScore' );
		return underticksScore;
	}

	return 0;
}

function parseContract( s:String ) {
	final parts = s.split( "" );
	final pass = parseInt( parts[0] );
	final suit = parts[1];
	final doubles = suit == "N" ? parts.length - 3 : parts.length - 2;

	return { pass: pass, winsNeeded: pass + 6, suit: suit, doubles: doubles }
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
function sumNOfArray( n:Int, a:Array<Int> ) return sum( [for( i in 0...n ) a[i]]);
function sum( a:Array<Int> ) return a.fold(( v, sum ) -> sum + v, 0 );
