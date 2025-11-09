import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;
using StringTools;

function main() {
	
	final n = parseInt( readline() );
	final g = parseInt( readline() );

	final grids = [];
	for( index in 0...g ) {
		final content = [for( _ in 0...n ) readline().split( "" )];
		final grid = new Grid( index, content );
		grid.initNumberOfInfected();

		grids.push( grid );
	}

	final result = process( grids );
	print( result );
}

function process( grids:Array<Grid> ) {
	final resultGrid = processGrids( grids );

	return resultGrid.toOutput();
}

function processGrids( grids:Array<Grid> ) {
	var totalInfected = grids.fold(( grid, sum ) -> sum + grid.infected, 0 );
	
	while( true ) {
		final nextGrids = processInfectionsInGrids( grids );
		final nextTotalInfected = nextGrids.fold(( grid, sum ) -> sum + grid.infected, 0 );
		
		if( nextTotalInfected == totalInfected ) break;

		grids = nextGrids;
		totalInfected = nextTotalInfected;
	}

	grids.sort(( grid1, grid2 ) -> grid2.infected - grid1.infected );

	return grids[0];
}

function processInfectionsInGrids( grids:Array<Grid> ) {
	var finishedGrids = 0;
	var nextGrids = [];
	for( grid in grids ) {
		final nextGrid = grid.getNextGrid();
		nextGrids.push( nextGrid );
	}

	return nextGrids;
}
