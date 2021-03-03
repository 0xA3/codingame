import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;
import Std.string;

typedef Dir = {
	final x:Int;
	final y:Int;
	final dir:String;
}

final dirs:Map<String, Dir> = [
	'1T' =>  { x:  0, y: 1, dir: 'T' },
	'1L' =>  { x:  0, y: 1, dir: 'T' },
	'1R' =>  { x:  0, y: 1, dir: 'T' },
	'2L' =>  { x:  1, y: 0, dir: 'L' },
	'2R' =>  { x: -1, y: 0, dir: 'R' },
	'3T' =>  { x:  0, y: 1, dir: 'T' },
	'4T' =>  { x: -1, y: 0, dir: 'R' },
	'4R' =>  { x:  0, y: 1, dir: 'T' },
	'5T' =>  { x:  1, y: 0, dir: 'L' },
	'5L' =>  { x:  0, y: 1, dir: 'T' },
	'6L' =>  { x:  1, y: 0, dir: 'L' },
	'6R' =>  { x: -1, y: 0, dir: 'R' },
	'7T' =>  { x:  0, y: 1, dir: 'T' },
	'7R' =>  { x:  0, y: 1, dir: 'T' },
	'8L' =>  { x:  0, y: 1, dir: 'T' },
	'8R' =>  { x:  0, y: 1, dir: 'T' },
	'9T' =>  { x:  0, y: 1, dir: 'T' },
	'9L' =>  { x:  0, y: 1, dir: 'T' },
	'10T' => { x: -1, y: 0, dir: 'R' },
	'11T' => { x:  1, y: 0, dir: 'L' },
	'12R' => { x:  0, y: 1, dir: 'T' },
	'13L' => { x:  0, y: 1, dir: 'T' }
];

final turns = [
	'2L' => 3,
	'2R' => 3,
	'3L' => 2,
	'3R' => 2,
	'4L' => 5,
	'4R' => 5,
	'5L' => 4,
	'5R' => 4,
	'6L' => 9,
	'6R' => 7,
	'7L' => 6,
	'7R' => 8,
	'8L' => 7,
	'8R' => 9,
	'9L' => 8,
	'9R' => 6,
	'10L' => 13,
	'10R' => 11,
	'11L' => 10,
	'11R' => 12,
	'12L' => 11,
	'12R' => 13,
	'13L' => 12,
	'13R' => 10
];

function main() {
	
	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] ); // number of columns.
	final h = parseInt( inputs[1] ); // number of rows.
	final map = [for( i in 0...h ) readline().split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
	final exit = parseInt( readline()); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

}

function findPos( map:Array<Array<Int>>, dir:Dir ) {
	final stone = map[dir.y][dir.x];
	final newPath = [{
		move: dirs[string( abs( stone )) + dir.dir]
	}];

	if( stone != 0 ) {
		
	}
}