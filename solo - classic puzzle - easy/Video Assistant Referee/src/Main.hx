import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef GameState = {
	final attackingTeam:String;
	final activePlayerPositions:Array<Int>;
	final playerPositionsInOpponentHalf:Array<Int>;
	final secondLastOpponentPosition:Int;
	final ballPosition:Int;
	final isThrowIn:Bool;
}

final A = "A";
final B = "B";

final players = "player(s) in an offside position.\nVAR:";
final noPlayer = "No player in an offside position.\nVAR:";
final onside = "ONSIDE!";
final offside = "OFFSIDE!";

function main() {
	final grid = [for( i in 0...15 ) readline().split( "" )];

	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {
	final gameState = getGameState( grid );

	if( gameState.playerPositionsInOpponentHalf.length == 0 || gameState.isThrowIn ) return '$noPlayer $onside';
	
	final offsidePlayers = gameState.playerPositionsInOpponentHalf.filter( pos -> {
		gameState.attackingTeam == A
		? pos < gameState.ballPosition && pos < gameState.secondLastOpponentPosition
		: pos > gameState.ballPosition && pos > gameState.secondLastOpponentPosition;
	});

	final offsidePlayersNum = offsidePlayers.length;
	if( offsidePlayersNum == 0 ) return '$noPlayer $onside';

	final offsideActivePlayers = gameState.activePlayerPositions.filter( pos -> offsidePlayers.contains( pos ));
	if( offsideActivePlayers.length == 0 ) return '$offsidePlayersNum $players $onside';

	return '$offsidePlayersNum $players $offside';
}

function getGameState( grid:Array<Array<String>> ) {
	final playersA:Array<Int> = [];
	final activePlayersA:Array<Int> = [];
	final playersB:Array<Int> = [];
	final activePlayersB:Array<Int> = [];
	var ballX = 0;
	var ballY = 0;
	var ballTeam = "";

	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			final cell = grid[y][x];
			switch cell {
				case "a": playersA.push( x );
				case "A":
					playersA.push( x );
					activePlayersA.push( x );
				case "b": playersB.push( x );
				case "B":
					playersB.push( x );
					activePlayersB.push( x );
				case "o":
					ballX = x;
					ballY = y;
					ballTeam = A;
				case "O":
					ballX = x;
					ballY = y;
					ballTeam = B;
				default: // no-op
			}
		}
	}

	playersA.sort(( a, b ) -> b - a );
	playersB.sort(( a, b ) -> a - b );

	// trace( 'playersA $playersA' );
	// trace( 'activePlayersA $activePlayersA' );
	// trace( 'playersB $playersB' );
	// trace( 'activePlayersB $activePlayersB' );
	// trace( 'ball $ballX:$ballY' );
	// trace( 'ballTeam $ballTeam' );
	
	final attackingTeam = activePlayersA.length > 0 ? A : B;
	final playerPositionsInOpponentHalf = switch attackingTeam {
		case A: playersA.filter( pos -> pos < 25 );
		case B: playersB.filter( pos -> pos > 25 );
		default: throw 'Error: attacking team is $attackingTeam';
	}

	final gameState:GameState = {
		attackingTeam: attackingTeam,
		activePlayerPositions: attackingTeam == A ? activePlayersA : activePlayersB,
		playerPositionsInOpponentHalf: playerPositionsInOpponentHalf,
		secondLastOpponentPosition: attackingTeam == A ? playersB[1] : playersA[1],
		ballPosition: ballX,
		isThrowIn: ballY == 0 || ballY == 14
	}

	return gameState;
}


