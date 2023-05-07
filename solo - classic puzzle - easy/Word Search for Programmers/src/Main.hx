import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

final directions = [
	[1, 0],
	[-1, 0],
	[0, 1],
	[0, -1],
	[1, 1],
	[1, -1],
	[-1, 1],
	[-1, -1]
];

function main() {

	final size = parseInt( readline());
	final rows = [for( _ in 0...size ) readline().split( "" )];
	final clues = readline().split(" ");

	final result = process( rows, clues );
	print( result );
}

function process( inputGrid:Array<Array<String>>, clues:Array<String> ) {
	final outputGrid = [for( y in 0...inputGrid.length ) [for( _ in 0...inputGrid[y].length ) " "]];
	
	for( word in clues ) {
		// trace( 'search $word' );
		final chars = word.toUpperCase().split( "" );
		for( y in 0...inputGrid.length ) {
			for( x in 0...inputGrid[y].length ) {
				if( inputGrid[y][x] == chars[0] ) {
					// trace( 'found ${chars[0]} at position $x:$y' );
					searchWord( x, y, chars, inputGrid, outputGrid );
				}
			}
		}
	}
	
	final output = outputGrid.map( row -> row.join( "" )).join( "\n" );
	return output;
}

function searchWord( startX:Int, startY:Int, chars:Array<String>, inputGrid:Array<Array<String>>, outputGrid:Array<Array<String>> ) {
	for( direction in directions ) {
		final dx = direction[0];
		final dy = direction[1];
		if( search( startX, startY, dx, dy , chars, inputGrid )) paste( startX, startY, dx, dy, chars, outputGrid );
	}
}

function search( startX:Int, startY:Int, dx:Int, dy:Int, chars:Array<String>, inputGrid:Array<Array<String>> ) {
	for( i in 1...chars.length ) {
		final x = startX + dx * i;
		final y = startY + dy * i;
		
		if( x < 0 || y < 0 || y >= inputGrid.length || x >= inputGrid[y].length ) return false;
		// trace( '$x:$y compare ${chars[i]} with ${inputGrid[y][x]}' );
		if( chars[i] != inputGrid[y][x] ) return false;
		
		// else trace( 'found ${chars[i]} at $x:$y' );
	}
	
	return true;
}

function paste( startX:Int, startY:Int, dx:Int, dy:Int, chars:Array<String>, outputGrid:Array<Array<String>> ) {
	for( i in 0...chars.length ) {
		final x = startX + dx * i;
		final y = startY + dy * i;
		outputGrid[y][x] = chars[i];
	}
}
