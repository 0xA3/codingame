import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final rotation = [
	"^" => ">",
	">" => "v",
	"v" => "<",
	"<" => "^"
];

final deltas = [
	"^" => { x: 0, y: -1 },
	">" => { x: 1, y: 0 },
	"v" => { x: 0, y: 1 },
	"<" => { x: -1, y: 0 }
];

function main() {
		
	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	var inputs = readline().split(' ');
	final x = parseInt( inputs[0] );
	final y = parseInt( inputs[1] );
	final lines = [for( _ in 0...h ) readline().split( '' )];
	
	final result = process( x, y, w, h, lines );
	print( result );
}

function process( startX:Int, startY:Int, width:Int, height:Int, grid:Array<Array<String>> ) {

	var x = startX;
	var y = startY;
	
	var count = 0;
	while( true ) {
		count++;
		grid[y][x] = rotation[grid[y][x]];
		final delta = deltas[grid[y][x]];
		x += delta.x;
		y += delta.y;
		// plot( count, grid );
		final out = x < 0 || y < 0 || x >= width || y >= height;
		final atStart = x == startX && y == startY;
		if( out || atStart ) break;
	}
	
	return count;
}

function plot( count:Int, grid:Array<Array<String>> ) {
	final output = grid.map( cells -> cells.join( "" )).join( "\n" );
	printErr( '$count\n$output' );
}
