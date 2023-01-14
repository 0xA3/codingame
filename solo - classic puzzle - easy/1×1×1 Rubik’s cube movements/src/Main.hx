import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static final axisMappings = [
		"x" => ["F", "U", "B", "D"],
		"y" => ["F", "L", "B", "R"],
		"z" => ["U", "R", "D", "L"]
	];

	static function main() {
		
		final rotations = readline().split(" ");
		final face1 = readline();
		final face2 = readline();
		
		final result = process( rotations, [face1, face2] );
		print( result );
	}

	static function process( rotations:Array<String>, inputFaces:Array<String> ) {
		
		var faces = inputFaces.copy();
		for( rotation in rotations ) {
			final mappings = axisMappings[rotation.charAt(0)];
			final direction = rotation.length == 1 ? 1 : -1;
			faces = faces.map( face -> mappings.contains( face ) ? mappings[( mappings.indexOf( face ) + 4 + direction ) % 4] : face );
		}
		
		return faces.join( "\n" );
	}

}
