import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;


@:keep function findCorrectPath( instructions:String, target:Array<Int>, obstacles:Array<Array<Int>> ) {
	
	final commands = [ "1:0" => "FORWARD", "-1:0" => "BACK", "0:1" => "TURN LEFT", "0:-1" => "TURN RIGHT" ];
	final types = [[1, 0], [-1, 0], [0, 1], [0, -1]];
	final obstaclesMap = [for( o in obstacles ) posToString( o[0], o[1] ) => true];
	// printErr( 'instructions $instructions  target $target' );
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

function simulate( memPositions:Array<Array<Int>>, startId:Int, endId:Int, instructions:Array<Array<Int>>, target:Array<Int>, obstaclesMap:Map<String, Bool> ) {
	var x = memPositions[startId][0];
	var y = memPositions[startId][1];
	var dx = memPositions[startId][2];
	var dy = memPositions[startId][3];
	// printErr( 'simulate from $startId-$endId $x:$y  ${instructions.slice( startId, endId )}' );
	for( i in startId...endId ) {
		final instruction = instructions[i];
		x += dx * instruction[0];
		y += dy * instruction[0];
		final theta = instruction[1] * 0.5 * Math.PI;
		final dx2 = Std.int( dx * Math.cos( theta ) - dy * Math.sin( theta ));
		final dy2 = Std.int( dx * Math.sin( theta ) + dy * Math.cos( theta ));
		dx = dx2;
		dy = dy2;
		
		final nextPosition = memPositions[i + 1];
		if( x == nextPosition[0] && y == nextPosition[1] && dx == nextPosition[2] && dy == nextPosition[3] ) return false;
		if( obstaclesMap.exists( posToString( x, y ))) return false;
		
		nextPosition[0] = x;
		nextPosition[1] = y;
		nextPosition[2] = dx;
		nextPosition[3] = dy;

		// printErr( 'instruction $instruction  nextPosition $nextPosition' );
	}

	return x == target[0] && y == target[1];
}



inline function posToString( x:Int, y:Int ) return '$x:$y';