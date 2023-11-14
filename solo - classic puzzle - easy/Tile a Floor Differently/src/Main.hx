import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using GridUtils;
using Lambda;
using StringUtils;

function main() {
	final quarterSize = parseInt( readline() );
	final rows = [for( _ in 0...quarterSize ) readline().split( "" )];

	final result = process( quarterSize, rows );
	print( result );
}

function process( quarterSize:Int, pattern:Array<Array<String>> ) {
	final tileWidth = 2 * quarterSize + 1;
	final tileHeight = 2 * quarterSize + 1;

	final outputWidth = tileWidth * 2 + 1;
	final outputHeight = tileHeight * 2 + 1;

	final tileBorder = GridUtils.fromString( "+" + "-".repeat( tileWidth ) + "+\n" + "|\n".repeat( tileHeight ));
	
	final topRight = pattern.mirrorHorizontally();
	final bottomLeft = pattern.mirrorVertically();
	final bottomRight = bottomLeft.mirrorHorizontally();

	final tileGrid = GridUtils.fromDimensions( tileWidth, tileHeight );
	tileGrid.paste( pattern );
	tileGrid.paste( topRight, quarterSize );
	tileGrid.paste( bottomLeft, 0, quarterSize );
	tileGrid.paste( bottomRight, quarterSize, quarterSize );

	final outputGrid = [for( _ in 0...outputHeight ) [for( _ in 0...outputWidth ) " "]];
	for( y in [0, tileHeight, outputHeight - 1] ) {
		for( x in [0, tileWidth, outputWidth - 1] ) {
			outputGrid.paste( tileBorder, x, y );
			outputGrid.paste( tileGrid, x + 1, y + 1 );
		}
	}

	return outputGrid.visualize();
}
