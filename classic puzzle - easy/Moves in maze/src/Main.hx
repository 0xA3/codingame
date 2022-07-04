import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
		
	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final grid = [for( _ in 0...h ) readline().split( "" )];
	
	final result = process( w, h, grid );
	print( result );
}

function process( width:Int, height:Int, inputGrid:Array<Array<String>> ) {

	final floodFill = new FloodFill( inputGrid, getStartPosition( inputGrid ));
	
	final distanceGrid = [for( y in 0...inputGrid.length ) [for( x in 0...inputGrid[y].length ) inputGrid[y][x] == "#" ? -2 : -1]];
	floodFill.fill( distanceGrid );

	final output = convertDistanceGrid( distanceGrid );
	return output;
}

function getStartPosition( inputGrid:Array<Array<String>> ) {
	for( y in 0...inputGrid.length ) {
		for( x in 0...inputGrid[y].length ) {
			if( inputGrid[y][x] == "S" ) {
				final startPosition:Position = { x: x, y: y, distance: 0 }
				return startPosition;
			}
		}
	}
	throw 'Error: start position not found.';
}

function convertDistanceGrid( distanceGrid:Array<Array<Int>> ) {
	return distanceGrid.map( line -> line.map( v -> distance2Char( v )).join( "" ) ).join( "\n" );
}

function distance2Char( v:Int ) {
	if( v == -2 ) return "#";
	if( v == -1 ) return ".";
	if( v < 10 ) return '$v';
	return String.fromCharCode( v + 55 );
}