import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final input = readline();
	
	final result = process( input );
	print( result );
}

function process( input:String ) {

	final parts = input.split(" ");
	final directionIsRight = parts[0] == "right";
	final howManyArrows = parseInt( parts[1] );
	final heightOfArrows = parseInt( parts[2] );
	final strokeThicknessOfArrows = parseInt( parts[3] );
	final spacingBetweenArrows = parseInt( parts[4] );
	final additionalIndentOfEachLine = parseInt( parts[5] );

	final char = directionIsRight ? ">" : "<";
	final maxIndentation = int( heightOfArrows / 2 );
	
	final lines = [];
	for( y in 0...heightOfArrows ) {
		final yBorderDistance = min( y, heightOfArrows - y - 1 );
		final indentation = directionIsRight ? yBorderDistance : maxIndentation - yBorderDistance;
		
		final indentationSpaces = " ".repeat( indentation * additionalIndentOfEachLine );
		final arrow = char.repeat( strokeThicknessOfArrows );
		final spaces = " ".repeat( spacingBetweenArrows );
		final line = indentationSpaces + [for( _ in 0...howManyArrows ) arrow].join( spaces );

		lines.push( line );
	}

	return lines.join( "\n" );
}

function min( v1:Int, v2:Int ) return v1 > v2 ? v2 : v1;