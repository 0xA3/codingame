import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

typedef GrainPos = {
	final grain:String;
	final pos:Int;
}

function main() {

	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final n = parseInt( readline() );
	final grainPositions:Array<GrainPos> = [for( i in 0...n ) {
		final inputs = readline().split(' ');
		{ grain: inputs[0], pos: parseInt( inputs[1] ) }
	}];
	
	final result = process( w, h, grainPositions );
	print( result );
}

function process( w:Int, h:Int, grainPositions:Array<GrainPos> ) {
	final grid = [for( i in 0...h ) [for( j in 0...w ) " " ]];
	for( grainPosition in grainPositions ) fall( w, h, grid, grainPosition.grain, grainPosition.pos );
	
	return getOutput( w, grid );
}

function fall( w:Int, h:Int, grid:Array<Array<String>>, grain:String, pos:Int ) {
	// trace( 'fall $grain' );
	var y = -1;
	var x = pos;
	
	final dxs = grain.isLowerCase() ? [0, 1, -1] : [0, -1, 1];
	
	while( y < h - 1 ) {
		final ny = y + 1;
		// trace( 'ny: $ny' );
		var hasMoved = false;
		for( dx in dxs ) {
			final nx = x + dx;
			// trace( 'dx: $dx, nx:$nx' );
			if( nx < 0 || nx >= w ) continue;
			if( grid[ny][nx] == " " ) {
				hasMoved = true;
				// trace( 'endpos found $nx:$ny' );
				x = nx;
				break;
			}
		}

		if( !hasMoved ) break;
		
		y = ny;
	}
	grid[y][x] = grain;
	// trace( "\n" + getOutput( w, grid ));
}

function getOutput( w:Int, grid:Array<Array<String>> ) {
	final lines = [for( row in grid ) '|${row.join("")}|'];
	lines.push( '+${"-".repeat( w )}+' );

	return lines.join( "\n" );
}