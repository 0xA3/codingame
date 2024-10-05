package data;

class Edge {
	
	public final id:String;
	public final p1:Point;
	public final p2:Point;
	public final length:Float;

	function new( id:String, p1:Point, p2:Point, length:Float ) {
		this.id = id;
		this.p1 = p1;
		this.p2 = p2;
		this.length = length;
	}

	public static function fromPoints( p1:Point, p2:Point ) {
		final dist1 = p1.x * p1.x + p1.y * p1.y;
		final dist2 = p2.x * p2.x + p2.y * p2.y;

		final edgeP1 = dist1 < dist2 ? p1 : p2;
		final edgeP2 = dist1 < dist2 ? p2 : p1;

		final id = '${edgeP1.x}:${edgeP1.y}-${edgeP2.x}:${edgeP2.y}';
		final length = edgeP1.distanceTo( edgeP2 );
		return new Edge( id, edgeP1, edgeP2, length );
	}

	public static function createId( p1:Point, p2:Point ) {
		final dist1 = p1.x * p1.x + p1.y * p1.y;
		final dist2 = p2.x * p2.x + p2.y * p2.y;

		final edgeP1 = dist1 < dist2 ? p1 : p2;
		final edgeP2 = dist1 < dist2 ? p2 : p1;

		final id = '${edgeP1.x}:${edgeP1.y}-${edgeP2.x}:${edgeP2.y}';
		return id;
	}

	function toString() return '${p1.x}:${p1.y}-${p2.x}:${p2.y}';

	function equals( other:Edge) {
		if( this == other ) return true;
		return 	( this.p1.equals( other.p1 ) && this.p2.equals( other.p2 )) ||
      			( this.p1.equals( other.p2 ) && this.p2.equals( other.p1 ));
	}

	static function orientation( p1:Point, p2:Point, p3:Point ) {
		final prod = ( p3.y - p1.y ) * ( p2.x - p1.x ) - ( p2.y - p1.y ) * ( p3.x - p1.x );
		return sign( prod );
	}

	public function intersects( other:Edge ) {
		return edgeIntersect( this, other );
	}

	static function edgeIntersect( s1:Edge, s2:Edge ) {
		final p1 = s1.p1;
		final p2 = s1.p2;
		final p3 = s2.p1;
		final p4 = s2.p2;
		return orientation( p1, p2, p3 ) * orientation( p1, p2, p4 ) < 0 &&
				orientation( p3, p4, p1 ) * orientation( p3, p4, p2 ) < 0;
	}

	static function sign( x:Float ) return x > 0 ? 1 : x < 0 ? -1 : 0;
}