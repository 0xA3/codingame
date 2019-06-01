
import js.lib.ArrayBuffer;
/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final w = Std.parseInt(inputs[0]); // width of the building.
		final h = Std.parseInt(inputs[1]); // height of the building.
		final n = Std.parseInt( CodinGame.readline()); // maximum number of turns before game over.
		final inputs = CodinGame.readline().split(' ');
		final x0 = Std.parseInt(inputs[0]); // Start x of Batman
		final y0 = Std.parseInt(inputs[1]); // Start y of Batman

		// CodinGame.printErr( 'building width: $w, building height: $h' );


		final completeArea = new Area( 0, 0, w - 1, h - 1 );
		
		CodinGame.printErr( 'completeArea: $completeArea' );

		final bombAreas:Array<Area> = [ completeArea ];
		var x = x0;
		var y = y0;
		// game loop
		while (true) {
			
			final bombDir = CodinGame.readline(); // the direction of the bombs from batman's current location (U, UR, R, DR, D, DL, L or UL)
			final lastBombArea = bombAreas[ bombAreas.length - 1 ]; //CodinGame.printErr( 'lastBombArea: $lastBombArea' );
			
			final bombArea = switch bombDir {
				case "U":	new Area( x, lastBombArea.top, x, y - 1 );
				case "UR":	new Area( x + 1, lastBombArea.top, lastBombArea.right, y - 1 );
				case "R":	new Area( x + 1, y, lastBombArea.right, y );
				case "DR":	new Area( x + 1, y + 1, lastBombArea.right, lastBombArea.bottom );
				case "D":	new Area( x, y + 1, x, lastBombArea.bottom );
				case "DL":	new Area( lastBombArea.left, y + 1, x - 1, lastBombArea.bottom );
				case "L":	new Area( lastBombArea.left, y, x - 1, y );
				case _: 	new Area( lastBombArea.left, lastBombArea.top, x - 1, y - 1 ); // case "UL"
			}


			// CodinGame.printErr( 'bombArea: $bombArea' );
			final center = bombArea.center;
			// CodinGame.printErr( 'center of bombArea: ${center.x} ${center.y}' );
			
			CodinGame.print( '${center.x} ${center.y}' );
			
			x = center.x;
			y = center.y;

			bombAreas.push( bombArea );
		}
	}


}
