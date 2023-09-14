import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

@:keep function findCorrectPath( instructions:Array<String>, target:Array<Int> ) {
	
	final types = ["FORWARD", "BACK", "TURN LEFT", "TURN RIGHT"];
	
	for( i in 0...instructions.length ) {
		final copy = instructions.copy();
		for( type in types ) {
			if( instructions[i] != type ) {
				copy[i] = type;
				printErr( 'try replace instruction ${i + 1} with $type' );
				if( simulate( copy, target )) return 'Replace instruction ${i + 1} with $type';
			}
		}
	}

	return "";
}

function simulate( instructions:Array<String>, target:Array<Int> ) {
	var x = 0;
	var y = 0;
	var dx = 1;
	var dy = 0;
	for( instruction in instructions ) {
		switch instruction {
			case "FORWARD":
				x += dx;
				y += dy;
			case "BACK":
				x -= dx;
				y -= dy;
				case "TURN LEFT":
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
				case "TURN RIGHT":
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
		// printErr( '$instruction  $x:$y  $dx:$dy' );
	}

	return x == target[0] && y == target[1];
}