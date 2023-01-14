import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;

final positions = new List<Position>();

function main() {

	final r = parseInt( readline() );
	final c = parseInt( readline() );
	final t = parseInt( readline() );

	final result = process( r, c, t );
	print( result );
}

function process( rows:Int, columns:Int, threshold:Int ) {

	final visited = [for( _ in 0...rows * columns ) false];
	positions.add( { x: 0, y: 0 } );
	visited[0] = true;

	var total = 0;
	while( !positions.isEmpty() ) {
		final position = positions.pop();
		total++;

		final x = position.x;
		final y = position.y;
		final neighbors = [{ x: x - 1, y: y }, { x: x, y: y + 1 }, { x: x + 1, y: y }, { x: x, y: y - 1 }];
		for( n in neighbors ) {
			if( n.x >= 0 && n.x < columns && n.y >= 0 && n.y < rows && !visited[n.y * columns + n.x] && getSum( n.x, n.y ) <= threshold ) {
				visited[n.y * columns + n.x] = true;
				positions.add( { x: n.x, y: n.y } );
				// trace( 'add ${n.x}:${n.y}  sum ${getSum( n.x, n.y )}' );
			}
		}
	}
	return total;
}

function getSum( x:Int, y:Int ) {
	final digits = ( string( x ) + string( y ) ).split( "" ).map( s -> parseInt( s ) );
	return digits.fold( ( v, sum ) -> sum + v, 0 );
}

typedef Position = {
	final x:Int;
	final y:Int;
}
