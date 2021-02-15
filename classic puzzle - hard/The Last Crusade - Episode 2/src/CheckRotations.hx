import Math.abs;
import Std.int;

function checkRotations( tunnel:Tunnel, path:Array<Node> ) {
	
	var steps = 0;
	for( node in path ) {
		steps -= int( abs( node.diff ));
		// trace( '${tunnel.cells[node.index]} -> ${node.tile}   diff ${node.diff} steps $steps' );
		if( steps < 0 ) return false;
		steps++;
	}
	
	return true;
}
