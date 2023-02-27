import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;
using xa3.StringUtils;

function main() {

	final height = parseInt( readline());
	final width = parseInt( readline());
	final numberOfShelves = parseInt( readline());
	
	final result = process( height, width, numberOfShelves );
	print( result );
}

function process( height:Int, width:Int, numberOfShelves:Int) {
	
	final centerPiece = width % 2 == 0 ? "" : "^";
	final halfWidth = int( width / 2 );
	final top = "/".repeat( halfWidth ) + centerPiece + "\\".repeat( halfWidth );
	final space = "|" + " ".repeat( width - 2 ) + "|";
	final shelf = "|" + "_".repeat( width - 2 ) + "|";
	
	final lines = [];

	final distance = ( height - 1 ) / numberOfShelves;
	
	final shelfHeights = [];
	
	var tempHeight = distance;
	var lastHeight = 0;
	for( _ in 0...numberOfShelves - 1 ) {
		final height = Math.ceil( tempHeight );
		final shelfHeight = height - lastHeight;
		shelfHeights.push( shelfHeight );
		
		lastHeight = height;
		tempHeight += distance;
	}

	shelfHeights.sort(( a, b ) -> b - a );
	shelfHeights.unshift( 0 );

	final heights = [0];
	for( i in 1...shelfHeights.length ) heights.push( shelfHeights[i] + heights[i - 1] );

	for( y in 0...height - 1 ) lines.push( heights.contains( y ) ? shelf : space );

	lines.push( top );
	lines.reverse();

	final output = lines.join( "\n" );
	// trace( "\n" + output );

	return output;
}
