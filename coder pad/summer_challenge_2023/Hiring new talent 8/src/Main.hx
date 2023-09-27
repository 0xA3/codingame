import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using StringTools;

@:keep function findCorrectPath( instructions:String, target:Array<Int>, obstacles:Array<Array<Int>> ) {
	// printErr( 'instructions $instructions   ${instructions.length}' );
	final commands = [ "1:0" => "FORWARD", "-1:0" => "BACK", "0:1" => "TURN LEFT", "0:-1" => "TURN RIGHT" ];
	final types = [[1, 0], [-1, 0], [0, 1], [0, -1]];
	final obstaclesMap = [for( o in obstacles ) posToString( o[0], o[1] ) => true];
	final instructionsList = instructions.split( "" ).map( s -> switch s {
		case "F": [1, 0];
		case "B": [-1, 0];
		case "L": [0, 1];
		case "R": [0, -1];
		default: throw 'Error: wrong instruction $s';
	});
	var memPositions = [for( _ in 0...instructionsList.length + 1 ) [0, 0, 1, 0]];
	var startId = 0;
	final backup = [];
	for( i in startId...instructions.length ) {
		
		backup[0] = instructionsList[i][0];
		backup[1] = instructionsList[i][1];
		
		for( type in types ) {
			if( type[0] != backup[0] || type[1] != backup[1] ) {
				instructionsList[i] = type;
				// printErr( 'try replace instruction ${i + 1} with ${commands[posToString( type[0], type[1] )]}' );
				if( simulate( memPositions, startId, instructionsList.length, instructionsList, target, obstaclesMap )) return 'Replace instruction ${i + 1} with ${commands[posToString( type[0], type[1] )]}';
			}
		}
		instructionsList[i][0] = backup[0];
		instructionsList[i][1] = backup[1];
		simulate( memPositions, startId, startId + 1, instructionsList, target, obstaclesMap );
		startId++;
	}

	return "no solution found";
}

final sin = [-1, 0, 1, 0];
final cos = [0, 1, 0, -1];

function simulate( memPositions:Array<Array<Int>>, startId:Int, endId:Int, instructions:Array<Array<Int>>, target:Array<Int>, obstaclesMap:Map<String, Bool> ) {
	var x = memPositions[startId][0];
	var y = memPositions[startId][1];
	var dx = memPositions[startId][2];
	var dy = memPositions[startId][3];
	// trace( 'simulate from $startId-$endId $x:$y  ${instructions.slice( startId, endId )}' );
	for( i in startId...endId ) {
		// trace( 'step $i' );
		final instruction = instructions[i];
		x += dx * instruction[0];
		y += dy * instruction[0];
		final theta = instruction[1] + 1;
		final dx2 = Std.int( dx * cos[theta] - dy * sin[theta] );
		final dy2 = Std.int( dx * sin[theta] + dy * cos[theta] );
		dx = dx2;
		dy = dy2;
		
		final nextPosition = memPositions[i + 1];
		// trace( 'x == nextPosition[0] ${x == nextPosition[0]}  y == nextPosition[1] ${y == nextPosition[1]} dx == nextPosition[2] ${dx == nextPosition[2]}  dy == nextPosition[3] ${dy == nextPosition[3]} --- ${x == nextPosition[0] && y == nextPosition[1] && dx == nextPosition[2] && dy == nextPosition[3]}' );
		if( x == nextPosition[0] && y == nextPosition[1] && dx == nextPosition[2] && dy == nextPosition[3] ) return false;
		// trace( 'obstaclesMap.exists( posToString( $x, $y )) --- ${obstaclesMap.exists( posToString( x, y ))}' );
		if( obstaclesMap.exists( posToString( x, y ))) return false;
		// trace( 'manhattanDist( $x, $y, ${target[0]}, ${target[1]} ) ${manhattanDist( x, y, target[0], target[1] )} > instructions.length - $i ${instructions.length - i} --- ${manhattanDist( x, y, target[0], target[1] ) > instructions.length - i}' );
		if( manhattanDist( x, y, target[0], target[1] ) > instructions.length - i ) return false;
		
		nextPosition[0] = x;
		nextPosition[1] = y;
		nextPosition[2] = dx;
		nextPosition[3] = dy;

		// trace( 'instruction $instruction  nextPosition $nextPosition' );
	}

	return x == target[0] && y == target[1];
}

inline function manhattanDist( x1:Int, y1:Int, x2:Int, y2:Int ) return Math.abs( x2 - x1 ) + Math.abs( y2 - y1 );

inline function posToString( x:Int, y:Int ) return '$x:$y';