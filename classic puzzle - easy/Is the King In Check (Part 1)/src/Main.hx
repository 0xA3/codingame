import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.int;

using Lambda;

function main() {
	
	final board = [for( i in 0...8 ) readline().split(" ")].flatten();
	
	final result = process( board );
	print( result );
}	

function process( board:Array<String> ) {
	
	final kingIndex = board.indexOf( "K" );
	final kingX = getX( kingIndex );
	final kingY = getY( kingIndex );
	
	final piece = getPiece( board );

	// trace( 'King $kingX:$kingY' );
	// trace( piece );

	final isCheck = switch piece.type {
		case Bishop: getCheckBishop( piece.x, piece.y, kingX, kingY );
		case Knight: getCheckKnight( piece.x, piece.y, kingX, kingY );
		case Rook:   getCheckRook  ( piece.x, piece.y, kingX, kingY );
		case Queen:  getCheckQueen ( piece.x, piece.y, kingX, kingY );
	}

	return isCheck ? "Check" : "No Check";
}

function getPiece( board:Array<String> ) {
	for( i in 0...board.length ) {
		final p = board[i];
		if(p != "_" && p != "K" ) {
			final type = parsePiece( p );
			final piece:Piece = {
				type: type,
				x: getX( i ),
				y: getY( i )
			}
			return piece;
		}
	}
	throw "Error: no piece found.";
}

function getX( i:Int ) return i % 8;
function getY( i:Int ) return int( i / 8 );

function parsePiece( s:String ) {
	return switch s {
		case "B": Bishop;
		case "N": Knight;
		case "R": Rook;
		case "Q": Queen;
		default: throw 'Error: unknown piece $s';
	}
}

function getCheckBishop( x:Int, y:Int, kingX:Int, kingY:Int ) {
	return kingX - x == kingY - y;
}

function getCheckKnight( x:Int, y:Int, kingX:Int, kingY:Int ) {
	final dx = int( abs( kingX - x ));
	final dy = int( abs( kingY - y ));
	return dx == 2 && dy == 1 || dx == 1 && dy == 2;
}

function getCheckRook( x:Int, y:Int, kingX:Int, kingY:Int ) {
	return x == kingX || y == kingY;
}

function getCheckQueen( x:Int, y:Int, kingX:Int, kingY:Int ) {
	return getCheckRook( x, y, kingX, kingY ) || getCheckBishop( x, y, kingX, kingY );
}

typedef Piece = {
	final type:TPiece;
	final x:Int;
	final y:Int;
}

enum TPiece {
	Bishop;
	Knight;
	Rook;
	Queen;
}