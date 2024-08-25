import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

final directions = ["U", "L", "D", "R"];
var directionIndex = directions.indexOf( "R" );

final turns = [
	"UL" => "L",
	"LD" => "L",
	"DR" => "L",
	"RU" => "L",
	"RD" => "R",
	"DL" => "R",
	"LU" => "R",
	"UR" => "R"
];

function main() {

	final h = parseInt( readline() );
	final w = parseInt( readline() );
	final grid = [for( i in 0...h ) readline().split( "" )];

	final result = process( w, h, grid );
	print( result );
}

function process( width:Int, height:Int, grid:Array<Array<String>> ) {
	final path = search( width, height, grid );
	final outputs = resolve( path );

	return outputs.join( "" );
}

function search( width:Int, height:Int, grid:Array<Array<String>> ) {
	final visitedGrid = [for( i in 0...height ) [for( j in 0...width ) false]];

	var pos = { x: -1, y: 0 };
	final path = [];
	
	var hasNextStep = true;
	while( hasNextStep ) {
		hasNextStep = false;
		for( i in 0...directions.length ) {
			final currentDirectionIndex = ( directionIndex + i ) % directions.length;
			final direction = directions[currentDirectionIndex];
			final nextPos = switch( direction ) {
				case "R": { x: pos.x + 1, y: pos.y };
				case "L": { x: pos.x - 1, y: pos.y };
				case "U": { x: pos.x, y: pos.y - 1 };
				case "D": { x: pos.x, y: pos.y + 1 };
				default: throw 'Error: invalid direction';
			}
			if( nextPos.x < 0 || nextPos.y < 0 || nextPos.x >= width || nextPos.y >= height ) continue;
			
			final nextChar = grid[nextPos.y][nextPos.x];
			if( nextChar == "#" && visitedGrid[nextPos.y][nextPos.x] == false ) {
				pos = nextPos;
				visitedGrid[pos.y][pos.x] = true;
				path.push( direction );
				directionIndex = currentDirectionIndex;
				hasNextStep = true;
			}
		}
	}
	// trace( path.join( "" ));
	return path;
}

function resolve( path:Array<String> ) {
	var outputs = [];
	var direction = "R";
	var counter = 0;
	for( i in 0...path.length ) {
		final step = path[i];
		// trace( '$i $step  counter $counter' );
		if( step == direction ) {
			counter++;
		} else {
			outputs.push( '$counter' );
			final turnCombination = path[i - 1] + step;
			final turn = turns[turnCombination];
			// trace( 'turnCombination $turnCombination' );
			outputs.push( turn );
			counter = 1;
			direction = step;
		}
	}
	outputs.push( '$counter' );
	return outputs;

}
