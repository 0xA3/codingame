import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

var totalHeight:Int;
var totalWidth:Int;

function main() {

	final framePattern = readline(); // the ASCII art pattern to use to frame the picture
	final inputs = readline().split(' ');
	final h = parseInt( inputs[0] ); // the height of the picture
	final w = parseInt( inputs[1] ); // the width  of the picture
	final lines = [for( i in 0...h ) readline()]; // the ASCII art picture line by line
		
	final result = process( framePattern, h, w, lines );
	print( result );
}

function process( framePattern:String, h:Int, w:Int, lines:Array<String> ) {

	final pictureCells = lines.map( line -> line.split( "" ));
	final frameCells = ( framePattern + " " ).split( "" );
	final frameWidth = frameCells.length;
	totalHeight = 2 * frameCells.length + h;
	totalWidth = 2 * frameCells.length + w;

	final grid = [];
	for( y in 0...totalHeight ) {
		grid[y] = [];
		for( x in 0...totalWidth ) {
			final borderDistances = getBorderDistances( x, y );
			final minDistance = min( borderDistances.x, borderDistances.y );
			if( minDistance < frameCells.length ) grid[y][x] = frameCells[minDistance];
			else grid[y][x] = pictureCells[y - frameWidth][x - frameWidth];
		}
	}

	return grid.map( line -> line.join( "" )).join( "\n" );
}

inline function getBorderDistances( x:Int, y:Int ) {
	final dx = min( x, totalWidth - 1 - x );
	final dy = min( y, totalHeight - 1 - y );
	return { x: dx, y: dy }
}
