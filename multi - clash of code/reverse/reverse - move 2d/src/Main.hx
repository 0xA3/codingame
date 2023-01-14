import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	var inputs = readline().split(' ');
	var x = parseInt(inputs[0]);
	var y = parseInt(inputs[1]);
	final n = parseInt(readline());
	for( _ in 0...n ) {
		var inputs = readline().split(' ');
		final dir = inputs[0];
		final dist = parseInt(inputs[1]);

		switch dir {
			case "N": y += dist;
			case "W": x -= dist;
			case "S": y -= dist;
			case "E": x += dist;
		}
	}
	
	print( '$x $y' );
}
