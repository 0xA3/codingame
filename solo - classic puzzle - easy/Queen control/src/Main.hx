import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef Board = Array<Array<String>>;

final EMPTY = ".";
final SIZE = 8;
final directions = [
	[ 0, -1],
	[-1, -1],
	[-1,  0],
	[-1,  1],
	[ 0,  1],
	[ 1,  1],
	[ 1,  0],
	[ 1, -1]
];

function main() {
	final color = readline().charAt( 0 );
	final board = [for( _ in 0...SIZE ) readline().split( "" )];
	
	final result = process( color, board );
	print( result );
}

function process( color:String, board:Board ) {
	final queen = getQueenPosition( board );

	final isClear = [for( d in directions ) true];
	var controlled = 0;
	for( distance in 1...SIZE ) {
		for( d in 0...directions.length ) {
			if( isClear[d] ) {
				final x = queen.x - directions[d][0] * distance;
				final y = queen.y - directions[d][1] * distance;
				if( x < 0 || x >= SIZE || y < 0 || y >= SIZE ) {
					isClear[d] = false;
					continue;
				}
				final position = board[y][x];
				if( position == EMPTY ) {
					controlled++;
				} else if( position == color ) {
					isClear[d] = false;
				} else {
					controlled++;
					isClear[d] = false;
				}
			}
		}
	}

	return controlled;
}

function getQueenPosition( board:Board ) {
	for( y in 0...SIZE ) for( x in 0...SIZE ) if( board[y][x] == "Q") return { x: x, y: y }

	throw 'Error: Queen not found';
}