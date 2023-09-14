import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;


@:keep function findCorrectPath( instructions:String, target:Array<Int>, obstacles:Array<Array<Int>> ) {
	
	final commands = ["F" => "FORWARD", "B" => "BACK", "L" => "TURN LEFT", "R" => "TURN RIGHT"];
	final types = ["F", "B", "L", "R"];
	final obstaclesMap = [for( o in obstacles ) posToString( o[0], o[1] ) => true];

	final instructionsList = instructions.split( "" );
	var memPositions = [for( _ in 0...instructionsList.length + 1 ) [0, 0, 1, 0]];
	var startId = 0;
	for( i in startId...instructions.length ) {
		final backup = instructionsList[i];
		for( type in types ) {
			if( type != backup ) {
				instructionsList[i] = type;
				// printErr( 'try replace instruction ${i + 1} with ${commands[type]}' );
				if( simulate( memPositions, startId, instructionsList.length, instructionsList, target, obstaclesMap )) return 'Replace instruction ${i + 1} with ${commands[type]}';
			}
		}
		instructionsList[i] = backup;
		simulate( memPositions, startId, startId + 1, instructionsList, target, obstaclesMap );
	startId++;
	}

	return "";
}

function simulate( memPositions:Array<Array<Int>>, startId:Int, endId:Int, instructions:Array<String>, target:Array<Int>, obstaclesMap:Map<String, Bool> ) {
	var x = memPositions[startId][0];
	var y = memPositions[startId][1];
	var dx = memPositions[startId][2];
	var dy = memPositions[startId][3];
	// printErr( 'simulate from $startId-$endId $x:$y  ${instructions.slice( startId, endId )}' );
	for( i in startId...endId ) {
		switch instructions[i] {
			case "F":
				x += dx;
				y += dy;
			case "B":
				x -= dx;
				y -= dy;
			case "L":
				switch [dx, dy] {
					case [1,0]:
						dx = 0;
						dy = 1;
					case [-1,0]:
						dx = 0;
						dy = -1;
					case [0,1]:
						dx = -1;
						dy = 0;
					case [0,-1]:
						dx = 1;
						dy = 0;
					default: // no-op
				}
			case "R":
			switch [dx, dy] {
				case [1,0]:
					dx = 0;
					dy = -1;
				case [-1,0]:
					dx = 0;
					dy = 1;
				case [0,1]:
					dx = 1;
					dy = 0;
				case [0,-1]:
					dx = -1;
					dy = 0;
				default: // no-op
			}
			default: // no-op
		}
		final nextPosition = memPositions[i + 1];
		if( x == nextPosition[0] && y == nextPosition[1] && dx == nextPosition[2] && dy == nextPosition[3] ) {
			return false;
		}
		if( obstaclesMap.exists( posToString( x, y ))) return false;
		
		nextPosition[0] = x;
		nextPosition[1] = y;
		nextPosition[2] = dx;
		nextPosition[3] = dy;
	}

	return x == target[0] && y == target[1];
}

inline function posToString( x:Int, y:Int ) return '$x:$y';