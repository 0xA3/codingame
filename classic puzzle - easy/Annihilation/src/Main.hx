import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
		
	final inputs = readline().split(' ');
	final h = parseInt( inputs[0] );
	final w = parseInt( inputs[1] );
	final grid = [for( _ in 0...h ) readline().split( "" )];
	
	final result = process( grid, w, h );
	print( result );
}

function process( inputGrid:Array<Array<String>>, w:Int, h:Int ) {
	var grid = [for( y in 0...inputGrid.length ) [for( x in 0...inputGrid[y].length ) inputGrid[y][x] != "." ? [inputGrid[y][x]] : []]];
	var arrowsNum = grid.fold(( line, sumLine ) -> sumLine + line.fold(( cell, sumCell ) -> sumCell + cell.length, 0 ), 0);

	var step = 0;
	// printGrid( step, arrowsNum, grid );
	
	while( arrowsNum > 0 ) {
		grid = moveArrows( grid, w, h );
		
		// eliminate arrows
		for( y in 0...grid.length ) {
			for( x in 0...grid[y].length ) {
				if( grid[y][x].length > 1 ) {
					arrowsNum -= grid[y][x].length;
					grid[y][x] = [];
				}
			}
		}
		step++;
		// printGrid( step, arrowsNum, grid );
	}

	return step;
}

function moveArrows( grid:Array<Array<Array<String>>>, w:Int, h:Int ) {
	final outputGrid = [for( line in grid ) [for( _ in line ) []]];
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x].length > 0 ) {
				final char = grid[y][x].shift();
				switch char {
					case "^": outputGrid[( y - 1 + h ) % h][x]                 .push( char );
					case "v": outputGrid[( y + 1 ) % h]    [x]                 .push( char );
					case "<": outputGrid[y]                [( x - 1 + w ) % w ].push( char );
					case ">": outputGrid[y]                [( x + 1 ) % w ]    .push( char );
					default: throw 'Error: with char $char in cell $x:$y';
				}
			}
		}
	}
	return outputGrid;
}

function printGrid( step:Int, arrowsNum:Int, grid:Array<Array<Array<String>>> ) {
	final output = grid.map( line -> line.map( cell -> cell.length == 0 ? "." : cell.join( "" )).join( "" )).join( "\n" );
	printErr( '$step arrows $arrowsNum\n$output' );
}