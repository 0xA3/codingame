import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final w = parseInt(inputs[0]);
		final h = parseInt(inputs[1]);
		final n = parseInt(readline());
		// final n = 20;
		final lines = [for( i in 0...h) readline()];
		
		printErr( 'width $w height $h operations $n' );
		printErr( lines.join( "\n") );

		final steps:Array<Step> = [
			{ x: 0, y: -1 },
			{ x: 1, y: 0 },
			{ x: 0, y: 1 },
			{ x: -1, y: 0 },
		];

		var initialPosition:Position = { x: 0, y: 0 };
		final grid:Array<Array<Bool>> = [];
		for( y in 0...lines.length ) {
			grid[y] = new Array<Bool>();
			final cells = lines[y].split("");
			for( x in 0...cells.length ) {
				grid[y][x] = cells[x] == "#";
				if( cells[x] == "O") initialPosition = { x: x, y: y };
			}
		}
		printErr( 'initialPosition ${initialPosition.x}:${initialPosition.y}:0' );

		var dir = 0;
		var pos = initialPosition;
		final positions:Array<Position> = [ initialPosition ];
		for( _ in 0...n ) {
			var frontCell = getNextPosition( pos, steps[dir] );
			if( grid[frontCell.y][frontCell.x] ) {
				printErr( 'obstacle ${frontCell.x}:${frontCell.y}' );
				dir = ( dir + 1 ) % steps.length;
			}
			pos = getNextPosition( pos, steps[dir] );
			
			if( pos.x == initialPosition.x && pos.y == initialPosition.y ) break;

			printErr( 'push ${pos.x}:${pos.y}:$dir' );
			positions.push( pos );
		}
		printErr( 'positions ${positions.length} endstate id = ${n} % ${positions.length} ${n % ( positions.length)}' );
		final endState = positions[n % positions.length ];

		print( '${endState.x} ${endState.y}' );
	}

	static inline function getNextPosition( pos:Position, direction:Step ) {
		return { x: pos.x + direction.x, y: pos.y + direction.y };
	}

}

typedef State = {
	final pos:Position;
	final dir:Int;
}

typedef Position = {
	var x:Int;
	var y:Int;
}

typedef Step = Position;