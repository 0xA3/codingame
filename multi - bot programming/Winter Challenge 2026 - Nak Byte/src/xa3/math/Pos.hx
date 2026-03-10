package xa3.math;

import xa3.math.IntMath.abs;
import xa3.math.IntMath.max;

class Pos {
	
	public static final NO_POS = new Pos( -1, -1 );

	public final x:Int;
	public final y:Int;

	public function new( x = 0, y = 0 ) {
		this.x = x;
		this.y = y;
	}

	public function manhattanDistance( other:Pos ) return abs( x - other.x ) + abs( y - other.y );
	public function chebyshevDistance( other:Pos ) return max( abs( x - other.x ), abs( y - other.y ));

	public function toString() return '$x:$y';
}
