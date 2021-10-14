import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final lines = [for( i in 0...3 ) readline()];
			
	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	
	final top = parseInt( lines[0].charAt( 1 ));
	final bottom = parseInt( lines[2].charAt( 1 ));
	final left = parseInt( lines[1].charAt( 0 ));
	final front = parseInt( lines[1].charAt( 1 ));
	final right = parseInt( lines[1].charAt( 2 ));
	final back = parseInt( lines[1].charAt( 3 ));

	if( top + bottom != 7 || left + right != 7 || front + back != 7 ) return "degenerate";

	final vertices = [
		[top, front, left],
		[top, right, front],
		[top, back, right],
		[top, left, back],
		[bottom, left, front],
		[bottom, front, right],
		[bottom, right, back],
		[bottom, back, left]
	];

	final vertex123 = vertices.filter( v -> v.contains( 1 ) && v.contains( 2 ) && v.contains( 3 )).flatten();
	final doubleVertex = vertex123.concat( vertex123 ).join("");
	// trace( '\n${lines.join("\n")}\n$vertex123  $doubleVertex' );
	return doubleVertex.indexOf( "123" ) == -1 ? "right-handed" : "left-handed";
}
