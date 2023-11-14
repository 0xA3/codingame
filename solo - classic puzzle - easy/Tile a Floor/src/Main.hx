import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using GridUtils;
using Lambda;
using StringUtils;

function main() {
	final n = parseInt( readline() );
	final rows = [for( _ in 0...n ) readline().split( "" )];

	final result = process( rows );
	print( result );
}

function process( inputPattern:Array<Array<String>> ) {
	
	final patternWidth = inputPattern[0].length;
	final patternHeight = inputPattern.length;

	final topRight = inputPattern.mirrorHorizontally();
	final bottomLeft = inputPattern.mirrorVertically();
	final bottomRight = bottomLeft.mirrorHorizontally();

	final tileWidth = 2 * patternWidth + 1;
	final tileHeight = 2 * patternHeight + 1;

	final outputWidth = tileWidth * 2 - 1;
	final outputHeight = tileHeight * 2 - 1;

	final tileBorder = GridUtils.fromString( "+" + "-".repeat( tileWidth ) + "+\n" + "|\n".repeat( tileHeight ));
	final tileGrid = GridUtils.fromDimensions( tileWidth, tileHeight );
	tileGrid.paste( inputPattern );
	tileGrid.paste( topRight, patternWidth - 1 );
	tileGrid.paste( bottomLeft, 0, patternHeight - 1 );
	tileGrid.paste( bottomRight, patternWidth - 1, patternHeight - 1 );

	final outputGrid = [for( _ in 0...outputHeight ) [for( _ in 0...outputWidth ) " "]];
	for( y in [0, tileHeight - 1, outputHeight - 1] ) {
		for( x in [0, tileWidth - 1, outputWidth - 1] ) {
			outputGrid.paste( tileBorder, x, y );
			outputGrid.paste( tileGrid, x + 1, y + 1 );
		}
	}

	return outputGrid.visualize();
}
