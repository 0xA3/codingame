import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final a = parseInt( readline() );
	final b = parseInt( readline() );
	final m = parseInt( readline() );
	
	final result = process( a, b, m );
	print( result );
}

function process( a:Int, b:Int, m:Int ) {
	
	var direction = 0;
	var x = 0;
	var y = 0;

	var step = 0;
	for( _ in 0...500000) {
		direction = ( a * direction + b ) % m;
		switch direction % 4 {
			case 0: y--;
			case 1: y++;
			case 2: x--;
			case 3: x++;
		}
		step++;
		if( x == 0 && y == 0 ) break;
	}

	return step;
}
