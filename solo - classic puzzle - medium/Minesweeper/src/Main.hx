import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Pos.NO_POS;
import Std.int;
import Std.parseInt;
import Std.random;
import haxe.ds.ArraySort;

using Main;

typedef ProbabilityPos = {
	final p:Float;
	final pos:Pos;
}

inline var WIDTH = 30;
inline var HEIGHT = 16;
inline var SAFE = 0;
inline var CLEARED = -1;
inline var UNKNOWN = -2;
inline var MINE = -3;

final positions:Array<Array<Pos>> = [for( y in 0...HEIGHT ) [for( x in 0...WIDTH ) new Pos( x, y )]];
final probabilitiesMap:Map<Pos, Float> = [];
final minesSet:Map<Pos, Bool> = [];
final newMines:Array<Pos> = [];

function main() {
	
	for( i in 0...HEIGHT ) readline();
	// print( '${random( WIDTH )} ${random( HEIGHT )}' );
	print( '${int( WIDTH / 2 )} ${int( HEIGHT / 2 )}' );

	// var turn = 0;
	// while( turn++ < 10 ) {
	while( true ) {
		final grid = [for( i in 0...HEIGHT ) readline().split( " " )];
		final output = process( grid );

		print( output );
	}
}

function resetMines() minesSet.clear();

function process( grid:Array<Array<String>> ) {
	// printErr( grid.map( row -> row.join("")).join( "\n" ));
	newMines.splice( 0, newMines.length );
	probabilitiesMap.clear();
	
	final intGrid = getIntGrid( grid );
	insertMines( intGrid );
	return processIntGrid( intGrid );
}

function getIntGrid( grid:Array<Array<String>> ) {
	final intGrid:Array<Array<Int>> = [];
	for( y in 0...grid.length ) {
		intGrid.push( [] );
		for( x in 0...grid[y].length ) {
			switch grid[y][x].charCodeAt( 0 ) {
				case "*".code: intGrid[y][x] = MINE;
				case ".".code: intGrid[y][x] = CLEARED;
				case "?".code: intGrid[y][x] = UNKNOWN;
				default: intGrid[y][x] = grid[y][x].charCodeAt( 0 ) - "0".code;
			}
		}
	}
	return intGrid;
}

function insertMines( intGrid:Array<Array<Int>> ) for( minePos in minesSet.keys() ) intGrid[minePos.y][minePos.x] = MINE;

function processIntGrid( intGrid:Array<Array<Int>> ) {
	// check single cells
	for( y in 0...intGrid.length ) {
		for( x in 0...intGrid[y].length ) {
			final cellValue = intGrid[y][x];
			if( cellValue.isNotCount() ) continue;

			final mineNeighborsNum = getNeighborsOfType( intGrid, x, y, MINE ).length;
			final remainingCellValue = cellValue - mineNeighborsNum;

			// find mines
			final unknownNeighbors = getNeighborsOfType( intGrid, x, y, UNKNOWN );
			
			// printErr( '$x:$y ($cellValue) - unknownNeighbors ${outputSet( unknownNeighbors )}' );
			// printErr( 'unknownNeighbors.length == cellValue: ${unknownNeighbors.length} == $cellValue  ${unknownNeighbors.length == cellValue}' );
			if( unknownNeighbors.length == remainingCellValue ) {
				for( cellNeighbor in unknownNeighbors ) {
					printErr( '$x:$y - found a mine at $cellNeighbor' );
					probabilitiesMap.set( cellNeighbor, 1 );
					intGrid[cellNeighbor.y][cellNeighbor.x] = MINE;
					newMines.push( cellNeighbor );
				}
			}
			
			// find safe cells
			final unknownNeighbors = getNeighborsOfType( intGrid, x, y, UNKNOWN );
			if( remainingCellValue == 0 ) {
				for( cellNeighbor in unknownNeighbors ) {
					printErr( 'pos $x:$y - found a safe cell at $cellNeighbor' );
					intGrid[cellNeighbor.y][cellNeighbor.x] = SAFE;
					probabilitiesMap.set( cellNeighbor, 0 );
				}
			}
		}
	}
	
	if( [for( _ in probabilitiesMap ) 0].length == 0 ) printErr( "No single cell solution found" );
	
	// check cell pairs
	printErr( 'check cell pairs' );
	for( y in 0...intGrid.length ) {
		for( x in 0...intGrid[y].length ) {
			final cell1Value = intGrid[y][x];
			if( cell1Value.isNotCount() ) continue;

			final mineNeighbors1Num = getNeighborsOfType( intGrid, x, y, MINE ).length;
			final remainingCell1Value = cell1Value - mineNeighbors1Num;

			final pairCellPositions = getNeighborsWithNumber( intGrid, x, y );
			if( pairCellPositions.length == 0 ) continue;

			final cell1Neighbors = getNeighborsOfType( intGrid, x, y, UNKNOWN );
			if( cell1Neighbors.length == 0 ) continue;

			for( cell2Position in pairCellPositions ) {
				// printErr( 'Found pair at $x:$y and ${cell2Position.x}:${cell2Position.y}' );
				final cell2Value = intGrid[cell2Position.y][cell2Position.x];
				final mineNeighbors2Num = getNeighborsOfType( intGrid, cell2Position.x, cell2Position.y, MINE ).length;
				final remainingCell2Value = cell2Value - mineNeighbors2Num;

				final cell2Neighbors = getNeighborsOfType( intGrid, cell2Position.x, cell2Position.y, UNKNOWN );
				
				final minesDifference = remainingCell1Value - remainingCell2Value;
				
				
				// printErr( '  mines around first cell: ${outputSet( cell1Neighbors )}  around second cell: ${outputSet( cell2Neighbors )}  mines difference $cell1Value - $remainingCell2Value = $minesDifference' );
				if( minesDifference < 0 ) continue;

				final neighborsOfOnlyCell1 = getElementsOfOnlyFirst( cell1Neighbors, cell2Neighbors );
				final neighborsOfOnlyCell1Count = neighborsOfOnlyCell1.length;

				// printErr( '  neighborsOfOnlyCell1: ${outputSet( neighborsOfOnlyCell1 )}' );
				if( minesDifference == neighborsOfOnlyCell1Count ) {
					for( cell1Neighbor in neighborsOfOnlyCell1 ) {
						printErr( 'found mine at ${cell1Neighbor.x}:${cell1Neighbor.y}' );
						probabilitiesMap.set( cell1Neighbor, 1 );
						intGrid[cell1Neighbor.y][cell1Neighbor.x] = MINE;
						newMines.push( cell1Neighbor );
						
						// printErr( outputGrid( intGrid ) );
						
						return processIntGrid( intGrid );
					}
				} else if( minesDifference > neighborsOfOnlyCell1Count ) {
					// printErr( '  minesDifference ($minesDifference) > neighborsOfOnlyCell1 count ($neighborsOfOnlyCell1Count) - not possible' );
				} else {
					// printErr( '  minesDifference ($minesDifference) < neighborsOfOnlyCell1 count ($neighborsOfOnlyCell1Count) - mines not assignable' );
				}
			}
		}
	}

	if( [for( _ in probabilitiesMap ) 0].length == 0 ) printErr( "No pair cell solution found" );

	final remainingUnknownCells = [];
	for( y in 0...intGrid.length ) {
		for( x in 0...intGrid[y].length ) {
			final cellValue = intGrid[y][x];
			if( intGrid[y][x] == UNKNOWN ) remainingUnknownCells.push( positions[y][x] );
		}
	}

	final random = Std.random( remainingUnknownCells.length );
	probabilitiesMap.set( remainingUnknownCells[random], 0.5 );

/*
	// find probabilities
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			final cellCode = grid[y][x].charCodeAt( 0 );
			if( cellCode < "1".code || cellCode > "9".code  ) continue;
			var numMinesInNeighborCells = cellCode - "0".code;
			
			final unknownNeighbors = getUnknownNeighbors( x, y );
			
			final probabilityPerCell = numMinesInNeighborCells / unknownNeighbors.length;
			for( neighbor in unknownNeighbors ) {
				if( !probabilitiesMap.exists( neighbor )) probabilitiesMap.set( neighbor, 0 );
				probabilitiesMap[neighbor] = probabilitiesMap[neighbor].max( probabilityPerCell );
			}
		}
	}
*/
	final probabilitiesPositions:Array<ProbabilityPos> = [for( pos => probability in probabilitiesMap ) { p: probability, pos: pos }];

	ArraySort.sort( probabilitiesPositions, ( a, b ) -> {
		if( a.p < b.p ) return -1;
		if( a.p > b.p ) return 1;
		return 0;
	});
	
	if( probabilitiesPositions.length == 0 ) return 'No solution found';
	if( probabilitiesPositions[0].p == 1 ) return 'No safe cell found';

	for( probability in probabilitiesPositions ) {
		// printErr( '${probability.pos.x}:${probability.pos.y} - ${probability.p}' );
	}

	for( minePosition in newMines ) minesSet.set( minePosition, true );

	final mineMarkers = newMines.map( mine -> '${mine.x} ${mine.y}' ).join( " " );

	return '${probabilitiesPositions[0].pos.x} ${probabilitiesPositions[0].pos.y} $mineMarkers';
}

function getNeighborsOfType( intGrid:Array<Array<Int>>, posX:Int, posY:Int, type:Int ) {
	if( intGrid.length == 0 ) return [];

	final width = intGrid[0].length;
	final height = intGrid.length;

	final neighbors = [];
	for( dy in -1...2 ) {
		for( dx in -1...2 ) {
			if( dy == 0 && dx == 0 ) continue;
			final x = posX + dx;
			final y = posY + dy;
			if( x >= 0 && x < width && y >= 0 && y < height && intGrid[y][x] == type ) {
				neighbors.push( positions[y][x] );
			}
		}
	}
	return neighbors;
}

function getNeighborsWithNumber( intGrid:Array<Array<Int>>, posX:Int, posY:Int ) {
	if( intGrid.length == 0 ) return [];
	
	final width = intGrid[0].length;
	final height = intGrid.length;

	final neighbors = [];
	for( dy in -1...2 ) {
		for( dx in -1...2 ) {
			if( dy == 0 && dx == 0 ) continue;
			final x = posX + dx;
			final y = posY + dy;
			if( x >= 0 && x < width && y >= 0 && y < height ) {
				if( intGrid[y][x] >= 1 && intGrid[y][x] <= 9 ) neighbors.push( positions[y][x] );
			}
		}
	}
	return neighbors;
}

function outputGrid( intGrid:Array<Array<Int>> ) {
	if( intGrid.length == 0 ) return '';
	
	final output = [["  "]];
	for( i in 0...intGrid[0].length ) output[0].push( '${i % 10}' );
	for( y in 0...intGrid.length ) {
		output.push( ['${y % 10}|']);
		for( x in 0...intGrid[y].length ) {
			output[y + 1].push( switch ( intGrid[y][x] ) {
				case SAFE: "s";
				case CLEARED: ".";
				case UNKNOWN: "?";
				case MINE: "*";
				default: '${intGrid[y][x]}';
			});
		}
	}

	return output.map( a -> a.join( "" )).join( "\n" );
}

function outputSet( set:Array<Pos> ) {
	return "[" +set.map( pos -> '${pos.x}:${pos.y}' ).join( "," ) + "]";
}

function getElementsOfBoth( a1:Array<Pos>, a2:Array<Pos> ) {
	final result = [];
	for( pos in a1 ) if( a2.contains( pos )) result.push( pos );
	
	return result;
}

function getElementsOfOnlyFirst( a1:Array<Pos>, a2:Array<Pos> ) {
	final result = [];
	for( pos in a1 ) if( !a2.contains( pos )) result.push( pos );
	
	return result;
}

function isCount( v:Int ) return v >= 1 && v <= 9;
function isNotCount( v:Int ) return v < 1 || v > 9;
function max( v1:Float, v2:Float ) return v1 > v2 ? v1 : v2;
function min( v1:Float, v2:Float ) return v1 < v2 ? v1 : v2;