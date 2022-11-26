import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final paintings:Array<Painting> = [
		for( _ in 0...n ) {
			final inputs = readline().split(" ");
			{ rows: parseInt( inputs[0] ), cols: parseInt( inputs[1] ), isWhite: inputs[2] == "1" }
		}
	];
	
	final result = process( paintings );
	print( result );
}

function process( paintings:Array<Painting> ) {
	final results = paintings.map( p -> processPainting( p.cols, p.rows, p.isWhite ));
	
	return results.join( "\n" );
}

function processPainting( cols:Int, rows:Int, isWhite:Bool ) {

	final totalPossibleBoards = ( max( cols - 7, 0 )) * ( max( rows - 7, 0 ));
	final validBoards = totalPossibleBoards / 2;
	
	return isWhite ? Math.ceil( validBoards ) : Math.floor( validBoards );
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;

typedef Painting = {
	final cols:Int;
	final rows:Int;
	final isWhite:Bool;
}