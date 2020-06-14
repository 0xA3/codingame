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

		final directions:Array<Direction> = [
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
		final states:Array<State> = [];
		for( i in 0...n ) {
			var frontCell = getNextPosition( pos, directions[dir] );
			if( grid[frontCell.y][frontCell.x] ) {
				printErr( 'obstacle ${frontCell.x}:${frontCell.y}' );
				dir = ( dir + 1 ) % directions.length;
			}
			
			if( i > 0 && pos.x == initialPosition.x && pos.y == initialPosition.y && dir == 0 ) break;

			pos = getNextPosition( pos, directions[dir] );
			printErr( 'push ${pos.x}:${pos.y}:$dir' );
			states.push({ pos: pos, dir: dir });
		}
		printErr( 'states ${states.length} endstate id = ${n} % ${states.length} ${n % ( states.length)}' );
		final endState = states[(n % states.length ) - 1];

		print( '${endState.pos.x} ${endState.pos.y}' );
	}

	static inline function getNextPosition( pos:Position, direction:Direction ) {
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

typedef Direction = Position;