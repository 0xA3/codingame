import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;

function main() {

	final inputs = readline().split(' ');
	final a = parseInt(inputs[0]);
	final b = parseInt(inputs[1]);
	final object:Object = [for( i in 0...a ) readline().split( "" ).map( s -> s == "*" )];
	
	final inputs = readline().split(' ');
	final c = parseInt(inputs[0]);
	final d = parseInt(inputs[1]);
	final grid:Grid = [for( i in 0...c ) readline().split( "" ).map( s -> s == "." )];
	
	final result = process( a, b, object, c, d, grid );
	print( result );
}

function process( objectHeight:Int, objectWidth:Int, object:Object, gridHeight:Int, gridWidth:Int, grid:Grid ) {
	
	final xSteps = gridWidth - objectWidth + 1;
	final ySteps = gridHeight - objectHeight + 1;
	
	final solutions = [];
	for( y in 0...ySteps ) {
		for( x in 0...xSteps ) {
			if( checkObjectInGrid( x, y, objectHeight, objectWidth, object, grid )) {
				solutions.push({ x: x, y: y });
			}
		}
	}
	
	if( solutions.length != 1 ) return '${solutions.length}';
	
	final placedObject = placeObjectInGrid( solutions[0].x, solutions[0].y, objectHeight, objectWidth, object, grid );
	return '1\n$placedObject';
}

function checkObjectInGrid( x:Int, y:Int, objectHeight:Int, objectWidth:Int, object:Object, grid:Grid ) {
	// trace( "\n" + placeObjectInGrid( x, y, objectHeight, objectWidth, object, grid ));
	for( ox in 0...objectWidth ) {
		for( oy in 0...objectHeight ) {
			final o = object[oy][ox];
			final g = grid[y + oy][x + ox];
			if( o && !g ) return false;
		}
	}
	return true;
}

function placeObjectInGrid( x:Int, y:Int, objectHeight:Int, objectWidth:Int, object:Object, grid:Grid ) {
	final sGrid = grid.map( line -> line.map( cell -> cell ? "." : "#" ));
	for( oy in 0...object.length ) {
		for( ox in 0...object[oy].length ) {
			if( object[oy][ox] ) sGrid[y + oy][x + ox] = grid[y + oy][x + ox] ? "*" : "%";
		}
	}
	return sGrid.map( line -> line.join( "" )).join( "\n" );
}

typedef Object = Array<Array<Bool>>;
typedef Grid = Array<Array<Bool>>;