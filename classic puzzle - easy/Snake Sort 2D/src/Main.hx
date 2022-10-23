import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline() );
	final apples = [for( i in 0...n ) {
		var inputs = readline().split(' ');
		 { name: inputs[0], y: parseInt( inputs[1] ), x: parseInt( inputs[2] ) }
	}];
			
	final result = process( apples );
	print( result );
}

function process( apples:Array<Apple> ) {
	
	final rowsWithApples = [];
	for( apple in apples ) if( !rowsWithApples.contains( apple.y )) rowsWithApples.push( apple.y );
	rowsWithApples.sort(( a, b ) -> a - b );

	apples.sort(( a, b ) -> {
		if( a.y < b.y ) return -1;
		if( a.y > b.y ) return 1;
		if( rowsWithApples.indexOf( a.y ) % 2 == 0 ) {
			if( a.x < b.x ) return -1;
			if( a.x > b.x ) return 1;
		} else {
			if( a.x < b.x ) return 1;
			if( a.x > b.x ) return -1;
		}
		return 0;
	});

	return apples.map( snake -> snake.name ).join( "," );
}

// function snakeToString( snake:Apple ) return '${snake.name} ${snake.x}:${snake.y}';

typedef Apple = {
	final name:String;
	final x:Int;
	final y:Int;
}