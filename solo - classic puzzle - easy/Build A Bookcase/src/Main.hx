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
	
	final lines = [];

	final distance = ( height - 1 ) / numberOfShelves;
	
	final heights = [];
	
	var tempHeight = 0.0;
	var lastHeight = 0;
	for( i in 0...numberOfShelves ) {
		final height = Math.ceil( tempHeight );
		heights.push( height - lastHeight );
		lastHeight = height;
		tempHeight += distance;
	}

	heights.sort(( a, b ) -> b - a );
	heights.unshift( heights.pop());

	final heightSums = [0];
	for( i in 1...heights.length ) {
		heightSums.push( heights[i] + heightSums[i - 1] );
	}

	final centerPiece = width % 2 == 0 ? "" : "^";
	final halfWidth = int( width / 2 );
	final top = "/".repeat( halfWidth ) + centerPiece + "\\".repeat( halfWidth );

	for( y in 0...height - 1 ) {
		if( heightSums.contains( y )) {
			lines.push( "|" + "_".repeat( width - 2 ) + "|" );
		} else {
			lines.push( "|" + " ".repeat( width - 2 ) + "|" );
		}
		
	}

	lines.push( top );
	lines.reverse();

	final output = lines.join( "\n" );
	// trace( "\n" + output );

	return output;
}
