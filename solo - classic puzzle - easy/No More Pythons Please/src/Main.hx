import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
		
	final inputs = readline().split(' ');
	final h = parseInt( inputs[0] );
	final w = parseInt( inputs[1] );
	final grid = [for( _ in 0...h ) readline().split( "" )];
	
	final result = process( grid, w, h );
	print( result );
}

function process( inputGrid:Array<Array<String>>, w:Int, h:Int ) {
	final headPositions = getHeadPositions( inputGrid, w, h );
	final snakeLengths = headPositions.map( headPosition -> parseSnake( inputGrid, headPosition, w, h ));
	
	snakeLengths.sort(( a, b ) -> b - a );
	final longestSnakeLength = snakeLengths[0];
	
	var longestSnakesCount = 0;
	for( snakeLength in snakeLengths ) {
		if( snakeLength == longestSnakeLength ) longestSnakesCount++;
		else break;
	}
	
	return '${longestSnakeLength}\n$longestSnakesCount';
}

function getHeadPositions( inputGrid:Array<Array<String>>, w:Int, h:Int ) {
	final headPositions:Array<Position> = [];
	for( y in 0...h ) {
		for( x in 0...w ) {
			if( inputGrid[y][x] == "o" ) headPositions.push({ x: x, y: y });
		}
	}
	return headPositions;
}

function parseSnake( inputGrid:Array<Array<String>>, headPosition:Position, w:Int, h:Int ) {
	// trace( 'parseSnake ${headPosition.x}:${headPosition.y}' );
	var pos = headPosition;
	var direction = -1; // 0 - Up, 1 - Left, 2 - Down, 3 - Right
	var length = 0;
	while( true ) {
		length++;
		switch inputGrid[pos.y][pos.x] {
			case "o", "*": direction = getDirection( inputGrid, direction, pos, w, h );
			case "-", "|": // no change in direction
			case "^": if( direction == 0 ) return length; else throw 'Error in snake tail at position ${pos.x}:${pos.y}';
			case "<": if( direction == 1 ) return length; else throw 'Error in snake tail at position ${pos.x}:${pos.y}';
			case "v": if( direction == 2 ) return length; else throw 'Error in snake tail at position ${pos.x}:${pos.y}';
			case ">": if( direction == 3 ) return length; else throw 'Error in snake tail at position ${pos.x}:${pos.y}';
			default: throw 'Error in snake at position ${pos.x}:${pos.y}';
		}

		pos = switch direction {
			case 0: { x: pos.x,     y: pos.y - 1 };
			case 1: { x: pos.x - 1, y: pos.y     };
			case 2: { x: pos.x,     y: pos.y + 1 };
			case 3: { x: pos.x + 1, y: pos.y };
			default: throw 'Error: direction can not be $direction';
		}
		// trace( 'next pos $pos ${inputGrid[pos.y][pos.x]}' );
	}
	return -1;
}

function getDirection( inputGrid:Array<Array<String>>, previousDirection:Int, pos:Position, w:Int, h:Int ) {
	if( pos.y > 0 ) 	if( previousDirection != 2 && inputGrid[pos.y - 1][pos.x] == "|" ) return 0; // check prevDir != Down  and upper field == |
	if( pos.x > 0 ) 	if( previousDirection != 3 && inputGrid[pos.y][pos.x - 1] == "-" ) return 1; // check prevDir != Right and left  field == -
	if( pos.y < h - 1 ) if( previousDirection != 0 && inputGrid[pos.y + 1][pos.x] == "|" ) return 2; // check prevDir != Up    and lower field == |
	if( pos.x < w - 1 ) if( previousDirection != 1 && inputGrid[pos.y][pos.x + 1] == "-" ) return 3; // check prevDir != Left  and right field == -
	throw 'Error in snake at position ${pos.x}:${pos.y}';
}