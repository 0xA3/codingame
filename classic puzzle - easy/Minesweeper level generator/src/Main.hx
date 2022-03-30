import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;
using xa3.MathUtils;

var minesGrid:Array<Array<Bool>>;
var width:Int;
var height:Int;

function main() {

	final inputs = readline().split(' ');
	final width = parseInt(inputs[0]);
	final height = parseInt(inputs[1]);
	final mines = parseInt(inputs[2]);
	final x = parseInt(inputs[3]);
	final y = parseInt(inputs[4]);
	final seed = parseInt(inputs[5]);
		
	final result = process( width, height, mines, x, y, seed );
	print( result );
}

function process( width:Int, height:Int, mines:Int, clickX:Int, clickY:Int, seed:Int ) {
	
	Main.width = width;
	Main.height = height;
	// trace( 'width $width, height $height, mines $mines, clickX $clickX, clickY $clickY, seed $seed' );
	
	final prng = new PseudoRandomNumberGenerator( seed );

	minesGrid = [for( _ in 0...height ) [for( _ in 0...width ) false]];
	var placedMines = 0;
	while ( placedMines < mines ) {
		final x = int( prng.random() % width );
		final y = int( prng.random() % height );
		final dx = abs( clickX - x );
		final dy = abs( clickY - y );
		// trace( 'x: $x, y: $y, dx: $dx, dy: $dy  place mine $i ${(dx > 1 || dy > 1 ) && !minesGrid[y][x]}' );
		if(( dx > 1 || dy > 1 ) && !minesGrid[y][x] ) {
			minesGrid[y][x] = true;
			placedMines++;
		}
	}

	// final minesOutput = minesGrid.map( row -> row.map( v -> v ? "#" : "." ).join( "" )).join( "\n" );
	// trace( "\n" + minesOutput );

	final outputGrid = [];
	for( y in 0...height ) {
		outputGrid[y] = [];
		for( x in 0...width ) {
			if( minesGrid[y][x] ) outputGrid[y][x] = "#";
			else outputGrid[y][x] = getMinesCountAround( x, y );
		}
	}

	return outputGrid.map( row -> row.join( "" )).join( "\n" );
}

function getMinesCountAround( cellX:Int, cellY:Int ) {
	var sum = 0;
	for( y in ( cellY - 1 ).max( 0 )...( cellY + 2 ).min( height )) {
		for( x in ( cellX - 1 ).max( 0 )...( cellX + 2 ).min( width )) {
			if( minesGrid[y][x] ) sum++;
		}
	}
	return sum == 0 ? "." : string( sum );
}
