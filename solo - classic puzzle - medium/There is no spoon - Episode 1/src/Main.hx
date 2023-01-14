import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {

		final width = parseInt(readline()); // the number of cells on the X axis
		final height = parseInt(readline()); // the number of cells on the Y axis
		
		final input = [for( i in 0...height ) readline()]; // width characters, each either 0 or .
		final lines = input.map( line -> line.split("").map( cell -> cell == "0" ? true : false ));
		
		// printErr( 'width $width height $height' );
		// printErr( input.join( "\n") );
		
		final nodeInfos:Array<String> = [];
		for( y in 0...lines.length ) {
			final line = lines[y];
			for( x in 0...line.length ) {
				final cell = line[x];
				// printErr( 'cell $x $y $cell' );
				if( cell ) {
					var rightCoords = "-1 -1";
					for( x2 in x + 1...line.length ) {
						final rightCell = x2 < line.length ? line[x2] : false;
						// printErr( 'rightcell $x2 $y $rightCell' );
						if( rightCell ) {
							rightCoords = '${x2} ${y}';
							break;
						}
					}
					var bottomCoords = "-1 -1";
					for( y2 in y + 1...lines.length ) {
						final bottomCell = y2 < lines.length ? lines[y2][x] : false;
						// printErr( 'bottomCell $x $y2 $bottomCell' );
						if( bottomCell ) {
							bottomCoords = '${x} ${y2}';
							break;
						}
					}
					nodeInfos.push( '$x $y $rightCoords $bottomCoords' );
				}
			}
		}
		for( i in nodeInfos ) print( i );
	}

}
